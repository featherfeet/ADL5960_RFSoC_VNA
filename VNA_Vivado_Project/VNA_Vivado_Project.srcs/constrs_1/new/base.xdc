## USER LEDS
set_property PACKAGE_PIN AR11 [ get_ports "led[0]" ]
set_property IOSTANDARD LVCMOS18 [ get_ports "led[0]" ]

set_property PACKAGE_PIN AW10 [ get_ports "led[1]" ]
set_property IOSTANDARD LVCMOS18 [ get_ports "led[1]" ]

set_property PACKAGE_PIN AT11 [ get_ports "led[2]" ]
set_property IOSTANDARD LVCMOS18 [ get_ports "led[2]" ]

set_property PACKAGE_PIN AU10 [ get_ports "led[3]" ]
set_property IOSTANDARD LVCMOS18 [ get_ports "led[3]" ]

## USER SLIDE SWITCH
set_property PACKAGE_PIN AN13 [ get_ports "sw[0]" ]
set_property IOSTANDARD LVCMOS18 [ get_ports "sw[0]" ]

set_property PACKAGE_PIN AU12 [ get_ports "sw[1]" ]
set_property IOSTANDARD LVCMOS18 [ get_ports "sw[1]" ]

set_property PACKAGE_PIN AW11 [ get_ports "sw[2]" ]
set_property IOSTANDARD LVCMOS18 [ get_ports "sw[2]" ]

set_property PACKAGE_PIN AV11 [ get_ports "sw[3]" ]
set_property IOSTANDARD LVCMOS18 [ get_ports "sw[3]" ]


set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]
set_property BITSTREAM.CONFIG.OVERTEMPSHUTDOWN ENABLE [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]