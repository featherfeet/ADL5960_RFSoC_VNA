# aclk {FREQ_HZ 147456000 CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1 PHASE 0.0} aclk1 {FREQ_HZ 99999985 CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0 PHASE 0.0}
# Clock Domain: design_1_clk_wiz_0_0_clk_out1
create_clock -name aclk -period 6.782 [get_ports aclk]
# Clock Domain: design_1_zynq_ultra_ps_e_0_0_pl_clk0
create_clock -name aclk1 -period 10.000 [get_ports aclk1]
# Generated clocks
