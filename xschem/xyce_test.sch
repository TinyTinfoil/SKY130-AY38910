v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 -170 -580 630 -180 {flags=graph
y1=-2.2e-19
y2=0.00062
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.0096898169
x2=-0.0060898169
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=i(vmeas)
color=4
dataset=-1
unitx=1
logx=0
logy=0
sim_type=tran
autoload=1
rawfile=$netlist_dir/xyce_test_dc.raw}
N 10 -20 110 -20 {lab=0}
C {sky130_fd_pr/nfet_01v8_lvt.sym} -10 -20 0 0 {name=M1
L=0.15
W=1
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {lab_pin.sym} -30 -20 0 0 {name=p1 sig_type=std_logic lab=G}
C {lab_pin.sym} 10 -110 0 0 {name=p2 sig_type=std_logic lab=D}
C {vsource.sym} -110 -30 0 0 {name=VD value=1.8 savecurrent=false}
C {ammeter.sym} 10 -80 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {lab_pin.sym} -110 -60 0 0 {name=p3 sig_type=std_logic lab=D}
C {lab_pin.sym} 10 10 0 0 {name=p4 sig_type=std_logic lab=0}
C {lab_pin.sym} 110 -20 2 0 {name=p5 sig_type=std_logic lab=0}
C {lab_pin.sym} -110 0 0 0 {name=p6 sig_type=std_logic lab=0}
C {vsource.sym} -400 -30 0 0 {name=VG value="pulse 0 1.8 49995p 10p 10p 49990p 100n" savecurrent=false}
C {lab_pin.sym} -400 -60 0 0 {name=p7 sig_type=std_logic lab=G}
C {lab_pin.sym} -400 0 0 0 {name=p8 sig_type=std_logic lab=0}
C {sky130_fd_pr/corner.sym} 130 50 0 0 {name=CORNER only_toplevel=true corner=tt}
C {code_shown.sym} 170 -110 0 0 {name=s1 only_toplevel=false value=".tran 10ps 3ms
.print tran format=raw file=xyce_test_dc.raw v(*) i(*)"}
