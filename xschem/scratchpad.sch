v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 880 -10 920 -10 {bus=1 lab=din[7..0]}
N 880 -10 880 30 {lab=din[7..0]}
N 660 50 670 50 {lab=bc1}
N 670 50 680 50 {lab=bc1}
N 660 90 670 90 {lab=bc2}
N 670 90 680 90 {lab=bc2}
N 660 130 670 130 {lab=bdir}
N 670 130 680 130 {lab=bdir}
N 660 170 670 170 {lab=cen}
N 670 170 680 170 {lab=cen}
C {code_shown.sym} -570 -280 0 0 {name=COMMANDS only_toplevel=false value="
.param VDD=1.8
.include ~/SKY130-AY38910/xschem/jt49_bus.spice
.include ~/SKY130-AY38910/xschem/test_core.spice
.control

**** change default parameters of auto adc/dac bridges
pre_set auto_bridge_d_in =
+ ( \\".model auto_adc adc_bridge(
+   in_low = '0.9 * 1.8 / 2' in_high = '1.1 * 1.8 / 2'
+   rise_delay=1e-11 fall_delay=1e-11 )\\"
+ \\"auto_bridge%d [ %s ] [ %s ] auto_adc\\" )

pre_set auto_bridge_d_out =
+ ( \\".model auto_dac dac_bridge(
+   out_low = 0 out_high = 1.8
+   t_rise=1e-11 t_fall=1e-11 )\\"
+ \\"auto_bridge%d [ %s ] [ %s ] auto_dac\\" )

*  save all
  tran 10ps 3ms
*  remzerovec
*  write tb_counter_wrapper.raw
.endc
"}
C {test_core_post.sym} 570 160 0 0 {name=X2 model=test_core
}
C {lab_pin.sym} 430 220 0 0 {name=p1 lab=CLK}
C {lab_pin.sym} 920 -10 2 0 {name=p35 lab=din[7..0]}
C {parax_cap.sym} 880 40 0 0 {name=C2[7..0] gnd=0 value=1f m=1}
C {lab_pin.sym} 680 50 2 0 {name=p3 lab=bc1}
C {lab_pin.sym} 680 90 2 0 {name=p4 lab=bc2}
C {lab_pin.sym} 680 130 2 0 {name=p5 lab=bdir}
C {lab_pin.sym} 680 170 2 0 {name=p6 lab=cen
}
C {parax_cap.sym} 670 60 0 0 {name=C1 gnd=0 value=1f m=1}
C {parax_cap.sym} 670 100 0 0 {name=C2 gnd=0 value=1f m=1}
C {parax_cap.sym} 670 140 0 0 {name=C3 gnd=0 value=1f m=1}
C {parax_cap.sym} 670 180 0 0 {name=C4 gnd=0 value=1f m=1}
C {lab_pin.sym} 660 280 2 0 {name=p2 lab=VRST}
C {lab_pin.sym} 660 -190 2 0 {name=p7 lab=din0}
C {lab_pin.sym} 660 -160 2 0 {name=p8 lab=din1}
C {lab_pin.sym} 660 -130 2 0 {name=p9 lab=din2}
C {lab_pin.sym} 660 -100 2 0 {name=p10 lab=din3}
C {lab_pin.sym} 660 -70 2 0 {name=p11 lab=din4}
C {lab_pin.sym} 660 -40 2 0 {name=p12 lab=din5}
C {lab_pin.sym} 660 -10 2 0 {name=p13 lab=din6}
C {lab_pin.sym} 660 20 2 0 {name=p14 lab=din7}
