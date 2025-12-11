v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1230 -180 1230 -120 {lab=#net1}
N 1370 -180 1370 -120 {lab=#net2}
N 1230 -180 1310 -180 {lab=#net1}
N 1510 -180 1510 -120 {lab=#net3}
N 1370 -180 1450 -180 {lab=#net2}
N 1650 -180 1650 -120 {lab=#net4}
N 1510 -180 1590 -180 {lab=#net3}
N 1790 -180 1790 -120 {lab=#net5}
N 1650 -180 1730 -180 {lab=#net4}
N 1930 -180 1930 -120 {lab=#net6}
N 1790 -180 1870 -180 {lab=#net5}
N 2070 -180 2070 -120 {lab=#net7}
N 1930 -180 2010 -180 {lab=#net6}
N 2210 -180 2210 -120 {lab=#net8}
N 2070 -180 2150 -180 {lab=#net7}
N 2350 -180 2350 -120 {lab=#net9}
N 2210 -180 2290 -180 {lab=#net8}
N 2490 -180 2490 -120 {lab=#net10}
N 2350 -180 2430 -180 {lab=#net9}
N 2630 -180 2630 -120 {lab=#net11}
N 2490 -180 2570 -180 {lab=#net10}
N 2770 -180 2770 -120 {lab=#net12}
N 2630 -180 2710 -180 {lab=#net11}
N 2910 -180 2910 -120 {lab=N13}
N 2770 -180 2850 -180 {lab=#net12}
N 3050 -180 3050 -120 {lab=N14}
N 2910 -180 2990 -180 {lab=N13}
N 3190 -180 3190 -120 {lab=N15}
N 3050 -180 3130 -180 {lab=N14}
N 1190 -90 1200 -90 {lab=MUX1}
N 1190 -280 1190 -90 {lab=MUX1}
N 1330 -90 1340 -90 {lab=MUX2}
N 1330 -280 1330 -90 {lab=MUX2}
N 1470 -90 1480 -90 {lab=MUX3}
N 1470 -280 1470 -90 {lab=MUX3}
N 1610 -90 1620 -90 {lab=MUX4}
N 1610 -280 1610 -90 {lab=MUX4}
N 1750 -90 1760 -90 {lab=MUX5}
N 1750 -280 1750 -90 {lab=MUX5}
N 1890 -90 1900 -90 {lab=MUX6}
N 1890 -280 1890 -90 {lab=MUX6}
N 2870 -90 2880 -90 {lab=MUX13}
N 2870 -280 2870 -90 {lab=MUX13}
N 3010 -90 3020 -90 {lab=MUX14}
N 3010 -280 3010 -90 {lab=MUX14}
N 3150 -90 3160 -90 {lab=MUX15}
N 3150 -280 3150 -90 {lab=MUX15}
N 2030 -90 2040 -90 {lab=MUX7}
N 2030 -280 2030 -90 {lab=MUX7}
N 2170 -90 2180 -90 {lab=MUX8}
N 2170 -280 2170 -90 {lab=MUX8}
N 2310 -90 2320 -90 {lab=MUX9}
N 2310 -280 2310 -90 {lab=MUX9}
N 2450 -90 2460 -90 {lab=MUX10}
N 2450 -280 2450 -90 {lab=MUX10}
N 2590 -90 2600 -90 {lab=MUX11}
N 2590 -280 2590 -90 {lab=MUX11}
N 2730 -90 2740 -90 {lab=MUX12}
N 2730 -280 2730 -90 {lab=MUX12}
N 3190 -180 3270 -180 {lab=N15}
N 1230 -60 1230 -20 {lab=PROBE1}
N 1230 -20 3190 -20 {lab=PROBE1}
N 3190 -60 3190 -20 {lab=PROBE1}
N 3050 -60 3050 -20 {lab=PROBE1}
N 2910 -60 2910 -20 {lab=PROBE1}
N 2770 -60 2770 -20 {lab=PROBE1}
N 2630 -60 2630 -20 {lab=PROBE1}
N 2490 -60 2490 -20 {lab=PROBE1}
N 2350 -60 2350 -20 {lab=PROBE1}
N 2210 -60 2210 -20 {lab=PROBE1}
N 2070 -60 2070 -20 {lab=PROBE1}
N 1930 -60 1930 -20 {lab=PROBE1}
N 1790 -60 1790 -20 {lab=PROBE1}
N 1650 -60 1650 -20 {lab=PROBE1}
N 1510 -60 1510 -20 {lab=PROBE1}
N 1370 -60 1370 -20 {lab=PROBE1}
N 1090 -180 1090 -120 {lab=#net13}
N 1090 -180 1170 -180 {lab=#net13}
N 1050 -90 1060 -90 {lab=MUX0}
N 1050 -280 1050 -90 {lab=MUX0}
N 1090 -60 1090 -20 {lab=PROBE1}
N 1090 -20 1230 -20 {lab=PROBE1}
N 1020 -180 1090 -180 {lab=#net13}
N 3190 -20 3190 60 {lab=PROBE1}
N 3190 60 3190 110 {lab=PROBE1}
C {madvlsi/vsource.sym} 1390 -980 0 0 {name=Vdd
value=1.8}
C {madvlsi/gnd.sym} 1390 -950 0 0 {name=l1 lab=GND}
C {madvlsi/vdd.sym} 1390 -1010 0 0 {name=l5 lab=VDD}
C {code_shown.sym} 1000 -770 0 0 {name=SPICE only_toplevel=false value="
.param Tstep = 5u
.tran 0.1u \{16*Tstep\}
.save all"
}
C {sky130_fd_pr/corner.sym} 990 -920 0 0 {name=CORNER only_toplevel=false corner=tt}
C {madvlsi/resistor.sym} 1200 -180 3 1 {name=R1
value=206
m=1}
C {madvlsi/resistor.sym} 1340 -180 3 1 {name=R2
value=290
m=1}
C {madvlsi/resistor.sym} 1480 -180 3 1 {name=R3
value=409
m=1}
C {madvlsi/resistor.sym} 1620 -180 3 1 {name=R4
value=587
m=1}
C {madvlsi/resistor.sym} 1760 -180 3 1 {name=R5
value=818
m=1}
C {madvlsi/resistor.sym} 1900 -180 3 1 {name=R6
value=1.19k
m=1}
C {madvlsi/resistor.sym} 2040 -180 3 1 {name=R7
value=1.6k
m=1}
C {madvlsi/resistor.sym} 2180 -180 3 1 {name=R8
value=2.31k
m=1}
C {madvlsi/resistor.sym} 2320 -180 3 1 {name=R9
value=3.29k
m=1}
C {madvlsi/resistor.sym} 2460 -180 3 1 {name=R10
value=4.62k
m=1}
C {madvlsi/resistor.sym} 2600 -180 3 1 {name=R11
value=6.49k
m=1}
C {madvlsi/resistor.sym} 2740 -180 3 1 {name=R12
value=9.24k
m=1}
C {madvlsi/resistor.sym} 2880 -180 3 1 {name=R13
value=12.98k
m=1}
C {madvlsi/resistor.sym} 3020 -180 3 1 {name=R14
value=18.40k
m=1}
C {madvlsi/resistor.sym} 3160 -180 3 1 {name=R15
value=25.96k
m=1}
C {madvlsi/resistor.sym} 3300 -180 3 1 {name=R16
value=71.1k
m=1}
C {madvlsi/vdd.sym} 3330 -180 1 1 {name=l3 lab=VDD}
C {madvlsi/gnd.sym} 960 -180 1 1 {name=l4 lab=GND}
C {madvlsi/nmos3.sym} 1090 -90 2 1 {name=M1
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
C {lab_pin.sym} 1190 -280 1 0 {name=p1 sig_type=std_logic lab=MUX1}
C {lab_pin.sym} 1330 -280 1 0 {name=p2 sig_type=std_logic lab=MUX2}
C {lab_pin.sym} 1470 -280 1 0 {name=p3 sig_type=std_logic lab=MUX3}
C {lab_pin.sym} 1610 -280 1 0 {name=p4 sig_type=std_logic lab=MUX4}
C {lab_pin.sym} 1750 -280 1 0 {name=p5 sig_type=std_logic lab=MUX5}
C {lab_pin.sym} 1890 -280 1 0 {name=p6 sig_type=std_logic lab=MUX6}
C {lab_pin.sym} 2030 -280 1 0 {name=p7 sig_type=std_logic lab=MUX7}
C {lab_pin.sym} 2170 -280 1 0 {name=p8 sig_type=std_logic lab=MUX8}
C {lab_pin.sym} 2310 -280 1 0 {name=p9 sig_type=std_logic lab=MUX9}
C {lab_pin.sym} 2450 -280 1 0 {name=p10 sig_type=std_logic lab=MUX10}
C {lab_pin.sym} 2590 -280 1 0 {name=p15 sig_type=std_logic lab=MUX11}
C {lab_pin.sym} 2730 -280 1 0 {name=p16 sig_type=std_logic lab=MUX12}
C {lab_pin.sym} 2870 -280 1 0 {name=p17 sig_type=std_logic lab=MUX13}
C {lab_pin.sym} 3010 -280 1 0 {name=p18 sig_type=std_logic lab=MUX14}
C {lab_pin.sym} 3150 -280 1 0 {name=p19 sig_type=std_logic lab=MUX15}
C {lab_pin.sym} 1050 -280 1 0 {name=p12 sig_type=std_logic lab=MUX0}
C {madvlsi/vsource.sym} 1550 -820 0 0 {name=VM1
value="PULSE(0 1.8 \{14*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 1550 -790 0 0 {name=l2 lab=GND}
C {lab_pin.sym} 1550 -850 3 1 {name=p13 sig_type=std_logic lab=MUX1}
C {madvlsi/vsource.sym} 1820 -820 0 0 {name=VM2
value="PULSE(0 1.8 \{13*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 1820 -790 0 0 {name=l6 lab=GND}
C {lab_pin.sym} 1820 -850 3 1 {name=p14 sig_type=std_logic lab=MUX2}
C {madvlsi/vsource.sym} 2090 -820 0 0 {name=VM3
value="PULSE(0 1.8 \{12*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 2090 -790 0 0 {name=l7 lab=GND}
C {lab_pin.sym} 2090 -850 3 1 {name=p21 sig_type=std_logic lab=MUX3}
C {madvlsi/vsource.sym} 2360 -820 0 0 {name=VM4
value="PULSE(0 1.8 \{11*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 2360 -790 0 0 {name=l8 lab=GND}
C {lab_pin.sym} 2360 -850 3 1 {name=p22 sig_type=std_logic lab=MUX4}
C {madvlsi/vsource.sym} 2630 -820 0 0 {name=VM5
value="PULSE(0 1.8 \{10*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 2630 -790 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 2630 -850 3 1 {name=p23 sig_type=std_logic lab=MUX5}
C {madvlsi/vsource.sym} 1550 -650 0 0 {name=VM6
value="PULSE(0 1.8 \{9*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 1550 -620 0 0 {name=l10 lab=GND}
C {lab_pin.sym} 1550 -680 3 1 {name=p24 sig_type=std_logic lab=MUX6}
C {madvlsi/vsource.sym} 1820 -650 0 0 {name=VM7
value="PULSE(0 1.8 \{8*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 1820 -620 0 0 {name=l12 lab=GND}
C {lab_pin.sym} 1820 -680 3 1 {name=p25 sig_type=std_logic lab=MUX7}
C {madvlsi/vsource.sym} 2090 -650 0 0 {name=VM8
value="PULSE(0 1.8 \{7*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 2090 -620 0 0 {name=l13 lab=GND}
C {lab_pin.sym} 2090 -680 3 1 {name=p26 sig_type=std_logic lab=MUX8
}
C {madvlsi/vsource.sym} 2360 -650 0 0 {name=VM9
value="PULSE(0 1.8 \{6*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 2360 -620 0 0 {name=l11 lab=GND}
C {lab_pin.sym} 2360 -680 3 1 {name=p11 sig_type=std_logic lab=MUX9}
C {madvlsi/vsource.sym} 2630 -650 0 0 {name=VM10
value="PULSE(0 1.8 \{5*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 2630 -620 0 0 {name=l14 lab=GND}
C {lab_pin.sym} 2630 -680 3 1 {name=p27 sig_type=std_logic lab=MUX10}
C {madvlsi/vsource.sym} 1550 -490 0 0 {name=VM11
value="PULSE(0 1.8 \{4*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 1550 -460 0 0 {name=l15 lab=GND}
C {lab_pin.sym} 1550 -520 3 1 {name=p28 sig_type=std_logic lab=MUX11}
C {madvlsi/vsource.sym} 1820 -490 0 0 {name=VM12
value="PULSE(0 1.8 \{3*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 1820 -460 0 0 {name=l16 lab=GND}
C {lab_pin.sym} 1820 -520 3 1 {name=p29 sig_type=std_logic lab=MUX12}
C {madvlsi/vsource.sym} 2090 -490 0 0 {name=VM13
value="PULSE(0 1.8 \{2*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 2090 -460 0 0 {name=l17 lab=GND}
C {lab_pin.sym} 2090 -520 3 1 {name=p30 sig_type=std_logic lab=MUX13}
C {madvlsi/vsource.sym} 2360 -490 0 0 {name=VM14
value="PULSE(0 1.8 \{1*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 2360 -460 0 0 {name=l18 lab=GND}
C {lab_pin.sym} 2360 -520 3 1 {name=p31 sig_type=std_logic lab=MUX14}
C {madvlsi/vsource.sym} 2630 -490 0 0 {name=VM15
value="PULSE(0 1.8 0 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 2630 -460 0 0 {name=l19 lab=GND}
C {lab_pin.sym} 2630 -520 3 1 {name=p32 sig_type=std_logic lab=MUX15}
C {madvlsi/vsource.sym} 1480 -980 0 0 {name=VM0
value="PULSE(0 1.8 \{15*Tstep\} 1n 1n \{Tstep\} \{16*Tstep\})"}
C {madvlsi/gnd.sym} 1480 -950 0 0 {name=VM16 lab=GND}
C {lab_pin.sym} 1480 -1010 3 1 {name=VM17 sig_type=std_logic lab=MUX0}
C {madvlsi/vsource.sym} 1280 -980 0 0 {name=Vbias
value=0.6}
C {madvlsi/gnd.sym} 1280 -950 0 0 {name=l22 lab=GND}
C {lab_pin.sym} 1280 -1010 1 0 {name=p20 sig_type=std_logic lab=VBias}
C {lab_pin.sym} 3190 -150 0 1 {name=p33 sig_type=std_logic lab=N15}
C {lab_pin.sym} 3050 -150 0 1 {name=p34 sig_type=std_logic lab=N14}
C {lab_pin.sym} 2910 -150 0 1 {name=p38 sig_type=std_logic lab=N13}
C {madvlsi/resistor.sym} 990 -180 3 1 {name=R17
value=500
m=1}
C {madvlsi/resistor.sym} 3190 140 2 1 {name=R18
value=10k
m=1}
C {lab_pin.sym} 3190 50 0 0 {name=p35 sig_type=std_logic lab=PROBE1}
C {lab_pin.sym} 3190 170 3 0 {name=p36 sig_type=std_logic lab=Vout}
C {madvlsi/nmos3.sym} 1230 -90 2 1 {name=M2
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
C {madvlsi/nmos3.sym} 1370 -90 2 1 {name=M3
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
C {madvlsi/nmos3.sym} 1510 -90 2 1 {name=M4
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
C {madvlsi/nmos3.sym} 1650 -90 2 1 {name=M5
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
C {madvlsi/nmos3.sym} 1790 -90 2 1 {name=M6
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
C {madvlsi/nmos3.sym} 1930 -90 2 1 {name=M7
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
C {madvlsi/nmos3.sym} 2070 -90 2 1 {name=M8
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
C {madvlsi/nmos3.sym} 2210 -90 2 1 {name=M9
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
C {madvlsi/nmos3.sym} 2350 -90 2 1 {name=M10
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
C {madvlsi/nmos3.sym} 2490 -90 2 1 {name=M11
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
C {madvlsi/nmos3.sym} 2630 -90 2 1 {name=M12
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
C {madvlsi/nmos3.sym} 2770 -90 2 1 {name=M13
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
C {madvlsi/nmos3.sym} 2910 -90 2 1 {name=M14
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
C {madvlsi/nmos3.sym} 3050 -90 2 1 {name=M15
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
C {madvlsi/nmos3.sym} 3190 -90 2 1 {name=M16
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
