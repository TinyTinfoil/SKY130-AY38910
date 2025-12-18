v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {code_shown.sym} 1070 -510 0 0 {name=SPICE only_toplevel=true lvs_ignore=true value="
.include ~/MADVLSI/MP3/vtd.spice
.dc Vin 0 15 1
.control
run
plot Vout
.endc
.save all"
}
C {lab_pin.sym} 1700 -430 2 1 {name=p11 sig_type=std_logic only_toplevel=true
lvs_ignore=true lab=A0}
C {lab_pin.sym} 1700 -410 2 1 {name=p22 sig_type=std_logic only_toplevel=true
lvs_ignore=true lab=A1}
C {lab_pin.sym} 1700 -390 2 1 {name=p23 sig_type=std_logic only_toplevel=true
lvs_ignore=true lab=A2}
C {lab_pin.sym} 1700 -370 2 1 {name=p24 sig_type=std_logic only_toplevel=true
lvs_ignore=true lab=A3}
C {madvlsi/vsource.sym} 1940 -760 1 0 {name=Vin
only_toplevel=true
lvs_ignore=true
value=0}
C {madvlsi/vsource.sym} 1610 -580 0 0 {name=Vdd
only_toplevel=true
lvs_ignore=true
value=1.8}
C {lab_pin.sym} 1610 -550 0 0 {name=p25 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {gnd.sym} 1700 -550 0 0 {name=l9 lab=GND only_toplevel=true lvs_ignore=true}
C {madvlsi/vsource.sym} 1700 -580 0 0 {name=Vss
only_toplevel=true
lvs_ignore=true
value=0}
C {lab_pin.sym} 1700 -610 2 0 {name=p26 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 1610 -610 0 0 {name=p27 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VP}
C {sky130_fd_pr/corner.sym} 1040 -690 0 0 {name=CORNER only_toplevel=true lvs_ignore=true corner=tt}
C {lab_pin.sym} 1970 -710 0 0 {name=p32 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VP}
C {gnd.sym} 1910 -760 1 0 {name=l1 lab=GND only_toplevel=true lvs_ignore=true}
C {/home/veswaranandam/MADVLSI/MP3/vtd.sym} 2070 -710 0 0 {name=X3
only_toplevel=true
lvs_ignore=true}
C {DAC.sym} 1850 -400 0 0 {name=x1}
C {lab_pin.sym} 2000 -430 2 0 {name=p1 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VP}
C {lab_pin.sym} 2000 -410 2 0 {name=p2 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=Vout}
C {lab_pin.sym} 2000 -390 2 0 {name=p3 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 2110 -770 2 0 {name=p4 sig_type=std_logic only_toplevel=true
lvs_ignore=true lab=A0}
C {lab_pin.sym} 2110 -750 2 0 {name=p5 sig_type=std_logic only_toplevel=true
lvs_ignore=true lab=A1}
C {lab_pin.sym} 2110 -730 2 0 {name=p6 sig_type=std_logic only_toplevel=true
lvs_ignore=true lab=A2}
C {lab_pin.sym} 2110 -710 2 0 {name=p7 sig_type=std_logic only_toplevel=true
lvs_ignore=true lab=A3}
C {lab_pin.sym} 2140 -500 2 0 {name=p8 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=Vout}
C {res.sym} 2140 -470 0 0 {name=R1
value=100k
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 2140 -440 2 0 {name=p9 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
