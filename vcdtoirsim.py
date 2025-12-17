#!/usr/bin/env python3
"""
VCD to IRSIM Command Generator

Reads a VCD (Value Change Dump) file from a digital simulation and creates
an IRSIM command file with h/l/s commands to drive the simulation.

Usage:
    python vcdtoirsim.py <vcd_file> -s <signal1> [<signal2> ...] -o <output.cmd>

Example:
    python vcdtoirsim.py test.vcd -s "clk_irsim=clk" "rst_n_irsim=rst_n" -o commands.cmd
    
Signal mapping format:
    "irsim_node=vcd_signal"   - Map VCD signal to irsim node name
    "vcd_signal"              - Use sanitized signal name as irsim node
    "din[7:0]"                - Expand bus signal into individual bits
"""

import argparse
import re
from vcdvcd import VCDVCD


def parse_vcd(vcd_file):
    """
    Parse a VCD file using vcdvcd library and extract signal definitions and value changes.
    
    Returns:
        timescale: The timescale multiplier in seconds
        signals: Dict mapping signal name to signal name (for compatibility)
        changes: Dict mapping signal name to list of (time, value) tuples
        bus_info: Dict mapping bus signal name to (msb, lsb) tuple
    """
    vcd = VCDVCD(vcd_file)
    
    # Get timescale in seconds
    timescale = vcd.timescale.get('timescale', 1e-9)
    
    signals = {}  # signal_name -> signal_name
    changes = {}  # signal_name -> [(time, value), ...]
    bus_info = {}  # signal_name -> (msb, lsb)
    
    for signal_name in vcd.signals:
        signals[signal_name] = signal_name
        signal = vcd[signal_name]
        # signal.tv is a list of (time, value) tuples
        changes[signal_name] = [(t, v) for t, v in signal.tv]
        
        # Check if it's a bus signal (e.g., din[7:0])
        bus_match = re.search(r'\[(\d+):(\d+)\]$', signal_name)
        if bus_match:
            msb = int(bus_match.group(1))
            lsb = int(bus_match.group(2))
            bus_info[signal_name] = (msb, lsb)
    
    return timescale, signals, changes, bus_info


def expand_bus_to_bits(signal_name, changes, bus_info):
    """
    Expand a bus signal into individual bit signals.
    
    Args:
        signal_name: Name of the bus signal (e.g., "test.tb.din[7:0]")
        changes: List of (time, value) tuples for the bus
        bus_info: Dict with (msb, lsb) for bus signals
    
    Returns:
        Dict mapping bit signal names to their changes
        e.g., {"din[7]": [...], "din[6]": [...], ...}
    """
    if signal_name not in bus_info:
        return None
    
    msb, lsb = bus_info[signal_name]
    width = abs(msb - lsb) + 1
    
    # Extract base name without the bus range
    base_name = re.sub(r'\[\d+:\d+\]$', '', signal_name)
    
    # Initialize bit changes
    bit_changes = {}
    for i in range(lsb, msb + 1) if lsb <= msb else range(msb, lsb + 1):
        bit_name = f"{base_name}[{i}]"
        bit_changes[bit_name] = []
    
    # Process each transition
    for time, value in changes:
        # Pad value to full width
        if isinstance(value, str):
            # Handle 'x' and 'z' values
            val_str = value.replace('x', '0').replace('X', '0').replace('z', '0').replace('Z', '0')
            try:
                int_val = int(val_str, 2) if val_str else 0
            except ValueError:
                int_val = 0
        else:
            int_val = int(value)
        
        # Extract each bit
        for i in range(width):
            if lsb <= msb:
                bit_idx = lsb + i
            else:
                bit_idx = lsb - i
            bit_name = f"{base_name}[{bit_idx}]"
            bit_val = (int_val >> i) & 1
            bit_changes[bit_name].append((time, str(bit_val)))
    
    return bit_changes


def timescale_to_seconds(timescale):
    """Convert timescale to seconds multiplier. 
    With vcdvcd, timescale is already in seconds (as Decimal), so just convert to float."""
    from decimal import Decimal
    if isinstance(timescale, (int, float, Decimal)):
        return float(timescale)
    # Fallback for tuple format (value, unit)
    value, unit = timescale
    multipliers = {
        's': 1,
        'ms': 1e-3,
        'us': 1e-6,
        'ns': 1e-9,
        'ps': 1e-12,
        'fs': 1e-15
    }
    return value * multipliers.get(unit, 1e-9)


def sanitize_name(name):
    """Convert signal name to valid identifier."""
    # Replace problematic characters
    name = name.replace('.', '_')
    name = name.replace('[', '_')
    name = name.replace(']', '')
    name = name.replace('$', '_')
    # Ensure it starts with a letter
    if name and name[0].isdigit():
        name = 's_' + name
    return name


def find_matching_signals(signals, pattern):
    """Find signals matching a pattern (supports wildcards)."""
    matching = []
    
    # Convert glob pattern to regex
    regex_pattern = pattern.replace('.', r'\.')
    regex_pattern = regex_pattern.replace('[', r'\[')
    regex_pattern = regex_pattern.replace(']', r'\]')
    regex_pattern = regex_pattern.replace('*', '.*')
    regex_pattern = f'^.*{regex_pattern}$'  # Allow partial match anywhere in hierarchy
    
    for name in signals.keys():
        if re.match(regex_pattern, name, re.IGNORECASE):
            matching.append((name, name))
        # Also check just the signal name without hierarchy
        short_name = name.split('.')[-1]
        if re.match(regex_pattern, short_name, re.IGNORECASE):
            if (name, name) not in matching:
                matching.append((name, name))
    
    return matching


def get_value_at_time(changes, time):
    """
    Get the value of a signal at a specific time.
    Returns the most recent value at or before the given time.
    """
    if not changes:
        return '0'
    
    value = '0'  # Default value
    for t, v in changes:
        if t <= time:
            value = v
        else:
            break
    
    return value


def value_to_logic(value):
    """Convert VCD value to logic level (True=high, False=low)."""
    if value in ('1', 1):
        return True
    elif value in ('0', 0):
        return False
    elif isinstance(value, str) and value.lower() in ('x', 'z'):
        return False  # Treat undefined as low
    else:
        # Multi-bit value - treat as high if non-zero
        try:
            clean_val = value.replace('x', '0').replace('X', '0').replace('z', '0').replace('Z', '0')
            return int(clean_val, 2) != 0
        except:
            return False


def escape_brackets(name):
    """Escape brackets for IRSIM commands."""
    return name.replace('[', '\\[').replace(']', '\\]')


def generate_irsim_commands(vcd_file, signal_specs, output_file, timestep_ns=50):
    """
    Generate IRSIM command file from VCD file.
    
    Args:
        vcd_file: Path to VCD file
        signal_specs: List of "irsim_node=vcd_signal" or just "vcd_signal"
                      Use "node=0" or "node=1" for constant values
        output_file: Output command file path
        timestep_ns: Simulation timestep in nanoseconds (default: 50ns)
    """
    print(f"Parsing VCD file: {vcd_file}")
    timescale, signals, changes, bus_info = parse_vcd(vcd_file)
    time_mult = timescale_to_seconds(timescale)
    
    print(f"Timescale: {time_mult} seconds")
    print(f"Found {len(signals)} signals in VCD")
    
    # Parse signal specs: "irsim_node=pattern" or just "pattern"
    node_mappings = []  # List of (irsim_node, vcd_signal_name, changes)
    constant_high = []  # Nodes to set constant high
    constant_low = []   # Nodes to set constant low
    
    for spec in signal_specs:
        if '=' in spec:
            irsim_node, pattern = spec.split('=', 1)
            
            # Check if this is a constant value assignment (node=0 or node=1)
            if pattern == '0':
                print(f"  Node '{irsim_node}' <- constant LOW")
                constant_low.append(irsim_node)
                continue
            elif pattern == '1':
                print(f"  Node '{irsim_node}' <- constant HIGH")
                constant_high.append(irsim_node)
                continue
        else:
            irsim_node = None
            pattern = spec
        
        # Check if this is a request to expand a bus
        expand_match = re.search(r'\[(\d+):(\d+)\]$', pattern)
        
        matches = find_matching_signals(signals, pattern)
        
        if not matches:
            print(f"  Warning: Pattern '{pattern}' matched no signals")
            continue
        
        if len(matches) > 1:
            print(f"  Duplicate matches for '{pattern}':")
            for m in matches:
                print(f"    - {m[1]}")
            print(f"  -> Using last match: {matches[-1][1]}")
        
        # Use the last match in case of duplicates
        vcd_signal = matches[-1][0]
        
        # Check if this is a bus signal that should be expanded
        if vcd_signal in bus_info and expand_match:
            msb, lsb = bus_info[vcd_signal]
            print(f"  Expanding bus '{vcd_signal}' into individual bits [{msb}:{lsb}]")
            
            bit_changes = expand_bus_to_bits(vcd_signal, changes.get(vcd_signal, []), bus_info)
            
            # Add each bit as a separate node (MSB first)
            if msb >= lsb:
                bit_range = range(msb, lsb - 1, -1)
            else:
                bit_range = range(msb, lsb + 1)
            
            base_name = re.sub(r'\[\d+:\d+\]$', '', vcd_signal)
            leaf_base = base_name.split('.')[-1]
            
            for bit_idx in bit_range:
                bit_signal = f"{base_name}[{bit_idx}]"
                if irsim_node:
                    # User specified a base node name, add bit index
                    bit_node_name = f"{irsim_node}[{bit_idx}]"
                else:
                    bit_node_name = f"{leaf_base}[{bit_idx}]"
                
                print(f"    Node '{bit_node_name}' <- bit [{bit_idx}]")
                node_mappings.append((bit_node_name, bit_signal, bit_changes.get(bit_signal, [])))
        else:
            # Single signal (not expanding)
            if irsim_node is None:
                # Use just the leaf name without hierarchy
                irsim_node = sanitize_name(vcd_signal.split('.')[-1])
            
            print(f"  Node '{irsim_node}' <- VCD signal '{vcd_signal}'")
            node_mappings.append((irsim_node, vcd_signal, changes.get(vcd_signal, [])))
    
    if not node_mappings and not constant_high and not constant_low:
        print("Error: No signals matched. Available signals:")
        for name in sorted(signals.keys()):
            print(f"  {name}")
        return
    
    # Find the end time of the simulation (in VCD time units)
    end_time = 0
    for _, _, signal_changes in node_mappings:
        for t, _ in signal_changes:
            if t > end_time:
                end_time = t
    
    # Convert timestep to VCD time units
    timestep_seconds = timestep_ns * 1e-9
    timestep_vcd_units = int(timestep_seconds / time_mult)
    
    print(f"Timestep: {timestep_ns}ns = {timestep_vcd_units} VCD units")
    print(f"Simulation end time: {end_time} VCD units = {end_time * time_mult * 1e9:.1f}ns")
    
    # Generate commands
    commands = []
    
    # Track previous state for each node to detect changes
    prev_state = {}
    
    # Start at t=0 and step through in increments of timestep_vcd_units
    current_time = 0
    timestep_count = 0
    
    while current_time <= end_time:
        # Sample at the middle of the timestep period
        sample_time = current_time + timestep_vcd_units // 2
        
        high_nodes = []
        low_nodes = []
        
        # Always set Vdd high and Gnd low at every timestep
        high_nodes.append('Vdd')
        low_nodes.append('Gnd')
        
        # Add constant nodes at initial timestep only
        if timestep_count == 0:
            high_nodes.extend(constant_high)
            low_nodes.extend(constant_low)
        
        for irsim_node, vcd_signal, signal_changes in node_mappings:
            # Get value at sample time
            value = get_value_at_time(signal_changes, sample_time)
            is_high = value_to_logic(value)
            
            # Check if this is the initial timestep or if state has changed
            if timestep_count == 0:
                # Initial timestep: assert all nodes
                if is_high:
                    high_nodes.append(irsim_node)
                else:
                    low_nodes.append(irsim_node)
                prev_state[irsim_node] = is_high
            else:
                # Subsequent timesteps: only assert if changed
                if irsim_node not in prev_state or prev_state[irsim_node] != is_high:
                    if is_high:
                        high_nodes.append(irsim_node)
                    else:
                        low_nodes.append(irsim_node)
                    prev_state[irsim_node] = is_high
        
        # Add commands for this timestep
        if high_nodes:
            escaped_high = [escape_brackets(n) for n in high_nodes]
            commands.append(f"h {' '.join(escaped_high)}")
        if low_nodes:
            escaped_low = [escape_brackets(n) for n in low_nodes]
            commands.append(f"l {' '.join(escaped_low)}")
        
        # Step simulation
        commands.append("s")
        
        current_time += timestep_vcd_units
        timestep_count += 1
    
    # Write output file
    with open(output_file, 'w') as f:
        f.write(f"| IRSIM commands generated from VCD file: {vcd_file}\n")
        f.write(f"| Timestep: {timestep_ns}ns\n")
        f.write(f"| Signals: {len(node_mappings)}\n")
        f.write(f"| Total timesteps: {timestep_count}\n")
        f.write("|\n")
        f.write(f"stepsize {timestep_ns}\n")
        f.write("settle 50\n")
        f.write("relax l\n")
        f.write("vector A A\\[3:0\\]\n")
        
        for cmd in commands:
            f.write(cmd + "\n")
    
    print(f"\nGenerated IRSIM command file: {output_file}")
    print(f"Total timesteps: {timestep_count}")
    print(f"Total commands: {len(commands)}")


def main():
    parser = argparse.ArgumentParser(
        description='Convert VCD traces to IRSIM commands (h/l/s)',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
    %(prog)s test.vcd -s clk rst_n -o commands.cmd
    %(prog)s test.vcd -s "irsim_clk=clk" "irsim_rst=rst_n" -o commands.cmd
    %(prog)s test.vcd -s "din[7:0]" -o commands.cmd   # Expands bus
    %(prog)s sim.vcd -s clk "din[7:0]" rst_n -o commands.cmd
    
Signal format:
    pattern              - Use sanitized signal name as irsim node
    irsim_node=pattern   - Map VCD signal to custom irsim node name
    irsim_node=0         - Set node to constant LOW at start
    irsim_node=1         - Set node to constant HIGH at start
    signal[M:L]          - Expand bus signal into individual bits
    
Commands generated:
    h <nodes>  - Set nodes high
    l <nodes>  - Set nodes low
    s          - Step simulation by timestep (50ns)
    
Notes:
    - Samples at the middle of each 50ns period
    - Only asserts nodes when their state changes (except at t=0)
    - Always sets Vdd high and Gnd low at every timestep
        """
    )
    
    parser.add_argument('vcd_file', help='Input VCD file')
    parser.add_argument('-s', '--signals', nargs='+', required=True,
                        help='Signal specs: "pattern" or "irsim_node=pattern". Bus signals like din[7:0] are expanded.')
    parser.add_argument('-o', '--output', required=True,
                        help='Output IRSIM command file')
    parser.add_argument('--timestep', type=int, default=50,
                        help='Simulation timestep in nanoseconds (default: 50ns)')
    parser.add_argument('--list', action='store_true',
                        help='List all signals in VCD file and exit')
    
    args = parser.parse_args()
    
    if args.list:
        timescale, signals, changes, bus_info = parse_vcd(args.vcd_file)
        print(f"Signals in {args.vcd_file}:")
        for name in sorted(signals.keys()):
            num_changes = len(changes.get(name, []))
            bus_str = ""
            if name in bus_info:
                msb, lsb = bus_info[name]
                bus_str = f" [bus {msb}:{lsb}]"
            print(f"  {name} ({num_changes} transitions){bus_str}")
        return
    
    generate_irsim_commands(
        args.vcd_file,
        args.signals,
        args.output,
        timestep_ns=args.timestep
    )


if __name__ == '__main__':
    main()
