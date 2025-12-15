#!/usr/bin/env python3
"""
Extract PWL (piece-wise linear) changes from SPICE files.
Identifies discontinuous timesteps where signal values change.
"""

import re
import sys
from pathlib import Path
from typing import List, Dict, Tuple


def parse_pwl_file(filepath: str) -> Dict[str, List[Tuple[float, float]]]:
    """
    Parse a SPICE file and extract all PWL statements.
    
    Args:
        filepath: Path to the SPICE file
        
    Returns:
        Dictionary mapping signal names to list of (time, value) tuples
    """
    pwl_data = {}
    
    with open(filepath, 'r') as f:
        content = f.read()
    
    # Find all PWL statements (pattern: source_name ... pwl(...))
    # Match lines like: Vclk clk 0 pwl(
    pwl_pattern = r'V(\w+)\s+\w+\s+\d+\s+pwl\s*\('
    
    # Split content to find each PWL block
    lines = content.split('\n')
    i = 0
    while i < len(lines):
        match = re.match(pwl_pattern, lines[i])
        if match:
            signal_name = match.group(1)
            # Collect all lines until we find the closing parenthesis
            pwl_lines = []
            i += 1
            while i < len(lines):
                line = lines[i].strip()
                if ')' in line:
                    # Extract remaining data before closing paren
                    data_part = line[:line.index(')')]
                    if data_part.startswith('+'):
                        data_part = data_part[1:].strip()
                    if data_part:
                        pwl_lines.append(data_part)
                    break
                if line.startswith('+'):
                    pwl_lines.append(line[1:].strip())
                elif line:
                    pwl_lines.append(line)
                i += 1
            
            # Parse the time-value pairs
            time_value_pairs = []
            for line in pwl_lines:
                # Split by whitespace and extract time-value pairs
                tokens = line.split()
                for j in range(0, len(tokens), 2):
                    if j + 1 < len(tokens):
                        try:
                            time_str = tokens[j]
                            value_str = tokens[j + 1]
                            time = convert_time(time_str)
                            value = float(value_str)
                            time_value_pairs.append((time, value))
                        except (ValueError, IndexError):
                            pass
            
            if time_value_pairs:
                pwl_data[signal_name] = time_value_pairs
        
        i += 1
    
    return pwl_data


def convert_time(time_str: str) -> float:
    """
    Convert time string with units to float in seconds.
    
    Args:
        time_str: Time string like "50n", "1u", "100p", etc.
        
    Returns:
        Time in seconds as float
    """
    time_str = time_str.strip()
    multipliers = {
        'p': 1e-12,
        'n': 1e-9,
        'u': 1e-6,
        'm': 1e-3,
        '': 1,
    }
    
    for unit, mult in multipliers.items():
        if time_str.endswith(unit):
            try:
                num = float(time_str[:-len(unit)] if unit else time_str)
                return num * mult
            except ValueError:
                pass
    
    try:
        return float(time_str)
    except ValueError:
        return 0.0


def extract_discontinuities(pwl_data: Dict[str, List[Tuple[float, float]]]) -> set:
    """
    Extract all PWL timesteps as discontinuities (breakpoints for simulator).
    Excludes the first (time=0) and last timestep from each signal.
    
    Args:
        pwl_data: Dictionary of signal names to time-value pairs
        
    Returns:
        Set of all unique timesteps (excluding first and last)
    """
    all_times = set()
    
    for signal, time_values in pwl_data.items():
        # Extract all timesteps except first (index 0) and last (index -1)
        if len(time_values) > 2:
            for i in range(1, len(time_values) - 1):
                all_times.add(time_values[i][0])  # Add just the time
    
    return all_times


def print_results(pwl_data: Dict[str, List[Tuple[float, float]]], 
                  all_times: set):
    """Print PWL data and timesteps in readable format."""
    
    print("=" * 80)
    print("PWL EXTRACTION SUMMARY")
    print("=" * 80)
    print(f"\nFound {len(pwl_data)} PWL sources\n")
    print(f"Total unique breakpoints: {len(all_times)}")
    
    for signal in sorted(pwl_data.keys()):
        time_values = pwl_data[signal]
        
        print(f"\n{'─' * 80}")
        print(f"Signal: {signal}")
        print(f"Total timesteps: {len(time_values)}")
        print(f"Breakpoints (excluding first/last): {len(time_values) - 2 if len(time_values) > 2 else 0}")
        
        # Show first few timesteps
        print(f"\nFirst 10 timesteps:")
        print(f"  {'Time (s)':<15} {'Value':<12}")
        print(f"  {'-' * 27}")
        for time, value in time_values[:10]:
            print(f"  {time:<15.12e} {value:<12.1f}")


def format_time_with_unit(time_seconds: float) -> str:
    """Convert time in seconds to appropriate unit string."""
    if time_seconds == 0:
        return "0s"
    
    abs_time = abs(time_seconds)
    if abs_time >= 1:
        return f"{time_seconds:.12g}s"
    elif abs_time >= 1e-3:
        return f"{time_seconds * 1e3:.12g}ms"
    elif abs_time >= 1e-6:
        return f"{time_seconds * 1e6:.12g}us"
    elif abs_time >= 1e-9:
        return f"{time_seconds * 1e9:.12g}ns"
    else:
        return f"{time_seconds * 1e12:.12g}ps"


def save_timeint_breakpoints(all_times: set, output_file: str):
    """Save timesteps as OPTIONS TIMEINT BREAKPOINTS format."""
    
    # Sort timesteps
    sorted_times = sorted(all_times)
    
    # Format breakpoints
    breakpoints = ",".join(format_time_with_unit(t) for t in sorted_times)
    
    # Create OPTIONS line
    options_line = f"OPTIONS TIMEINT BREAKPOINTS={breakpoints}"
    
    with open(output_file, 'w') as f:
        f.write(options_line)
    
    print(f"\nResults saved to: {output_file}")
    print(f"\nBreakpoints ({len(sorted_times)} total, excluding first and last):")
    print(options_line[:200] + "..." if len(options_line) > 200 else options_line)


def main():
    if len(sys.argv) < 2:
        print("Usage: python extract_pwl_timesteps.py <spice_file> [output.txt]")
        print("\nExample: python extract_pwl_timesteps.py test_core.spice breakpoints.txt")
        sys.exit(1)
    
    spice_file = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) > 2 else None
    
    if not Path(spice_file).exists():
        print(f"Error: File '{spice_file}' not found")
        sys.exit(1)
    
    print(f"Parsing: {spice_file}")
    pwl_data = parse_pwl_file(spice_file)
    all_times = extract_discontinuities(pwl_data)
    
    print_results(pwl_data, all_times)
    
    if output_file:
        save_timeint_breakpoints(all_times, output_file)


if __name__ == "__main__":
    main()
