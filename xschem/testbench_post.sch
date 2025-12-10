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
C {jt49_bus_post.sym} -120 -30 0 1 {name=X1 model=jt49_bus}
C {test_core.sym} -390 -30 0 0 {name=a2 model=test_core

***Icarus_verilog***
device_model=".model test_core d_cosim simulation=\\"ivlng\\" sim_args=[\\"test_core\\"] delay=1e-12"

tclcommand="edit_file [abs_sym_path counter.v]"}
C {vsource.sym} -690 290 0 0 {name=VCLOCK value="pulse 0 'VDD' 49995p 10p 10p 49990p 100n"}
C {lab_pin.sym} -690 240 0 0 {name=p13 lab=CLK}
C {code_shown.sym} -1200 -440 0 0 {name=COMMANDS only_toplevel=false value="
.param VDD=1.8
.include ~/SKY130-AY38910/xschem/jt49_bus.spice
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
C {lab_pin.sym} -300 -200 2 0 {name=p35 lab=din_out[7..0]}
C {lab_pin.sym} 20 -330 2 0 {name=p37 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 20 -370 2 0 {name=p38 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VP}
C {lab_pin.sym} -550 -790 0 0 {name=p3 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -550 -750 0 0 {name=p15 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -550 -710 0 0 {name=p19 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -550 -670 0 0 {name=p20 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -550 -630 0 0 {name=p36 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -550 -590 0 0 {name=p39 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -550 -550 0 0 {name=p40 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -550 -510 0 0 {name=p41 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 820 -510 2 0 {name=p42 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 820 -550 2 0 {name=p43 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 820 -590 2 0 {name=p48 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 820 -630 2 0 {name=p49 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 820 -670 2 0 {name=p50 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 820 -710 2 0 {name=p51 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 820 -750 2 0 {name=p52 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 820 -790 2 0 {name=p53 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 650 -510 2 0 {name=p54 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 650 -550 2 0 {name=p55 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 650 -590 2 0 {name=p56 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 650 -630 2 0 {name=p57 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 650 -670 2 0 {name=p58 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 650 -710 2 0 {name=p59 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 650 -750 2 0 {name=p60 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 650 -790 2 0 {name=p61 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 470 -510 2 0 {name=p62 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 470 -550 2 0 {name=p63 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 470 -590 2 0 {name=p64 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 470 -630 2 0 {name=p65 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 470 -670 2 0 {name=p66 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 470 -710 2 0 {name=p67 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 470 -750 2 0 {name=p68 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 470 -790 2 0 {name=p69 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 300 -510 2 0 {name=p70 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 300 -550 2 0 {name=p71 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 300 -590 2 0 {name=p72 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 300 -630 2 0 {name=p73 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 300 -670 2 0 {name=p74 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 300 -710 2 0 {name=p75 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 300 -750 2 0 {name=p76 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 300 -790 2 0 {name=p77 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 0 -670 0 0 {name=p78 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 0 -630 0 0 {name=p79 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 0 -590 0 0 {name=p80 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 0 -550 0 0 {name=p81 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} 0 -510 0 0 {name=p82 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -120 -670 0 0 {name=p83 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -120 -630 0 0 {name=p84 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -120 -590 0 0 {name=p85 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -120 -550 0 0 {name=p86 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -120 -510 0 0 {name=p87 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -250 -670 0 0 {name=p88 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -250 -630 0 0 {name=p89 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -250 -590 0 0 {name=p90 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -250 -550 0 0 {name=p91 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -250 -510 0 0 {name=p92 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VN}
C {lab_pin.sym} -400 -510 2 0 {name=p6 lab=din_out7}
C {lab_pin.sym} -400 -550 2 0 {name=p11 lab=din_out6}
C {lab_pin.sym} -400 -590 2 0 {name=p12 lab=din_out5}
C {lab_pin.sym} -400 -630 2 0 {name=p16 lab=din_out4}
C {lab_pin.sym} -400 -670 2 0 {name=p21 lab=din_out3}
C {lab_pin.sym} -400 -710 2 0 {name=p22 lab=din_out2}
C {lab_pin.sym} -400 -750 2 0 {name=p23 lab=din_out1}
C {lab_pin.sym} -400 -790 2 0 {name=p24 lab=din_out0}
