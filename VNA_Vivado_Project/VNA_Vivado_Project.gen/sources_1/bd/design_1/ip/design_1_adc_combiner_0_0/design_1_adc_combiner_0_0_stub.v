// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
// Date        : Mon Nov 25 14:31:14 2024
// Host        : eecs-digital-28 running 64-bit Ubuntu 24.04.1 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/olt/ADL5960_RFSoC_VNA/VNA_Vivado_Project/VNA_Vivado_Project.gen/sources_1/bd/design_1/ip/design_1_adc_combiner_0_0/design_1_adc_combiner_0_0_stub.v
// Design      : design_1_adc_combiner_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu48dr-ffvg1517-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "adc_combiner,Vivado 2024.1" *)
module design_1_adc_combiner_0_0(s00_axis_aclk, s00_axis_aresetn, 
  s00_axis_tready, s00_axis_tdata, s00_axis_tstrb, s00_axis_tlast, s00_axis_tvalid, 
  s01_axis_aclk, s01_axis_aresetn, s01_axis_tready, s01_axis_tdata, s01_axis_tstrb, 
  s01_axis_tlast, s01_axis_tvalid, s02_axis_aclk, s02_axis_aresetn, s02_axis_tready, 
  s02_axis_tdata, s02_axis_tstrb, s02_axis_tlast, s02_axis_tvalid, s03_axis_aclk, 
  s03_axis_aresetn, s03_axis_tready, s03_axis_tdata, s03_axis_tstrb, s03_axis_tlast, 
  s03_axis_tvalid, s04_axis_aclk, s04_axis_aresetn, s04_axis_tready, s04_axis_tdata, 
  s04_axis_tstrb, s04_axis_tlast, s04_axis_tvalid, s05_axis_aclk, s05_axis_aresetn, 
  s05_axis_tready, s05_axis_tdata, s05_axis_tstrb, s05_axis_tlast, s05_axis_tvalid, 
  s06_axis_aclk, s06_axis_aresetn, s06_axis_tready, s06_axis_tdata, s06_axis_tstrb, 
  s06_axis_tlast, s06_axis_tvalid, s07_axis_aclk, s07_axis_aresetn, s07_axis_tready, 
  s07_axis_tdata, s07_axis_tstrb, s07_axis_tlast, s07_axis_tvalid, m00_axis_aclk, 
  m00_axis_aresetn, m00_axis_tvalid, m00_axis_tdata, m00_axis_tstrb, m00_axis_tlast, 
  m00_axis_tready)
/* synthesis syn_black_box black_box_pad_pin="s00_axis_aresetn,s00_axis_tready,s00_axis_tdata[15:0],s00_axis_tstrb[1:0],s00_axis_tlast,s00_axis_tvalid,s01_axis_aclk,s01_axis_aresetn,s01_axis_tready,s01_axis_tdata[15:0],s01_axis_tstrb[1:0],s01_axis_tlast,s01_axis_tvalid,s02_axis_aclk,s02_axis_aresetn,s02_axis_tready,s02_axis_tdata[15:0],s02_axis_tstrb[1:0],s02_axis_tlast,s02_axis_tvalid,s03_axis_aclk,s03_axis_aresetn,s03_axis_tready,s03_axis_tdata[15:0],s03_axis_tstrb[1:0],s03_axis_tlast,s03_axis_tvalid,s04_axis_aclk,s04_axis_aresetn,s04_axis_tready,s04_axis_tdata[15:0],s04_axis_tstrb[1:0],s04_axis_tlast,s04_axis_tvalid,s05_axis_aclk,s05_axis_aresetn,s05_axis_tready,s05_axis_tdata[15:0],s05_axis_tstrb[1:0],s05_axis_tlast,s05_axis_tvalid,s06_axis_aclk,s06_axis_aresetn,s06_axis_tready,s06_axis_tdata[15:0],s06_axis_tstrb[1:0],s06_axis_tlast,s06_axis_tvalid,s07_axis_aclk,s07_axis_aresetn,s07_axis_tready,s07_axis_tdata[15:0],s07_axis_tstrb[1:0],s07_axis_tlast,s07_axis_tvalid,m00_axis_aclk,m00_axis_aresetn,m00_axis_tvalid,m00_axis_tdata[127:0],m00_axis_tstrb[15:0],m00_axis_tlast,m00_axis_tready" */
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
  input s02_axis_aclk;
  input s02_axis_aresetn;
  output s02_axis_tready;
  input [15:0]s02_axis_tdata;
  input [1:0]s02_axis_tstrb;
  input s02_axis_tlast;
  input s02_axis_tvalid;
  input s03_axis_aclk;
  input s03_axis_aresetn;
  output s03_axis_tready;
  input [15:0]s03_axis_tdata;
  input [1:0]s03_axis_tstrb;
  input s03_axis_tlast;
  input s03_axis_tvalid;
  input s04_axis_aclk;
  input s04_axis_aresetn;
  output s04_axis_tready;
  input [15:0]s04_axis_tdata;
  input [1:0]s04_axis_tstrb;
  input s04_axis_tlast;
  input s04_axis_tvalid;
  input s05_axis_aclk;
  input s05_axis_aresetn;
  output s05_axis_tready;
  input [15:0]s05_axis_tdata;
  input [1:0]s05_axis_tstrb;
  input s05_axis_tlast;
  input s05_axis_tvalid;
  input s06_axis_aclk;
  input s06_axis_aresetn;
  output s06_axis_tready;
  input [15:0]s06_axis_tdata;
  input [1:0]s06_axis_tstrb;
  input s06_axis_tlast;
  input s06_axis_tvalid;
  input s07_axis_aclk;
  input s07_axis_aresetn;
  output s07_axis_tready;
  input [15:0]s07_axis_tdata;
  input [1:0]s07_axis_tstrb;
  input s07_axis_tlast;
  input s07_axis_tvalid;
  input m00_axis_aclk;
  input m00_axis_aresetn;
  output m00_axis_tvalid;
  output [127:0]m00_axis_tdata;
  output [15:0]m00_axis_tstrb;
  output m00_axis_tlast;
  input m00_axis_tready;
endmodule
