v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 -270 -720 530 -320 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
y1=0
y2=1.8
hilight_wave=0
only_toplevel=true lvs_ignore=true
color="4 5 6"
node="time
Y
a"
sim_type=tran
rawfile=$netlist_dir/inverter.raw
x1=0
x2=5e-08}
P 4 1 160 -90 {}
N 140 -190 140 -180 {lab=VP}
N 140 -120 140 -110 {lab=Y}
N 110 -150 110 -80 {lab=A}
N 100 -110 110 -110 {lab=A}
N 140 -110 160 -110 {lab=Y}
N 110 -80 110 -70 {lab=A}
N 140 -110 140 -100 {lab=Y}
N 140 -70 140 -40 {lab=VN}
N 140 -180 140 -150 {lab=VP}
N 140 -40 140 -30 {lab=VN}
C {madvlsi/vsource.sym} -190 -170 0 0 {name=Vdd
only_toplevel=true
lvs_ignore=true
value=1.8}
C {code_shown.sym} 260 -270 0 0 {name=SPICE only_toplevel=true lvs_ignore=true value=".tran 0.01ns 50ns
.save all
.control
  run
  plot v(A) v(Y)
  write inverter.raw
.endc"}
C {ipin.sym} 100 -110 0 0 {name=p1 sig_type=std_logic lab=A}
C {sky130_fd_pr/corner.sym} 260 -110 0 0 {name=CORNER only_toplevel=true lvs_ignore=true corner=tt}
C {opin.sym} 160 -110 0 0 {name=p2 sig_type=std_logic lab=Y}
C {madvlsi/vsource.sym} -140 -70 0 0 {name=Vin
only_toplevel=true lvs_ignore=true
value="pulse(0 1.8 1ns 1ns 1ns 4ns 10ns)"}
C {lab_pin.sym} -140 -100 0 0 {name=p3 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=A}
C {madvlsi/nmos4.sym} 140 -70 0 0 {name=M2
L=0.15
W=1
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {madvlsi/pmos4.sym} 140 -150 0 0 {name=M1
L=0.15
W=1
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {iopin.sym} 140 -30 2 0 {name=p5 lab=VN}
C {iopin.sym} 140 -190 2 0 {name=p6 lab=VP}
C {lab_pin.sym} -140 -40 0 0 {name=p7 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -190 -140 0 0 {name=p8 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -190 -200 0 0 {name=p9 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VP}
C {gnd.sym} -100 -140 0 0 {name=l1 lab=GND only_toplevel=true lvs_ignore=true}
C {madvlsi/vsource.sym} -100 -170 0 0 {name=Vss
only_toplevel=true
lvs_ignore=true
value=0}
C {lab_pin.sym} -100 -200 2 0 {name=p4 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
