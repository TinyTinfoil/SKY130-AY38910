filename_fpga_fpga = src/top
pcf_file = fpga/iceBlinkPico.pcf
src_files = src/digital_core.sv
############################# FPGA flow
build:
	yosys -p "synth_ice40 -top top -json $(filename_fpga).json -spram" $(filename_fpga).sv
	nextpnr-ice40 --up5k --package sg48 --json $(filename_fpga).json --pcf $(pcf_file) --asc $(filename_fpga).asc
	icepack $(filename_fpga).asc $(filename_fpga).bin

prog: #for sram
	sudo chmod -R 777 /dev/bus/usb/ #for WSL
	dfu-util --device 1d50:6146 --alt 0 -D $(filename_fpga).bin -R

clean: clean-asic clean-verilog clean-irsim
	rm -rf $(filename_fpga).blif $(filename_fpga).asc $(filename_fpga).json $(filename_fpga).bin

pnr-gui:
	nextpnr-ice40 --json $(filename_fpga).json --pcf $(pcf_file) --asc $(filename_fpga).asc --up5k --package sg48 --gui

############################# ASIC flow
build-asic:
	nix-shell ~/librelane/shell.nix --run "librelane config.yaml --save-views-to asic/"

clean-asic:
	rm -rf runs/

clean-asic-full:
	rm -rf asic/

gui-asic:
	nix-shell ~/librelane/shell.nix --run "openroad -gui asic/odb/jt49.odb"

view-asic:
	cd asic/mag && magic jt49_bus.mag &
############################# Verilog testbench flow
test.vcd:
	iverilog -g2012 -o verilog.tb test/test.sv $(src_files)
	vvp verilog.tb

view-verilog: test.vcd
	gtkwave test.vcd &

clean-verilog:
	rm -rf verilog.tb test.vcd
############################ Xschem testbench
view-xschem:
	cd xschem && xschem testbench.sch
build-xschem:
	iverilog -g2012 -o ~/.xschem/simulations/digital_core src/digital_core.sv
	iverilog -g2012 -o ~/.xschem/simulations/test_core test/test_core.sv

############################ Python venv
VENV = .venv
PYTHON = $(VENV)/bin/python

venv:
	python3 -m venv $(VENV)
	$(VENV)/bin/pip install vcdvcd

vcd2spice: test.vcd
	$(PYTHON) vcdtospice.py test.vcd -s "clk=clk" "cen=cen" "rst_n=rst_n" "bdir=bdir" "bc1=bc1" "bc2=bc2" "din=din[7:0]" -o xschem/test_core.spice --subckt test_core

######################### IRSim
irsim/digital_core.sim:
	cp asic/mag/digital_core.sim irsim/digital_core.sim
	sed -i 's/__special_nfet_01v8/__special_nfet_latch/g' irsim/digital_core.sim
	sed -i 's/VPWR/Vdd/g' irsim/digital_core.sim
	sed -i 's/VGND/Gnd/g' irsim/digital_core.sim

view-irsim: irsim/digital_core.sim
	irsim $PDK_ROOT/sky130A/libs.tech/irsim/sky130A_tt_nom_125.prm irsim/digital_core.sim

clean-irsim:
	rm -rf irsim/digital_core.sim
	rm -rf irsim/test.cmd

vcd2irsim: test.vcd
	$(PYTHON) vcdtoirsim.py test.vcd -s "clk=clk" "clk_en=cen" "rst_n=rst_n" "bdir=bdir" "bc1=bc1" "bc2=bc2" "din=din[7:0]" -o irsim/test.cmd