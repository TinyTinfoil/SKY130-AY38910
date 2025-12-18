v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -220 140 -110 170 {lab=#net1}
N -220 180 -110 190 {lab=#net2}
N -220 220 -110 210 {lab=#net3}
N -220 260 -110 230 {lab=#net4}
N -220 90 -120 40 {lab=#net5}
N -220 50 -120 20 {lab=#net6}
N -220 10 -120 -0 {lab=#net7}
N -220 -30 -120 -20 {lab=#net8}
N -220 -200 -130 -170 {lab=#net9}
N -220 -160 -130 -150 {lab=#net10}
N -220 -120 -130 -130 {lab=#net11}
N -220 -80 -130 -110 {lab=#net12}
C {DAC.sym} 20 -140 0 0 {name=x1}
C {DAC.sym} 30 10 0 0 {name=x2}
C {DAC.sym} 40 200 0 0 {name=x3}
C {digital_core_post.sym} -380 400 0 0 {name=X4 model=digital_core}
C {iopin.sym} -450 460 2 0 {name=p1 lab=VN
}
C {iopin.sym} -450 420 2 0 {name=p17 lab=VP




}
C {opin.sym} 170 -150 0 0 {name=p54 sig_type=std_logic lab=VoutC}
C {lab_pin.sym} 170 -170 0 1 {name=p51 sig_type=std_logic lab=VP}
C {lab_pin.sym} 170 -130 0 1 {name=p52 sig_type=std_logic lab=VN}
C {opin.sym} 180 0 0 0 {name=p2 sig_type=std_logic lab=VoutB}
C {lab_pin.sym} 180 -20 0 1 {name=p3 sig_type=std_logic lab=VP}
C {lab_pin.sym} 180 20 0 1 {name=p4 sig_type=std_logic lab=VN}
C {opin.sym} 190 190 0 0 {name=p5 sig_type=std_logic lab=VoutA}
C {lab_pin.sym} 190 170 0 1 {name=p6 sig_type=std_logic lab=VP}
C {lab_pin.sym} 190 210 0 1 {name=p7 sig_type=std_logic lab=VN}
