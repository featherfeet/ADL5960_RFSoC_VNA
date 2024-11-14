// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
// Date        : Thu Nov 14 14:46:29 2024
// Host        : eecs-digital-27 running 64-bit Ubuntu 24.04.1 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_usp_rf_data_converter_0_0_stub.v
// Design      : design_1_usp_rf_data_converter_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu48dr-ffvg1517-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "usp_rf_data_converter_v2_6_9,Vivado 2024.1" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(s_axi_aclk, s_axi_aresetn, s_axi_awaddr, 
  s_axi_awvalid, s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wvalid, s_axi_wready, 
  s_axi_bresp, s_axi_bvalid, s_axi_bready, s_axi_araddr, s_axi_arvalid, s_axi_arready, 
  s_axi_rdata, s_axi_rresp, s_axi_rvalid, s_axi_rready, sysref_in_p, sysref_in_n, 
  user_sysref_adc, adc0_clk_p, adc0_clk_n, clk_adc0, m0_axis_aclk, m0_axis_aresetn, adc2_clk_p, 
  adc2_clk_n, clk_adc2, m2_axis_aclk, m2_axis_aresetn, vin0_01_p, vin0_01_n, vin0_23_p, 
  vin0_23_n, vin2_01_p, vin2_01_n, vin2_23_p, vin2_23_n, m00_axis_tdata, m00_axis_tvalid, 
  m00_axis_tready, m01_axis_tdata, m01_axis_tvalid, m01_axis_tready, m02_axis_tdata, 
  m02_axis_tvalid, m02_axis_tready, m03_axis_tdata, m03_axis_tvalid, m03_axis_tready, 
  m20_axis_tdata, m20_axis_tvalid, m20_axis_tready, m21_axis_tdata, m21_axis_tvalid, 
  m21_axis_tready, m22_axis_tdata, m22_axis_tvalid, m22_axis_tready, m23_axis_tdata, 
  m23_axis_tvalid, m23_axis_tready, irq)
/* synthesis syn_black_box black_box_pad_pin="s_axi_aresetn,s_axi_awaddr[17:0],s_axi_awvalid,s_axi_awready,s_axi_wdata[31:0],s_axi_wstrb[3:0],s_axi_wvalid,s_axi_wready,s_axi_bresp[1:0],s_axi_bvalid,s_axi_bready,s_axi_araddr[17:0],s_axi_arvalid,s_axi_arready,s_axi_rdata[31:0],s_axi_rresp[1:0],s_axi_rvalid,s_axi_rready,sysref_in_p,sysref_in_n,user_sysref_adc,adc0_clk_p,adc0_clk_n,m0_axis_aresetn,adc2_clk_p,adc2_clk_n,m2_axis_aresetn,vin0_01_p,vin0_01_n,vin0_23_p,vin0_23_n,vin2_01_p,vin2_01_n,vin2_23_p,vin2_23_n,m00_axis_tdata[15:0],m00_axis_tvalid,m00_axis_tready,m01_axis_tdata[15:0],m01_axis_tvalid,m01_axis_tready,m02_axis_tdata[15:0],m02_axis_tvalid,m02_axis_tready,m03_axis_tdata[15:0],m03_axis_tvalid,m03_axis_tready,m20_axis_tdata[15:0],m20_axis_tvalid,m20_axis_tready,m21_axis_tdata[15:0],m21_axis_tvalid,m21_axis_tready,m22_axis_tdata[15:0],m22_axis_tvalid,m22_axis_tready,m23_axis_tdata[15:0],m23_axis_tvalid,m23_axis_tready,irq" */
/* synthesis syn_force_seq_prim="s_axi_aclk" */
/* synthesis syn_force_seq_prim="clk_adc0" */
/* synthesis syn_force_seq_prim="m0_axis_aclk" */
/* synthesis syn_force_seq_prim="clk_adc2" */
/* synthesis syn_force_seq_prim="m2_axis_aclk" */;
  input s_axi_aclk /* synthesis syn_isclock = 1 */;
  input s_axi_aresetn;
  input [17:0]s_axi_awaddr;
  input s_axi_awvalid;
  output s_axi_awready;
  input [31:0]s_axi_wdata;
  input [3:0]s_axi_wstrb;
  input s_axi_wvalid;
  output s_axi_wready;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [17:0]s_axi_araddr;
  input s_axi_arvalid;
  output s_axi_arready;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
  input s_axi_rready;
  input sysref_in_p;
  input sysref_in_n;
  input user_sysref_adc;
  input adc0_clk_p;
  input adc0_clk_n;
  output clk_adc0 /* synthesis syn_isclock = 1 */;
  input m0_axis_aclk /* synthesis syn_isclock = 1 */;
  input m0_axis_aresetn;
  input adc2_clk_p;
  input adc2_clk_n;
  output clk_adc2 /* synthesis syn_isclock = 1 */;
  input m2_axis_aclk /* synthesis syn_isclock = 1 */;
  input m2_axis_aresetn;
  input vin0_01_p;
  input vin0_01_n;
  input vin0_23_p;
  input vin0_23_n;
  input vin2_01_p;
  input vin2_01_n;
  input vin2_23_p;
  input vin2_23_n;
  output [15:0]m00_axis_tdata;
  output m00_axis_tvalid;
  input m00_axis_tready;
  output [15:0]m01_axis_tdata;
  output m01_axis_tvalid;
  input m01_axis_tready;
  output [15:0]m02_axis_tdata;
  output m02_axis_tvalid;
  input m02_axis_tready;
  output [15:0]m03_axis_tdata;
  output m03_axis_tvalid;
  input m03_axis_tready;
  output [15:0]m20_axis_tdata;
  output m20_axis_tvalid;
  input m20_axis_tready;
  output [15:0]m21_axis_tdata;
  output m21_axis_tvalid;
  input m21_axis_tready;
  output [15:0]m22_axis_tdata;
  output m22_axis_tvalid;
  input m22_axis_tready;
  output [15:0]m23_axis_tdata;
  output m23_axis_tvalid;
  input m23_axis_tready;
  output irq;
endmodule
