#!/usr/bin/env python3
"""
SPICE Circuit to Graphviz Converter

Parses a SPICE netlist with resistors and transistors and generates a Graphviz DOT file for visualization.

Usage:
    python resistor_to_graphviz.py <input.txt> -o <output.dot>
    dot -Tpng output.dot -o output.png
"""

import argparse
import re


def parse_netlist(input_file):
    """
    Parse SPICE netlist for resistors and transistors.
    
    Returns:
        resistors: List of (name, node1, node2, params) tuples
        transistors: List of (name, drain, gate, source, body, params) tuples
    """
    resistors = []
    transistors = []
    
    with open(input_file, 'r') as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('*'):
                continue
            
            parts = line.split()
            if len(parts) < 4:
                continue
            
            name = parts[0]
            
            # Extract w and l parameters
            length = None
            width = None
            for part in parts:
                if part.startswith('l='):
                    length = float(part.split('=')[1])
                elif part.startswith('w='):
                    width = float(part.split('=')[1])
            
            # Check if it's a transistor (nfet or pfet)
            is_transistor = any('nfet' in p or 'pfet' in p for p in parts)
            
            if is_transistor:
                # Transistor format: Xname drain gate source body model ...
                if len(parts) >= 5:
                    drain = parts[1]
                    gate = parts[2]
                    source = parts[3]
                    body = parts[4]
                    is_pmos = any('pfet' in p for p in parts)
                    transistors.append((name, drain, gate, source, body, {'l': length, 'w': width, 'pmos': is_pmos}))
            elif 'res' in line.lower():
                # Resistor format: Xname node1 node2 model w=... l=...
                node1 = parts[1]
                node2 = parts[2]
                resistors.append((name, node1, node2, {'l': length, 'w': width}))
    
    return resistors, transistors


def sanitize_node_name(name):
    """Convert node name to valid graphviz identifier."""
    # Replace problematic characters
    sanitized = name.replace('#', '_')
    sanitized = sanitized.replace('[', '_')
    sanitized = sanitized.replace(']', '_')
    sanitized = sanitized.replace('-', 'n')
    sanitized = sanitized.replace('/', '_')
    return sanitized


def generate_dot(resistors, transistors, output_file, show_values=True):
    """
    Generate Graphviz DOT file from circuit.
    """
    # Collect all unique nodes
    nodes = set()
    for name, node1, node2, params in resistors:
        nodes.add(node1)
        nodes.add(node2)
    for name, drain, gate, source, body, params in transistors:
        nodes.add(drain)
        nodes.add(gate)
        nodes.add(source)
        nodes.add(body)
    
    # Identify special nodes (power, ground, output)
    special_nodes = {}
    for node in nodes:
        node_upper = node.upper()
        if 'VDD' in node_upper or node_upper == 'VDD':
            special_nodes[node] = 'VDD'
        elif 'GND' in node_upper or node_upper == 'GND':
            special_nodes[node] = 'GND'
        elif 'VOUT' in node_upper or node_upper == 'VOUT':
            special_nodes[node] = 'Vout'
    
    with open(output_file, 'w') as f:
        f.write('digraph circuit {\n')
        f.write('    // Graph settings\n')
        f.write('    rankdir=TB;\n')
        f.write('    node [shape=point, width=0.1];\n')
        f.write('    edge [fontsize=8];\n')
        f.write('\n')
        
        # Define special nodes with labels
        f.write('    // Special nodes (power, ground, output)\n')
        for node, label in special_nodes.items():
            san_node = sanitize_node_name(node)
            if label == 'VDD':
                f.write(f'    {san_node} [shape=invtriangle, label="{label}", width=0.3, height=0.3, style=filled, fillcolor=red];\n')
            elif label == 'GND':
                f.write(f'    {san_node} [shape=triangle, label="{label}", width=0.3, height=0.3, style=filled, fillcolor=black, fontcolor=white];\n')
            elif label == 'Vout':
                f.write(f'    {san_node} [shape=circle, label="{label}", width=0.4, style=filled, fillcolor=green];\n')
        f.write('\n')
        
        # Define resistor edges
        f.write('    // Resistors\n')
        for name, node1, node2, params in resistors:
            san_node1 = sanitize_node_name(node1)
            san_node2 = sanitize_node_name(node2)
            
            if show_values and params.get('l'):
                # Show resistor name, width and length
                w_str = f'w={params["w"]:.2f}' if params.get('w') else ''
                l_str = f'l={params["l"]:.2f}' if params.get('l') else ''
                label = f'{name}\\n{w_str} {l_str}'.strip()
            else:
                label = name
            
            f.write(f'    {san_node1} -> {san_node2} [label="{label}", dir=none, color=brown];\n')
        
        f.write('\n')
        
        # Define transistor nodes and edges
        f.write('    // Transistors\n')
        for name, drain, gate, source, body, params in transistors:
            san_drain = sanitize_node_name(drain)
            san_gate = sanitize_node_name(gate)
            san_source = sanitize_node_name(source)
            san_body = sanitize_node_name(body)
            san_name = sanitize_node_name(name)
            
            # Create a node for the transistor itself
            is_pmos = params.get('pmos', False)
            color = 'lightblue' if is_pmos else 'lightyellow'
            ttype = 'PMOS' if is_pmos else 'NMOS'
            
            if show_values:
                w_str = f'w={params["w"]:.2f}' if params.get('w') else ''
                l_str = f'l={params["l"]:.2f}' if params.get('l') else ''
                label = f'{name}\\n{ttype}\\n{w_str} {l_str}'.strip()
            else:
                label = f'{name}\\n{ttype}'
            
            f.write(f'    {san_name} [shape=box, label="{label}", style=filled, fillcolor={color}];\n')
            
            # Connect drain, gate, source to transistor
            f.write(f'    {san_drain} -> {san_name} [label="D", color=blue];\n')
            f.write(f'    {san_gate} -> {san_name} [label="G", color=red, style=dashed];\n')
            f.write(f'    {san_name} -> {san_source} [label="S", color=blue];\n')
        
        f.write('}\n')
    
    print(f"Generated DOT file: {output_file}")
    print(f"Total resistors: {len(resistors)}")
    print(f"Total transistors: {len(transistors)}")
    print(f"Total nodes: {len(nodes)}")
    print(f"\nTo render as PNG:")
    print(f"  dot -Tpng {output_file} -o {output_file.replace('.dot', '.png')}")
    print(f"\nTo render as SVG (better for large graphs):")
    print(f"  dot -Tsvg {output_file} -o {output_file.replace('.dot', '.svg')}")
    print(f"\nAlternative layouts for large graphs:")
    print(f"  neato -Tpng {output_file} -o {output_file.replace('.dot', '_neato.png')}")
    print(f"  fdp -Tpng {output_file} -o {output_file.replace('.dot', '_fdp.png')}")


def main():
    parser = argparse.ArgumentParser(
        description='Convert SPICE netlist (resistors + transistors) to Graphviz DOT format',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
    %(prog)s resistor_ladder.txt -o resistor_ladder.dot
    %(prog)s resistor_ladder.txt -o resistor_ladder.dot --no-values
    
Then render with:
    dot -Tpng resistor_ladder.dot -o resistor_ladder.png
    dot -Tsvg resistor_ladder.dot -o resistor_ladder.svg
        """
    )
    
    parser.add_argument('input_file', help='Input SPICE netlist file')
    parser.add_argument('-o', '--output', required=True,
                        help='Output DOT file')
    parser.add_argument('--no-values', action='store_true',
                        help='Do not show w/l values on edges')
    
    args = parser.parse_args()
    
    resistors, transistors = parse_netlist(args.input_file)
    generate_dot(resistors, transistors, args.output, show_values=not args.no_values)


if __name__ == '__main__':
    main()
