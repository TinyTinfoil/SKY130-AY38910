v {xschem version=3.4.7RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -390 -140 -370 -140 {lab=bc1}
N -390 -100 -370 -100 {lab=bc2}
N -390 -60 -370 -60 {lab=bdir}
N -390 -20 -370 -20 {lab=cen}
C {digital_core_post.sym} -120 -30 0 1 {name=X1 model=digital_core}
C {code_shown.sym} -1310 -440 0 0 {name=COMMANDS only_toplevel=false value="
.param VDD=1.8
.include ext/digital_core.spice
.include ext/test_core.spice
.PREPROCESS REPLACEGROUND TRUE
.OPTIONS DIST STRATEGY=2
.OPTIONS RESTART JOB=checkpt_b INITIAL_INTERVAL=3us
.OPTIONS LINSOL TR_AMD=0 TR_SINGLETON_FILTER=1

.tran 1ns 2ms
.print tran format=csv file=scratchpad3.csv v(A*) v(B*) v(C*) v(d*)
"}
C {lab_pin.sym} 20 30 0 1 {name=p2 lab=CLK}
C {madvlsi/vsource.sym} -1250 100 0 0 {name=Vdd
only_toplevel=true
lvs_ignore=true
value=1.8}
C {lab_pin.sym} -1250 70 0 0 {name=p9 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VP}
C {lab_pin.sym} 20 70 2 0 {name=p5 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VP}
C {lab_pin.sym} -210 20 0 0 {name=p7 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VP}
C {lab_pin.sym} 20 -370 2 0 {name=p38 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=VP}
C {lab_pin.sym} 0 -670 0 0 {name=p78 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=A0}
C {lab_pin.sym} 0 -630 0 0 {name=p79 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=A1}
C {lab_pin.sym} 0 -590 0 0 {name=p80 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=A2}
C {lab_pin.sym} 0 -550 0 0 {name=p81 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=A3}
C {lab_pin.sym} 0 -510 0 0 {name=p82 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=A4}
C {lab_pin.sym} -120 -670 0 0 {name=p83 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=B0}
C {lab_pin.sym} -120 -630 0 0 {name=p84 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=B1}
C {lab_pin.sym} -120 -590 0 0 {name=p85 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=B2}
C {lab_pin.sym} -120 -550 0 0 {name=p86 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=B3}
C {lab_pin.sym} -120 -510 0 0 {name=p87 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=B4}
C {lab_pin.sym} -250 -670 0 0 {name=p88 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=C0}
C {lab_pin.sym} -250 -630 0 0 {name=p89 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=C1}
C {lab_pin.sym} -250 -590 0 0 {name=p90 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=C2}
C {lab_pin.sym} -250 -550 0 0 {name=p91 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=C3}
C {lab_pin.sym} -250 -510 0 0 {name=p92 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=C4}
C {lab_pin.sym} -400 -510 2 0 {name=p6 lab=din_out7}
C {lab_pin.sym} -400 -550 2 0 {name=p11 lab=din_out6}
C {lab_pin.sym} -400 -590 2 0 {name=p12 lab=din_out5}
C {lab_pin.sym} -400 -630 2 0 {name=p16 lab=din_out4}
C {lab_pin.sym} -400 -670 2 0 {name=p21 lab=din_out3}
C {lab_pin.sym} -400 -710 2 0 {name=p22 lab=din_out2}
C {lab_pin.sym} -400 -750 2 0 {name=p23 lab=din_out1}
C {lab_pin.sym} -400 -790 2 0 {name=p24 lab=din_out0}
C {sky130_fd_pr/corner.sym} 210 120 0 0 {name=CORNER only_toplevel=true lvs_ignore=true corner=tt}
C {test_core_post.sym} -480 -30 0 0 {name=X2 model=test_core
}
C {lab_pin.sym} -620 30 0 0 {name=p25 lab=CLK}
C {lab_pin.sym} -370 -140 2 0 {name=p26 lab=bc1}
C {lab_pin.sym} -370 -100 2 0 {name=p27 lab=bc2}
C {lab_pin.sym} -370 -60 2 0 {name=p28 lab=bdir}
C {lab_pin.sym} -370 -20 2 0 {name=p29 lab=cen
}
C {lab_pin.sym} -390 90 2 0 {name=p30 lab=VRST}
C {lab_pin.sym} 20 -10 2 0 {name=p1 lab=cen
}
C {lab_pin.sym} -210 90 0 0 {name=p35 lab=VRST}
C {lab_pin.sym} -210 -20 0 0 {name=p93 lab=bdir}
C {lab_pin.sym} -210 -60 0 0 {name=p94 lab=bc2}
C {lab_pin.sym} -210 -100 0 0 {name=p95 lab=bc1}
C {lab_pin.sym} -390 -170 2 0 {name=p31 lab=din_out7}
C {lab_pin.sym} -390 -200 2 0 {name=p32 lab=din_out6}
C {lab_pin.sym} -390 -230 2 0 {name=p33 lab=din_out5}
C {lab_pin.sym} -390 -260 2 0 {name=p34 lab=din_out4}
C {lab_pin.sym} -390 -290 2 0 {name=p44 lab=din_out3}
C {lab_pin.sym} -390 -320 2 0 {name=p45 lab=din_out2}
C {lab_pin.sym} -390 -350 2 0 {name=p46 lab=din_out1}
C {lab_pin.sym} -390 -380 2 0 {name=p47 lab=din_out0}
C {res.sym} -580 -790 1 0 {name=R1
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} -580 -750 1 0 {name=R2
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} -580 -710 1 0 {name=R3
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} -580 -670 1 0 {name=R4
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} -580 -630 1 0 {name=R5
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} -580 -590 1 0 {name=R6
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} -580 -550 1 0 {name=R7
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} -580 -510 1 0 {name=R8
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 850 -510 3 0 {name=R9
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 850 -550 3 0 {name=R10
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 850 -590 3 0 {name=R11
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 850 -630 3 0 {name=R12
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 850 -670 3 0 {name=R13
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 850 -710 3 0 {name=R14
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 850 -750 3 0 {name=R15
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 850 -790 3 0 {name=R16
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 680 -510 3 0 {name=R17
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 680 -550 3 0 {name=R18
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 680 -590 3 0 {name=R19
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 680 -630 3 0 {name=R20
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 680 -670 3 0 {name=R21
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 680 -710 3 0 {name=R22
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 680 -750 3 0 {name=R23
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 680 -790 3 0 {name=R24
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 500 -510 3 0 {name=R25
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 500 -550 3 0 {name=R26
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 500 -590 3 0 {name=R27
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 500 -630 3 0 {name=R28
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 500 -670 3 0 {name=R29
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 500 -710 3 0 {name=R30
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 500 -750 3 0 {name=R31
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 500 -790 3 0 {name=R32
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 330 -510 3 0 {name=R33
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 330 -550 3 0 {name=R34
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 330 -590 3 0 {name=R35
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 330 -630 3 0 {name=R36
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 330 -670 3 0 {name=R37
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 330 -710 3 0 {name=R38
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 330 -750 3 0 {name=R39
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 330 -790 3 0 {name=R40
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 50 -180 3 0 {name=R56
value=1M
footprint=1206
device=resistor
m=1}
C {res.sym} 50 -90 3 0 {name=R57
value=1M
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 20 -330 2 0 {name=p60 lab=0
}
C {lab_pin.sym} 80 -180 2 0 {name=p61 lab=0
}
C {lab_pin.sym} 80 -90 2 0 {name=p62 lab=0
}
C {lab_pin.sym} 20 -50 2 0 {name=p63 lab=0
}
C {lab_pin.sym} -210 60 0 0 {name=p64 lab=0
}
C {lab_pin.sym} -1250 130 3 0 {name=p65 lab=0
}
C {lab_pin.sym} 880 -790 2 0 {name=p66 lab=0
}
C {lab_pin.sym} 880 -750 2 0 {name=p67 lab=0
}
C {lab_pin.sym} 880 -710 2 0 {name=p68 lab=0
}
C {lab_pin.sym} 880 -670 2 0 {name=p69 lab=0
}
C {lab_pin.sym} 880 -630 2 0 {name=p70 lab=0
}
C {lab_pin.sym} 880 -590 2 0 {name=p71 lab=0
}
C {lab_pin.sym} 880 -550 2 0 {name=p72 lab=0
}
C {lab_pin.sym} 880 -510 2 0 {name=p73 lab=0
}
C {lab_pin.sym} 710 -790 2 0 {name=p74 lab=0
}
C {lab_pin.sym} 710 -750 2 0 {name=p75 lab=0
}
C {lab_pin.sym} 710 -710 2 0 {name=p76 lab=0
}
C {lab_pin.sym} 710 -670 2 0 {name=p77 lab=0
}
C {lab_pin.sym} 710 -630 2 0 {name=p96 lab=0
}
C {lab_pin.sym} 710 -590 2 0 {name=p97 lab=0
}
C {lab_pin.sym} 710 -550 2 0 {name=p98 lab=0
}
C {lab_pin.sym} 710 -510 2 0 {name=p99 lab=0
}
C {lab_pin.sym} 530 -790 2 0 {name=p100 lab=0
}
C {lab_pin.sym} 530 -750 2 0 {name=p101 lab=0
}
C {lab_pin.sym} 530 -710 2 0 {name=p102 lab=0
}
C {lab_pin.sym} 530 -670 2 0 {name=p103 lab=0
}
C {lab_pin.sym} 530 -630 2 0 {name=p104 lab=0
}
C {lab_pin.sym} 530 -590 2 0 {name=p105 lab=0
}
C {lab_pin.sym} 530 -550 2 0 {name=p106 lab=0
}
C {lab_pin.sym} 530 -510 2 0 {name=p107 lab=0
}
C {lab_pin.sym} 360 -790 2 0 {name=p108 lab=0
}
C {lab_pin.sym} 360 -750 2 0 {name=p109 lab=0
}
C {lab_pin.sym} 360 -710 2 0 {name=p110 lab=0
}
C {lab_pin.sym} 360 -670 2 0 {name=p111 lab=0
}
C {lab_pin.sym} 360 -630 2 0 {name=p112 lab=0
}
C {lab_pin.sym} 360 -590 2 0 {name=p113 lab=0
}
C {lab_pin.sym} 360 -550 2 0 {name=p114 lab=0
}
C {lab_pin.sym} 360 -510 2 0 {name=p115 lab=0
}
C {lab_pin.sym} -610 -510 0 0 {name=p116 lab=0
}
C {lab_pin.sym} -610 -550 0 0 {name=p117 lab=0
}
C {lab_pin.sym} -610 -590 0 0 {name=p118 lab=0
}
C {lab_pin.sym} -610 -630 0 0 {name=p119 lab=0
}
C {lab_pin.sym} -610 -670 0 0 {name=p120 lab=0
}
C {lab_pin.sym} -610 -710 0 0 {name=p121 lab=0
}
C {lab_pin.sym} -610 -750 0 0 {name=p122 lab=0
}
C {lab_pin.sym} -610 -790 0 0 {name=p123 lab=0
}
C {res.sym} 100 290 3 0 {name=R41
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 130 290 2 0 {name=p3 lab=0
}
C {lab_pin.sym} 70 290 0 0 {name=p42 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=A0}
C {lab_pin.sym} 70 330 0 0 {name=p43 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=A1}
C {lab_pin.sym} 70 370 0 0 {name=p48 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=A2}
C {lab_pin.sym} 70 410 0 0 {name=p49 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=A3}
C {lab_pin.sym} 70 450 0 0 {name=p50 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=A4}
C {lab_pin.sym} -50 290 0 0 {name=p51 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=B0}
C {lab_pin.sym} -50 330 0 0 {name=p52 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=B1}
C {lab_pin.sym} -50 370 0 0 {name=p53 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=B2}
C {lab_pin.sym} -50 410 0 0 {name=p54 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=B3}
C {lab_pin.sym} -50 450 0 0 {name=p55 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=B4}
C {lab_pin.sym} -180 290 0 0 {name=p56 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=C0}
C {lab_pin.sym} -180 330 0 0 {name=p57 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=C1}
C {lab_pin.sym} -180 370 0 0 {name=p58 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=C2}
C {lab_pin.sym} -180 410 0 0 {name=p59 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=C3}
C {lab_pin.sym} -180 450 0 0 {name=p124 sig_type=std_logic only_toplevel=true lvs_ignore=true lab=C4}
C {res.sym} 100 330 3 0 {name=R42
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 130 330 2 0 {name=p4 lab=0
}
C {res.sym} 100 370 3 0 {name=R43
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 130 370 2 0 {name=p8 lab=0
}
C {res.sym} 100 410 3 0 {name=R44
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 130 410 2 0 {name=p10 lab=0
}
C {res.sym} 100 450 3 0 {name=R45
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 130 450 2 0 {name=p13 lab=0
}
C {res.sym} -20 290 3 0 {name=R46
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 10 290 2 0 {name=p14 lab=0
}
C {res.sym} -20 330 3 0 {name=R47
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 10 330 2 0 {name=p15 lab=0
}
C {res.sym} -20 370 3 0 {name=R48
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 10 370 2 0 {name=p17 lab=0
}
C {res.sym} -20 410 3 0 {name=R49
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 10 410 2 0 {name=p18 lab=0
}
C {res.sym} -20 450 3 0 {name=R50
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 10 450 2 0 {name=p19 lab=0
}
C {res.sym} -150 290 3 0 {name=R51
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} -120 290 2 0 {name=p20 lab=0
}
C {res.sym} -150 330 3 0 {name=R52
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} -120 330 2 0 {name=p36 lab=0
}
C {res.sym} -150 370 3 0 {name=R53
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} -120 370 2 0 {name=p37 lab=0
}
C {res.sym} -150 410 3 0 {name=R54
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} -120 410 2 0 {name=p39 lab=0
}
C {res.sym} -150 450 3 0 {name=R55
value=1G
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} -120 450 2 0 {name=p40 lab=0
}
