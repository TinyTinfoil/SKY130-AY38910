#!/usr/bin/env python3
"""
VCD to SPICE PWL Converter

Reads a VCD (Value Change Dump) file from a digital simulation and creates
a SPICE subcircuit with PWL (Piecewise Linear) voltage sources for specified traces.

Usage:
    python vcdtospice.py <vcd_file> -s <signal1> [<signal2> ...] -o <output.spice> [--vdd <voltage>] [--subckt <name>]

Example:
    python vcdtospice.py test.vcd -s clk data_in[0] data_in[1] -o stimulus.spice --vdd 1.8 --subckt test_stimulus
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


def value_to_voltage(value, vdd):
    """Convert VCD value to voltage."""
    if value in ('1', 1):
        return vdd
    elif value in ('0', 0):
        return 0.0
    elif value.lower() in ('x', 'z'):
        return vdd / 2  # Undefined/high-Z as mid-rail
    else:
        # Multi-bit value - convert to integer then normalize
        try:
            # Remove any x or z, treat as 0
            clean_val = value.replace('x', '0').replace('X', '0').replace('z', '0').replace('Z', '0')
            return vdd if int(clean_val, 2) else 0.0
        except:
            return 0.0


def generate_pwl(signal_name, changes, timescale, vdd, rise_time=10e-12):
    """
    Generate PWL voltage source string for a signal.
    
    Args:
        signal_name: Name for the voltage source
        changes: List of (time, value) tuples
        timescale: Timescale multiplier in seconds
        vdd: Supply voltage
        rise_time: Rise/fall time for transitions
    
    Returns:
        PWL voltage source definition string
    """
    if not changes:
        return f"V{signal_name} {signal_name} 0 DC 0\n"
    
    pwl_points = []
    time_mult = timescale
    
    # Sort changes by time
    sorted_changes = sorted(changes, key=lambda x: x[0])
    
    # Add initial point at t=0 if first change isn't at t=0
    if sorted_changes[0][0] != 0:
        pwl_points.append((0, 0.0))
    
    for i, (time, value) in enumerate(sorted_changes):
        voltage = value_to_voltage(value, vdd)
        time_sec = time * time_mult
        # Round to nearest nanosecond
        time_ns = round(time_sec * 1e9)
        time_sec = time_ns * 1e-9
        
        # Add point just before transition (for sharp edge)
        if pwl_points and time_sec > pwl_points[-1][0]:
            # Add a point at (time - 1ns) with previous voltage
            prev_voltage = pwl_points[-1][1]
            prev_time_ns = round(pwl_points[-1][0] * 1e9)
            if time_ns - 1 > prev_time_ns:
                pwl_points.append(((time_ns - 1) * 1e-9, prev_voltage))
        
        pwl_points.append((time_sec, voltage))
    
    # Format PWL string with time in integer nanoseconds
    pwl_str = f"V{signal_name} {signal_name} 0 pwl(\n"
    for t, v in pwl_points:
        time_ns = round(t * 1e9)  # Convert to integer nanoseconds
        pwl_str += f"+    {time_ns}n {v:.6g}\n"
    pwl_str += "+    )\n"
    
    return pwl_str


def sanitize_name(name):
    """Convert signal name to valid SPICE identifier."""
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


def generate_spice_subcircuit(vcd_file, signal_specs, output_file, vdd=1.8, subckt_name='test_core', rise_time=10e-12):
    """
    Generate a SPICE subcircuit with PWL sources from VCD file.
    
    Args:
        vcd_file: Path to VCD file
        signal_specs: List of "pin_name=signal_pattern" or just "signal_pattern" (pin name = signal name)
                      Use "din[7:0]" to expand a bus into individual bits din[7], din[6], ..., din[0]
        output_file: Output SPICE file path
        vdd: Supply voltage
        subckt_name: Name for the subcircuit
        rise_time: Rise/fall time for transitions
    """
    print(f"Parsing VCD file: {vcd_file}")
    timescale, signals, changes, bus_info = parse_vcd(vcd_file)
    time_mult = timescale_to_seconds(timescale)
    
    print(f"Timescale: {time_mult} seconds")
    print(f"Found {len(signals)} signals in VCD")
    
    # Parse signal specs: "pin_name=pattern" or just "pattern"
    # The order and names from args define the subcircuit port order and names
    pin_mappings = []  # List of (pin_name, vcd_signal_name, changes)
    
    for spec in signal_specs:
        if '=' in spec:
            pin_name, pattern = spec.split('=', 1)
        else:
            pin_name = None
            pattern = spec
        
        # Check if this is a request to expand a bus (e.g., "din[7:0]" or "din[7:0]")
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
            
            # Add each bit as a separate pin (MSB first)
            if msb >= lsb:
                bit_range = range(msb, lsb - 1, -1)
            else:
                bit_range = range(msb, lsb + 1)
            
            base_name = re.sub(r'\[\d+:\d+\]$', '', vcd_signal)
            leaf_base = base_name.split('.')[-1]
            
            for bit_idx in bit_range:
                bit_signal = f"{base_name}[{bit_idx}]"
                if pin_name:
                    # User specified a base pin name, add bit index
                    bit_pin_name = f"{pin_name}[{bit_idx}]"
                else:
                    bit_pin_name = f"{leaf_base}[{bit_idx}]"
                
                print(f"    Pin '{bit_pin_name}' <- bit [{bit_idx}]")
                pin_mappings.append((bit_pin_name, bit_signal, bit_changes.get(bit_signal, [])))
        else:
            # Single signal (not expanding)
            if pin_name is None:
                # Use just the leaf name without hierarchy
                pin_name = sanitize_name(vcd_signal.split('.')[-1])
            
            print(f"  Pin '{pin_name}' <- VCD signal '{vcd_signal}'")
            pin_mappings.append((pin_name, vcd_signal, changes.get(vcd_signal, [])))
    
    if not pin_mappings:
        print("Error: No signals matched. Available signals:")
        for name in sorted(signals.keys()):
            print(f"  {name}")
        return
    
    # Generate output
    with open(output_file, 'w') as f:
        f.write(f"* SPICE subcircuit generated from VCD file: {vcd_file}\n")
        f.write(f"* Timescale: {time_mult} seconds\n")
        f.write(f"* VDD: {vdd}V\n")
        f.write(f"* Signals: {len(pin_mappings)}\n")
        f.write(f"*\n\n")
        
        # Build port list from pin names in order
        port_list = ' '.join(pin_name for pin_name, _, _ in pin_mappings)
        
        f.write(f".subckt {subckt_name} {port_list}\n\n")
        
        # Generate PWL source for each signal
        for pin_name, vcd_signal, signal_changes in pin_mappings:
            f.write(f"* Pin: {pin_name} <- VCD: {vcd_signal}\n")
            pwl_source = generate_pwl(pin_name, signal_changes, time_mult, vdd, rise_time)
            f.write(pwl_source)
            f.write("\n")
        
        f.write(f".ends {subckt_name}\n")
    
    print(f"\nGenerated SPICE file: {output_file}")
    print(f"Subcircuit '{subckt_name}' with ports: {port_list}")


def main():
    parser = argparse.ArgumentParser(
        description='Convert VCD traces to SPICE PWL voltage sources in a subcircuit',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
    %(prog)s test.vcd -s clk rst_n -o stimulus.spice
    %(prog)s test.vcd -s "my_clk=clk" "my_rst=rst_n" -o stimulus.spice
    %(prog)s test.vcd -s "din[7:0]" -o stim.spice   # Expands bus to din_7, din_6, ..., din_0
    %(prog)s test.vcd -s "d=din[7:0]" -o stim.spice  # Expands to d_7, d_6, ..., d_0
    %(prog)s sim.vcd -s clk "din[7:0]" rst_n -o stim.spice --subckt my_stimulus
    
Signal format:
    pattern          - Use signal name as pin name (sanitized)
    pin_name=pattern - Use custom pin name for the signal
    signal[M:L]      - Expand bus signal into individual bits (MSB to LSB order)
        """
    )
    
    parser.add_argument('vcd_file', help='Input VCD file')
    parser.add_argument('-s', '--signals', nargs='+', required=True,
                        help='Signal specs: "pattern" or "pin_name=pattern". Bus signals like din[7:0] are expanded.')
    parser.add_argument('-o', '--output', required=True,
                        help='Output SPICE file')
    parser.add_argument('--vdd', type=float, default=1.8,
                        help='Supply voltage (default: 1.8V)')
    parser.add_argument('--subckt', default='vcd_stimulus',
                        help='Subcircuit name (default: vcd_stimulus)')
    parser.add_argument('--rise-time', type=float, default=10e-12,
                        help='Rise/fall time in seconds (default: 10ps)')
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
    
    generate_spice_subcircuit(
        args.vcd_file,
        args.signals,
        args.output,
        vdd=args.vdd,
        subckt_name=args.subckt,
        rise_time=args.rise_time
    )


if __name__ == '__main__':
    main()
