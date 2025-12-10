v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -690 240 -690 260 {lab=CLK}
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
N -300 90 -210 90 {lab=#net5}
N -230 90 -230 150 {lab=#net5}
N 320 170 320 200 {lab=IAin7}
N 440 170 440 200 {lab=IAin6}
N 560 170 560 200 {lab=IAin5}
N 680 170 680 200 {lab=IAin4}
N 770 170 770 200 {lab=IAin3}
N 890 170 890 200 {lab=IAin2}
N 1010 170 1010 200 {lab=IAin1}
N 1130 170 1130 200 {lab=IAin0}
N 320 260 440 260 {lab=VN}
N 440 260 560 260 {lab=VN}
N 560 260 680 260 {lab=VN}
N 680 260 770 260 {lab=VN}
N 770 260 890 260 {lab=VN}
N 890 260 1010 260 {lab=VN}
N 1010 260 1130 260 {lab=VN}
N 320 290 320 320 {lab=IBin7}
N 440 290 440 320 {lab=IBin6}
N 560 290 560 320 {lab=IBin5}
N 680 290 680 320 {lab=IBin4}
N 770 290 770 320 {lab=IBin3}
N 890 290 890 320 {lab=IBin2}
N 1010 290 1010 320 {lab=IBin1}
N 1130 290 1130 320 {lab=IBin0}
N 320 380 440 380 {lab=VN}
N 440 380 560 380 {lab=VN}
N 560 380 680 380 {lab=VN}
N 680 380 770 380 {lab=VN}
N 770 380 890 380 {lab=VN}
N 890 380 1010 380 {lab=VN}
N 1010 380 1130 380 {lab=VN}
C {jt49_bus.sym} -120 -30 0 1 {name=a1 model=jt49_bus

***Icarus_verilog***
device_model=".model jt49_bus d_cosim simulation=\\"ivlng\\" sim_args=[\\"jt49_bus\\"] delay=1e-12"

tclcommand="edit_file [abs_sym_path counter.v]"}
C {test_core.sym} -390 -30 0 0 {name=a2 model=test_core

***Icarus_verilog***
device_model=".model test_core d_cosim simulation=\\"ivlng\\" sim_args=[\\"test_core\\"] delay=1e-12"

tclcommand="edit_file [abs_sym_path counter.v]"}
C {vsource.sym} -690 290 0 0 {name=VCLOCK value="pulse 0 'VDD' 49995p 10p 10p 49990p 100n"}
C {lab_pin.sym} -690 240 0 0 {name=p13 lab=CLK}
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
C {lab_pin.sym} 20 70 2 0 {name=p5 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VP}
C {lab_pin.sym} -210 20 0 0 {name=p7 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VP}
C {lab_pin.sym} -210 60 0 0 {name=p10 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 20 -180 2 0 {name=p14 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 20 -90 2 0 {name=p17 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 20 -50 2 0 {name=p18 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {gnd.sym} -690 320 0 0 {name=l2 lab=GND only_toplevel=true lvs_ignore=true}
C {vsource.sym} -230 180 0 0 {name=VCLOCK1 value="pulse 0 'VDD' 49995p 10p 10p 49990p 100n"}
C {gnd.sym} -230 210 0 0 {name=l3 lab=GND only_toplevel=true lvs_ignore=true}
C {lab_pin.sym} 20 -240 2 0 {name=p6 lab=IB_out[7..0]}
C {lab_pin.sym} 20 -150 2 0 {name=p11 lab=IA_out[7..0]}
C {lab_pin.sym} -210 -270 0 0 {name=p15 lab=d_out[7..0]}
C {lab_pin.sym} -210 -330 0 0 {name=p3 lab=A_out[4..0]}
C {lab_pin.sym} -210 -360 0 0 {name=p19 lab=B_out[4..0]}
C {lab_pin.sym} -210 -390 0 0 {name=p20 lab=C_out[4..0]}
C {res.sym} 320 230 0 0 {name=R4
value=8
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 320 170 0 0 {name=p44 lab=IAin7}
C {res.sym} 440 230 0 0 {name=R5
value=16
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 440 170 0 0 {name=p45 lab=IAin6}
C {res.sym} 560 230 0 0 {name=R6
value=32
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 560 170 0 0 {name=p46 lab=IAin5}
C {res.sym} 680 230 0 0 {name=R7
value=64
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 680 170 0 0 {name=p47 lab=IAin4}
C {res.sym} 770 230 0 0 {name=R1
value=8
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 770 170 0 0 {name=p21 lab=IAin3}
C {res.sym} 890 230 0 0 {name=R2
value=16
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 890 170 0 0 {name=p22 lab=IAin2}
C {res.sym} 1010 230 0 0 {name=R3
value=32
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 1010 170 0 0 {name=p23 lab=IAin1}
C {res.sym} 1130 230 0 0 {name=R8
value=64
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 1130 170 0 0 {name=p24 lab=IAin0}
C {lab_pin.sym} 20 -120 2 0 {name=p16 lab=IAin[7..0]}
C {lab_pin.sym} 320 260 0 0 {name=p25 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {res.sym} 320 350 0 0 {name=R9
value=8
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 320 290 0 0 {name=p26 lab=IBin7}
C {res.sym} 440 350 0 0 {name=R10
value=16
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 440 290 0 0 {name=p27 lab=IBin6}
C {res.sym} 560 350 0 0 {name=R11
value=32
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 560 290 0 0 {name=p28 lab=IBin5}
C {res.sym} 680 350 0 0 {name=R12
value=64
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 680 290 0 0 {name=p29 lab=IBin4}
C {res.sym} 770 350 0 0 {name=R13
value=8
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 770 290 0 0 {name=p30 lab=IBin3}
C {res.sym} 890 350 0 0 {name=R14
value=16
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 890 290 0 0 {name=p31 lab=IBin2}
C {res.sym} 1010 350 0 0 {name=R15
value=32
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 1010 290 0 0 {name=p32 lab=IBin1}
C {res.sym} 1130 350 0 0 {name=R16
value=64
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 1130 290 0 0 {name=p33 lab=IBin0}
C {lab_pin.sym} 320 380 0 0 {name=p34 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 20 -210 2 0 {name=p12 lab=IBin[7..0]}
C {lab_pin.sym} -300 -200 2 0 {name=p35 lab=din_out[7..0]}
C {lab_pin.sym} -210 -300 0 0 {name=p36 lab=din_out[7..0]}
