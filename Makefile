filename = src/top
pcf_file = fpga/iceBlinkPico.pcf

build:
	yosys -p "synth_ice40 -top top -json $(filename).json -spram" $(filename).sv
	nextpnr-ice40 --up5k --package sg48 --json $(filename).json --pcf $(pcf_file) --asc $(filename).asc
	icepack $(filename).asc $(filename).bin

prog: #for sram
	sudo chmod -R 777 /dev/bus/usb/ #for WSL
	dfu-util --device 1d50:6146 --alt 0 -D $(filename).bin -R

clean:
	rm -rf $(filename).blif $(filename).asc $(filename).json $(filename).bin

sim: sim-refresh
	gtkwave tb/$(filename).vcd &

sim-refresh:
	iverilog -g2012 -o tb/$(filename).tb tb/$(filename)_tb.sv
	vvp tb/$(filename).tb
	mv $(filename).vcd tb/$(filename).vcd

sim-post: sim-post-refresh
	gtkwave tb/$(filename).vcd &

sim-post-refresh:
	yosys -p "read_json $(filename).json; write_verilog $(filename)_syn.v"
	iverilog -g2012 -o tb/$(filename)_syn.tb tb/$(filename)_tb_syn.sv /usr/share/yosys/ice40/cells_sim.v
	vvp tb/$(filename)_syn.tb
	mv $(filename).vcd tb/$(filename).vcd

pnr-gui:
	nextpnr-ice40 --json $(filename).json --pcf $(pcf_file) --asc $(filename).asc --up5k --package sg48 --gui

build-asic:
	nix-shell ~/librelane/shell.nix
	librelane config.yaml

clean-asic:
	rm -rf runs/