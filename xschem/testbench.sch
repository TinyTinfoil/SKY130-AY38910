v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -300 -60 -300 -40 {lab=#net1}
N -300 -40 -210 -40 {lab=#net1}
N -210 -40 -210 -20 {lab=#net1}
N -300 -100 -300 -80 {lab=#net2}
N -300 -80 -210 -80 {lab=#net2}
N -210 -80 -210 -60 {lab=#net2}
N -300 -140 -300 -120 {lab=#net3}
N -300 -120 -210 -120 {lab=#net3}
N -210 -120 -210 -100 {lab=#net3}
N 20 -10 20 0 {lab=#net4}
N -300 0 20 0 {lab=#net4}
N -300 -20 -300 -0 {lab=#net4}
N -300 90 -210 90 {lab=VRST}
N -90 240 -90 270 {lab=IAin7}
N 30 240 30 270 {lab=IAin6}
N 150 240 150 270 {lab=IAin5}
N 270 240 270 270 {lab=IAin4}
N 360 240 360 270 {lab=IAin3}
N 480 240 480 270 {lab=IAin2}
N 600 240 600 270 {lab=IAin1}
N 720 240 720 270 {lab=IAin0}
N -90 330 30 330 {lab=VN}
N 30 330 150 330 {lab=VN}
N 150 330 270 330 {lab=VN}
N 270 330 360 330 {lab=VN}
N 360 330 480 330 {lab=VN}
N 480 330 600 330 {lab=VN}
N 600 330 720 330 {lab=VN}
N -90 360 -90 390 {lab=IBin7}
N 30 360 30 390 {lab=IBin6}
N 150 360 150 390 {lab=IBin5}
N 270 360 270 390 {lab=IBin4}
N 360 360 360 390 {lab=IBin3}
N 480 360 480 390 {lab=IBin2}
N 600 360 600 390 {lab=IBin1}
N 720 360 720 390 {lab=IBin0}
N -90 450 30 450 {lab=VN}
N 30 450 150 450 {lab=VN}
N 150 450 270 450 {lab=VN}
N 270 450 360 450 {lab=VN}
N 360 450 480 450 {lab=VN}
N 480 450 600 450 {lab=VN}
N 600 450 720 450 {lab=VN}
N -630 230 -630 250 {lab=CLK}
C {digital_core.sym} -120 -30 0 1 {name=a1 model=digital_core

***Icarus_verilog***
device_model=".model digital_core d_cosim simulation=\\"ivlng\\" sim_args=[\\"digital_core\\"]"

tclcommand="edit_file [abs_sym_path counter.v]"}
C {test_core.sym} -390 -30 0 0 {name=a2 model=test_core

***Icarus_verilog***
device_model=".model test_core d_cosim simulation=\\"ivlng\\" sim_args=[\\"test_core\\"] delay=1e-12"

tclcommand="edit_file [abs_sym_path counter.v]"}
C {code_shown.sym} -1200 -440 0 0 {name=COMMANDS only_toplevel=false value="
.param VDD=1.8

.control

**** change default parameters of auto adc/dac bridges
*pre_set auto_bridge_d_in =
*+ ( \\".model auto_adc adc_bridge(
*+   in_low = '0.9 * 1.8 / 2' in_high = '1.1 * 1.8 / 2'
*+   rise_delay=1e-11 fall_delay=1e-11 )\\"
*+ \\"auto_bridge%d [ %s ] [ %s ] auto_adc\\" )

*pre_set auto_bridge_d_out =
*+ ( \\".model auto_dac dac_bridge(
*+   out_low = 0 out_high = 1.8
*+   t_rise=1e-11 t_fall=1e-11 )\\"
*+ \\"auto_bridge%d [ %s ] [ %s ] auto_dac\\" )

*  save all
  tran 1p 2u
*  remzerovec
*  write tb_counter_wrapper.raw
.endc
"}
C {lab_pin.sym} -530 30 0 0 {name=p1 lab=CLK}
C {lab_pin.sym} 20 30 0 1 {name=p2 lab=CLK}
C {madvlsi/vsource.sym} -890 270 0 0 {name=Vdd
only_toplevel=true
lvs_ignore=true
value=1.8}
C {lab_pin.sym} -890 300 0 0 {name=p8 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -890 240 0 0 {name=p9 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VP}
C {gnd.sym} -800 300 0 0 {name=l1 lab=GND only_toplevel=true lvs_ignore=true}
C {madvlsi/vsource.sym} -800 270 0 0 {name=Vss
only_toplevel=true
lvs_ignore=true
value=0}
C {lab_pin.sym} -800 240 2 0 {name=p4 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -210 20 0 0 {name=p7 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VP}
C {lab_pin.sym} -210 60 0 0 {name=p10 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 20 -180 2 0 {name=p14 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 20 -90 2 0 {name=p17 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 20 -240 2 0 {name=p6 lab=IB_out[7..0]}
C {lab_pin.sym} 20 -150 2 0 {name=p11 lab=IA_out[7..0]}
C {lab_pin.sym} -210 -270 0 0 {name=p15 lab=d_out[7..0]}
C {lab_pin.sym} -210 -330 0 0 {name=p3 lab=A_out[3..0]}
C {lab_pin.sym} -210 -360 0 0 {name=p19 lab=B_out[3..0]}
C {lab_pin.sym} -210 -390 0 0 {name=p20 lab=C_out[3..0]}
C {res.sym} -90 300 0 0 {name=R4
value=8
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} -90 240 0 0 {name=p44 lab=IAin7}
C {res.sym} 30 300 0 0 {name=R5
value=16
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 30 240 0 0 {name=p45 lab=IAin6}
C {res.sym} 150 300 0 0 {name=R6
value=32
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 150 240 0 0 {name=p46 lab=IAin5}
C {res.sym} 270 300 0 0 {name=R7
value=64
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 270 240 0 0 {name=p47 lab=IAin4}
C {res.sym} 360 300 0 0 {name=R1
value=8
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 360 240 0 0 {name=p21 lab=IAin3}
C {res.sym} 480 300 0 0 {name=R2
value=16
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 480 240 0 0 {name=p22 lab=IAin2}
C {res.sym} 600 300 0 0 {name=R3
value=32
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 600 240 0 0 {name=p23 lab=IAin1}
C {res.sym} 720 300 0 0 {name=R8
value=64
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 720 240 0 0 {name=p24 lab=IAin0}
C {lab_pin.sym} 20 -120 2 0 {name=p16 lab=IAin[7..0]}
C {lab_pin.sym} -90 330 0 0 {name=p25 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {res.sym} -90 420 0 0 {name=R9
value=8
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} -90 360 0 0 {name=p26 lab=IBin7}
C {res.sym} 30 420 0 0 {name=R10
value=16
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 30 360 0 0 {name=p27 lab=IBin6}
C {res.sym} 150 420 0 0 {name=R11
value=32
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 150 360 0 0 {name=p28 lab=IBin5}
C {res.sym} 270 420 0 0 {name=R12
value=64
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 270 360 0 0 {name=p29 lab=IBin4}
C {res.sym} 360 420 0 0 {name=R13
value=8
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 360 360 0 0 {name=p30 lab=IBin3}
C {res.sym} 480 420 0 0 {name=R14
value=16
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 480 360 0 0 {name=p31 lab=IBin2}
C {res.sym} 600 420 0 0 {name=R15
value=32
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 600 360 0 0 {name=p32 lab=IBin1}
C {res.sym} 720 420 0 0 {name=R16
value=64
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 720 360 0 0 {name=p33 lab=IBin0}
C {lab_pin.sym} -90 450 0 0 {name=p34 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 20 -210 2 0 {name=p12 lab=IBin[7..0]}
C {lab_pin.sym} -300 -200 2 0 {name=p35 lab=din_out[7..0]}
C {lab_pin.sym} -210 -300 0 0 {name=p36 lab=din_out[7..0]}
C {vsource.sym} -630 280 0 0 {name=VCLOCK value="pulse(0 1.8 2ns 2ns 2ns 50ns 100ns)"}
C {lab_pin.sym} -630 230 0 0 {name=p13 lab=CLK}
C {gnd.sym} -630 310 0 0 {name=l2 lab=GND only_toplevel=true lvs_ignore=true}
C {vsource.sym} -380 260 0 0 {name=VRST value="PWL(0 0 99ns 0 100ns 1.8)"}
C {gnd.sym} -380 290 0 0 {name=l3 lab=GND only_toplevel=true lvs_ignore=true}
C {lab_pin.sym} -380 230 2 0 {name=p5 lab=VRST}
C {lab_pin.sym} -300 90 3 0 {name=p18 lab=VRST}
C {parax_cap.sym} 20 -230 0 0 {name=C2[7..0] gnd=0 value=1f m=1}
C {parax_cap.sym} 20 -200 0 0 {name=C1[7..0] gnd=0 value=1f m=1}
C {parax_cap.sym} 20 -140 0 0 {name=C3[7..0] gnd=0 value=1f m=1}
C {parax_cap.sym} 20 -110 0 0 {name=C4[7..0] gnd=0 value=1f m=1}
C {parax_cap.sym} -210 -260 0 0 {name=C5[7..0] gnd=0 value=1f m=1}
C {parax_cap.sym} -210 -290 0 0 {name=C6[7..0] gnd=0 value=1f m=1}
C {parax_cap.sym} -210 -320 0 0 {name=C7[3..0] gnd=0 value=1f m=1}
C {parax_cap.sym} -210 -350 0 0 {name=C8[3..0] gnd=0 value=1f m=1}
C {parax_cap.sym} -210 -380 0 0 {name=C9[3..0] gnd=0 value=1f m=1}
C {parax_cap.sym} -300 -190 0 0 {name=C10[7..0] gnd=0 value=1f m=1}
C {parax_cap.sym} -210 -90 0 0 {name=C2 gnd=0 value=1f m=1}
C {parax_cap.sym} -210 -50 0 0 {name=C1 gnd=0 value=1f m=1}
C {parax_cap.sym} -210 -10 0 0 {name=C3 gnd=0 value=1f m=1}
C {parax_cap.sym} 20 0 0 0 {name=C4 gnd=0 value=1f m=1}
