// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
// Date        : Thu Nov 14 14:45:11 2024
// Host        : eecs-digital-27 running 64-bit Ubuntu 24.04.1 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top design_1_tlast_3_0 -prefix
//               design_1_tlast_3_0_ design_1_tlast_2_0_stub.v
// Design      : design_1_tlast_2_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu48dr-ffvg1517-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "tlast,Vivado 2024.1" *)
module design_1_tlast_3_0(s00_axis_aclk, s00_axis_aresetn, 
  s00_axis_tready, s00_axis_tdata, s00_axis_tstrb, s00_axis_tlast, s00_axis_tvalid, 
  s01_axis_aclk, s01_axis_aresetn, s01_axis_tready, s01_axis_tdata, s01_axis_tstrb, 
  s01_axis_tlast, s01_axis_tvalid, m00_axis_aclk, m00_axis_aresetn, m00_axis_tvalid, 
  m00_axis_tdata, m00_axis_tstrb, m00_axis_tlast, m00_axis_tready)
/* synthesis syn_black_box black_box_pad_pin="s00_axis_aresetn,s00_axis_tready,s00_axis_tdata[15:0],s00_axis_tstrb[1:0],s00_axis_tlast,s00_axis_tvalid,s01_axis_aclk,s01_axis_aresetn,s01_axis_tready,s01_axis_tdata[15:0],s01_axis_tstrb[1:0],s01_axis_tlast,s01_axis_tvalid,m00_axis_aclk,m00_axis_aresetn,m00_axis_tvalid,m00_axis_tdata[31:0],m00_axis_tstrb[3:0],m00_axis_tlast,m00_axis_tready" */
/* synthesis syn_force_seq_prim="s00_axis_aclk" */;
  input s00_axis_aclk /* synthesis syn_isclock = 1 */;
  input s00_axis_aresetn;
  output s00_axis_tready;
  input [15:0]s00_axis_tdata;
  input [1:0]s00_axis_tstrb;
  input s00_axis_tlast;
  input s00_axis_tvalid;
  input s01_axis_aclk;
  input s01_axis_aresetn;
  output s01_axis_tready;
  input [15:0]s01_axis_tdata;
  input [1:0]s01_axis_tstrb;
  input s01_axis_tlast;
  input s01_axis_tvalid;
  input m00_axis_aclk;
  input m00_axis_aresetn;
  output m00_axis_tvalid;
  output [31:0]m00_axis_tdata;
  output [3:0]m00_axis_tstrb;
  output m00_axis_tlast;
  input m00_axis_tready;
endmodule
