v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -1670 30 -1670 90 {lab=#net1}
N -1530 30 -1530 90 {lab=#net2}
N -1670 30 -1590 30 {lab=#net1}
N -1390 30 -1390 90 {lab=#net3}
N -1530 30 -1450 30 {lab=#net2}
N -1250 30 -1250 90 {lab=#net4}
N -1390 30 -1310 30 {lab=#net3}
N -1110 30 -1110 90 {lab=#net5}
N -1250 30 -1170 30 {lab=#net4}
N -970 30 -970 90 {lab=#net6}
N -1110 30 -1030 30 {lab=#net5}
N -830 30 -830 90 {lab=#net7}
N -970 30 -890 30 {lab=#net6}
N -690 30 -690 90 {lab=#net8}
N -830 30 -750 30 {lab=#net7}
N -550 30 -550 90 {lab=#net9}
N -690 30 -610 30 {lab=#net8}
N -410 30 -410 90 {lab=#net10}
N -550 30 -470 30 {lab=#net9}
N -270 30 -270 90 {lab=#net11}
N -410 30 -330 30 {lab=#net10}
N -130 30 -130 90 {lab=#net12}
N -270 30 -190 30 {lab=#net11}
N 10 30 10 90 {lab=N13}
N -130 30 -50 30 {lab=#net12}
N 150 30 150 90 {lab=N14}
N 10 30 90 30 {lab=N13}
N 290 30 290 90 {lab=N15}
N 150 30 230 30 {lab=N14}
N -1710 120 -1700 120 {lab=MUX1}
N -1710 -70 -1710 120 {lab=MUX1}
N -1570 120 -1560 120 {lab=MUX2}
N -1570 -70 -1570 120 {lab=MUX2}
N -1430 120 -1420 120 {lab=MUX3}
N -1430 -70 -1430 120 {lab=MUX3}
N -1290 120 -1280 120 {lab=MUX4}
N -1290 -70 -1290 120 {lab=MUX4}
N -1150 120 -1140 120 {lab=MUX5}
N -1150 -70 -1150 120 {lab=MUX5}
N -1010 120 -1000 120 {lab=MUX6}
N -1010 -70 -1010 120 {lab=MUX6}
N -30 120 -20 120 {lab=MUX13}
N -30 -70 -30 120 {lab=MUX13}
N 110 120 120 120 {lab=MUX14}
N 110 -70 110 120 {lab=MUX14}
N 250 120 260 120 {lab=MUX15}
N 250 -70 250 120 {lab=MUX15}
N -870 120 -860 120 {lab=MUX7}
N -870 -70 -870 120 {lab=MUX7}
N -730 120 -720 120 {lab=MUX8}
N -730 -70 -730 120 {lab=MUX8}
N -590 120 -580 120 {lab=MUX9}
N -590 -70 -590 120 {lab=MUX9}
N -450 120 -440 120 {lab=MUX10}
N -450 -70 -450 120 {lab=MUX10}
N -310 120 -300 120 {lab=MUX11}
N -310 -70 -310 120 {lab=MUX11}
N -170 120 -160 120 {lab=MUX12}
N -170 -70 -170 120 {lab=MUX12}
N 290 30 370 30 {lab=N15}
N -1670 150 -1670 190 {lab=#net13}
N -1670 190 290 190 {lab=#net13}
N 290 150 290 190 {lab=#net13}
N 150 150 150 190 {lab=#net13}
N 10 150 10 190 {lab=#net13}
N -130 150 -130 190 {lab=#net13}
N -270 150 -270 190 {lab=#net13}
N -410 150 -410 190 {lab=#net13}
N -550 150 -550 190 {lab=#net13}
N -690 150 -690 190 {lab=#net13}
N -830 150 -830 190 {lab=#net13}
N -970 150 -970 190 {lab=#net13}
N -1110 150 -1110 190 {lab=#net13}
N -1250 150 -1250 190 {lab=#net13}
N -1390 150 -1390 190 {lab=#net13}
N -1530 150 -1530 190 {lab=#net13}
N -1810 30 -1810 90 {lab=#net14}
N -1810 30 -1730 30 {lab=#net14}
N -1850 120 -1840 120 {lab=MUX0}
N -1850 -70 -1850 120 {lab=MUX0}
N -1810 150 -1810 190 {lab=#net13}
N -1810 190 -1670 190 {lab=#net13}
N -1880 30 -1810 30 {lab=#net14}
N 290 190 290 270 {lab=#net13}
N 290 270 290 320 {lab=#net13}
C {madvlsi/nmos3.sym} -1810 120 2 1 {name=M1
L=0.15
W=0.5
body=GND
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
C {lab_pin.sym} 290 60 0 1 {name=p33 sig_type=std_logic lab=N15}
C {lab_pin.sym} 150 60 0 1 {name=p34 sig_type=std_logic lab=N14}
C {lab_pin.sym} 10 60 0 1 {name=p38 sig_type=std_logic lab=N13}
C {madvlsi/nmos3.sym} -1670 120 2 1 {name=M2
L=0.15
W=0.5
body=GND
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
C {madvlsi/nmos3.sym} -1530 120 2 1 {name=M3
L=0.15
W=0.5
body=GND
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
C {madvlsi/nmos3.sym} -1390 120 2 1 {name=M4
L=0.15
W=0.5
body=GND
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
C {madvlsi/nmos3.sym} -1250 120 2 1 {name=M5
L=0.15
W=0.5
body=GND
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
C {madvlsi/nmos3.sym} -1110 120 2 1 {name=M6
L=0.15
W=0.5
body=GND
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
C {madvlsi/nmos3.sym} -970 120 2 1 {name=M7
L=0.15
W=0.5
body=GND
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
C {madvlsi/nmos3.sym} -830 120 2 1 {name=M8
L=0.15
W=0.5
body=GND
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
C {madvlsi/nmos3.sym} -690 120 2 1 {name=M9
L=0.15
W=0.5
body=GND
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
C {madvlsi/nmos3.sym} -550 120 2 1 {name=M10
L=0.15
W=0.5
body=GND
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
C {madvlsi/nmos3.sym} -410 120 2 1 {name=M11
L=0.15
W=0.5
body=GND
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
C {madvlsi/nmos3.sym} -270 120 2 1 {name=M12
L=0.15
W=0.5
body=GND
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
C {madvlsi/nmos3.sym} -130 120 2 1 {name=M13
L=0.15
W=0.5
body=GND
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
C {madvlsi/nmos3.sym} 10 120 2 1 {name=M14
L=0.15
W=0.5
body=GND
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
C {madvlsi/nmos3.sym} 150 120 2 1 {name=M15
L=0.15
W=0.5
body=GND
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
C {madvlsi/nmos3.sym} 290 120 2 1 {name=M16
L=0.15
W=0.5
body=GND
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
C {sky130_fd_pr/res_generic_po.sym} 290 350 0 0 {name=R19
W=0.35
L=67.2
model=res_generic_po
spiceprefix=X
mult=1}
C {iopin.sym} -1940 30 2 0 {name=p27 lab=GND
}
C {iopin.sym} -1850 -70 3 0 {name=p11 lab=MUX0


}
C {iopin.sym} -1710 -70 3 0 {name=p1 lab=MUX1



}
C {iopin.sym} -1570 -70 3 0 {name=p2 lab=MUX2




}
C {iopin.sym} -1430 -70 3 0 {name=p3 lab=MUX3



}
C {iopin.sym} -1290 -70 3 0 {name=p4 lab=MUX4



}
C {iopin.sym} -1150 -70 3 0 {name=p5 lab=MUX5



}
C {iopin.sym} -1010 -70 3 0 {name=p6 lab=MUX6



}
C {iopin.sym} -870 -70 3 0 {name=p7 lab=MUX7



}
C {iopin.sym} -730 -70 3 0 {name=p8 lab=MUX8



}
C {iopin.sym} -590 -70 3 0 {name=p9 lab=MUX9



}
C {iopin.sym} -450 -70 3 0 {name=p10 lab=MUX10



}
C {iopin.sym} -310 -70 3 0 {name=p12 lab=MUX11



}
C {iopin.sym} -170 -70 3 0 {name=p13 lab=MUX12



}
C {iopin.sym} -30 -70 3 0 {name=p14 lab=MUX13




}
C {iopin.sym} 110 -70 3 0 {name=p15 lab=MUX14



}
C {iopin.sym} 250 -70 3 0 {name=p16 lab=MUX15




}
C {iopin.sym} 430 30 0 0 {name=p17 lab=VDD




}
C {iopin.sym} 290 380 1 0 {name=p18 lab=Vout




}
C {sky130_fd_pr/res_generic_po.sym} 400 30 1 0 {name=R20
W=0.35
L=516.49
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} 260 30 1 0 {name=R21
W=0.35
L=188.1
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} 120 30 1 0 {name=R14
W=0.35
L=133.65
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} -20 30 1 0 {name=R9
W=0.35
L=94.32
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} -160 30 1 0 {name=R10
W=0.35
L=67.2
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} -300 30 1 0 {name=R11
W=0.35
L=47.16
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} -440 30 1 0 {name=R12
W=0.35
L=33.75
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} -580 30 1 0 {name=R13
W=0.35
L=23.9
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} -720 30 1 0 {name=R6
W=0.35
L=16.8
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} -860 30 1 0 {name=R7
W=0.35
L=11.62
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} -1000 30 1 0 {name=R8
W=0.35
L=8.7
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} -1140 30 1 0 {name=R2
W=0.35
L=5.94
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} -1280 30 1 0 {name=R3
W=0.35
L=4.27
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} -1420 30 1 0 {name=R4
W=0.35
L=2.97
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} -1560 30 1 0 {name=R5
W=0.35
L=2.1
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} -1700 30 1 0 {name=R1
W=0.35
L=1.75
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} -1910 30 1 0 {name=R15
W=0.35
L=3.35
model=res_generic_po
spiceprefix=X
mult=1}
