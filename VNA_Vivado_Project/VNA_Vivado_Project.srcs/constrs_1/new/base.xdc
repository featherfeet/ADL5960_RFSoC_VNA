### USER LEDS
#set_property PACKAGE_PIN AR11 [ get_ports "led[0]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "led[0]" ]

#set_property PACKAGE_PIN AW10 [ get_ports "led[1]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "led[1]" ]

#set_property PACKAGE_PIN AT11 [ get_ports "led[2]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "led[2]" ]

#set_property PACKAGE_PIN AU10 [ get_ports "led[3]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "led[3]" ]

### USER SLIDE SWITCH
#set_property PACKAGE_PIN AN13 [ get_ports "sw[0]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "sw[0]" ]

#set_property PACKAGE_PIN AU12 [ get_ports "sw[1]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "sw[1]" ]

#set_property PACKAGE_PIN AW11 [ get_ports "sw[2]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "sw[2]" ]

#set_property PACKAGE_PIN AV11 [ get_ports "sw[3]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "sw[3]" ]
## USER LEDS
#set_property PACKAGE_PIN AR11 [ get_ports "led[0]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "led[0]" ]

#set_property PACKAGE_PIN AW10 [ get_ports "led[1]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "led[1]" ]

#set_property PACKAGE_PIN AT11 [ get_ports "led[2]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "led[2]" ]

#set_property PACKAGE_PIN AU10 [ get_ports "led[3]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "led[3]" ]

### USER PUSH BUTTON
#set_property PACKAGE_PIN AV12 [ get_ports "btn_in[0]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "btn_in[0]" ]

#set_property PACKAGE_PIN AV10 [ get_ports "btn_in[1]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "btn_in[1]" ]

#set_property PACKAGE_PIN AW9 [ get_ports "btn_in[2]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "btn_in[2]" ]

#set_property PACKAGE_PIN AT12 [ get_ports "btn_in[3]" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "btn_in[3]" ]


## PMODS

set_property PACKAGE_PIN AF16 [ get_ports "adl1_sck" ] 
set_property PACKAGE_PIN AG17 [ get_ports "adl1_sdo" ] 
set_property PACKAGE_PIN AJ16 [ get_ports "adl1_cs" ] 
set_property PACKAGE_PIN AK17 [ get_ports "adl1_sdi" ]
set_property PACKAGE_PIN AF15 [ get_ports "adl2_sck" ] 
set_property PACKAGE_PIN AF17 [ get_ports "adl2_sdo" ] 
set_property PACKAGE_PIN AH17 [ get_ports "adl2_cs" ] 
set_property PACKAGE_PIN AK16 [ get_ports "adl2_sdi" ] 
set_property IOSTANDARD LVCMOS18 [ get_ports "adl*"]
set_property SLEW SLOW [ get_ports "adl*"]

#set_property PACKAGE_PIN AF16 [ get_po rts "PMOD0_0" ]
#set_property PACKAGE_PIN AG17 [ get_ports "PMOD0_1" ]
#set_property PACKAGE_PIN AJ16 [ get_ports "PMOD0_2" ]
#set_property PACKAGE_PIN AK17 [ get_ports "PMOD0_3" ]
#set_property PACKAGE_PIN AF15 [ get_ports "PMOD0_4" ]
#set_property PACKAGE_PIN AF17 [ get_ports "PMOD0_5" ]
#set_property PACKAGE_PIN AH17 [ get_ports "PMOD0_6" ]
#set_property PACKAGE_PIN AK16 [ get_ports "PMOD0_7" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "PMOD0*"]


set_property PACKAGE_PIN AW13 [ get_ports "lmx_sck" ]
set_property PACKAGE_PIN AR13 [ get_ports "lmx_sdo" ]
set_property PACKAGE_PIN AU13 [ get_ports "lmx_cs" ]
set_property PACKAGE_PIN AV13 [ get_ports "lmx_sdi" ]
set_property IOSTANDARD LVCMOS18 [ get_ports "lmx*"]
set_property SLEW SLOW [ get_ports "lmx*"]
set_property PACKAGE_PIN AW14 [ get_ports "rfswitch" ]
set_property IOSTANDARD LVCMOS18 [ get_ports "rfswitch" ]
set_property SLEW SLOW [ get_ports "rfswitch" ]
#set_property PACKAGE_PIN AU15 [ get_ports "PMOD1_4" ]
#set_property PACKAGE_PIN AP14 [ get_ports "PMOD1_5" ]
#set_property PACKAGE_PIN AT15 [ get_ports "PMOD1_6" ]
#set_property PACKAGE_PIN AU14 [ get_ports "PMOD1_7" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "PMOD1*"]

#set_property PACKAGE_PIN AW16 [ get_ports "PMOD01_0" ]
#set_property PACKAGE_PIN AW15 [ get_ports "PMOD01_1" ]
#set_property PACKAGE_PIN AW14 [ get_ports "PMOD01_2" ]
#set_property PACKAGE_PIN AR16 [ get_ports "PMOD01_3" ]
#set_property PACKAGE_PIN AV16 [ get_ports "PMOD01_4" ]
#set_property PACKAGE_PIN AT16 [ get_ports "PMOD01_5" ]
#set_property IOSTANDARD LVCMOS18 [ get_ports "PMOD01*"]


set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]
set_property BITSTREAM.CONFIG.OVERTEMPSHUTDOWN ENABLE [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

