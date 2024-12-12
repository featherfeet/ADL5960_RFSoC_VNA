// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2024 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:DSP_top_level_w:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_DSP_top_level_w_0_1 (
  num_samples,
  s00_axis_aclk,
  s00_axis_aresetn,
  s00_axis_tlast,
  s00_axis_tvalid,
  s00_axis_tstrb,
  s01_axis_aclk,
  s01_axis_aresetn,
  s01_axis_tlast,
  s01_axis_tvalid,
  s01_axis_tstrb,
  s02_axis_aclk,
  s02_axis_aresetn,
  s02_axis_tlast,
  s02_axis_tvalid,
  s02_axis_tstrb,
  s03_axis_aclk,
  s03_axis_aresetn,
  s03_axis_tlast,
  s03_axis_tvalid,
  s03_axis_tstrb,
  s00_axis_tready,
  s01_axis_tready,
  s02_axis_tready,
  s03_axis_tready,
  s04_axis_aclk,
  s04_axis_aresetn,
  s04_axis_tlast,
  s04_axis_tvalid,
  s04_axis_tstrb,
  s05_axis_aclk,
  s05_axis_aresetn,
  s05_axis_tlast,
  s05_axis_tvalid,
  s05_axis_tstrb,
  s06_axis_aclk,
  s06_axis_aresetn,
  s06_axis_tlast,
  s06_axis_tvalid,
  s06_axis_tstrb,
  s07_axis_aclk,
  s07_axis_aresetn,
  s07_axis_tlast,
  s07_axis_tvalid,
  s07_axis_tstrb,
  s04_axis_tready,
  s05_axis_tready,
  s06_axis_tready,
  s07_axis_tready,
  m00_axis_aclk,
  m00_axis_aresetn,
  m00_axis_tready,
  m00_axis_tvalid,
  m00_axis_tlast,
  m00_axis_tstrb,
  m01_axis_aclk,
  m01_axis_aresetn,
  m01_axis_tready,
  m01_axis_tvalid,
  m01_axis_tlast,
  m01_axis_tstrb,
  m02_axis_aclk,
  m02_axis_aresetn,
  m02_axis_tready,
  m02_axis_tvalid,
  m02_axis_tlast,
  m02_axis_tstrb,
  m03_axis_aclk,
  m03_axis_aresetn,
  m03_axis_tready,
  m03_axis_tvalid,
  m03_axis_tlast,
  m03_axis_tstrb,
  s00_axis_tdata,
  s01_axis_tdata,
  s02_axis_tdata,
  s03_axis_tdata,
  s04_axis_tdata,
  s05_axis_tdata,
  s06_axis_tdata,
  s07_axis_tdata,
  m00_axis_tdata,
  m01_axis_tdata,
  m02_axis_tdata,
  m03_axis_tdata
);

input wire [15 : 0] num_samples;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s00_axis_aclk, ASSOCIATED_BUSIF s00_axis, ASSOCIATED_RESET s00_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s00_axis_aclk CLK" *)
input wire s00_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s00_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s00_axis_aresetn RST" *)
input wire s00_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s00_axis TLAST" *)
input wire s00_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s00_axis TVALID" *)
input wire s00_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s00_axis TSTRB" *)
input wire [3 : 0] s00_axis_tstrb;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s01_axis_aclk, ASSOCIATED_BUSIF s01_axis, ASSOCIATED_RESET s01_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s01_axis_aclk CLK" *)
input wire s01_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s01_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s01_axis_aresetn RST" *)
input wire s01_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s01_axis TLAST" *)
input wire s01_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s01_axis TVALID" *)
input wire s01_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s01_axis TSTRB" *)
input wire [3 : 0] s01_axis_tstrb;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s02_axis_aclk, ASSOCIATED_BUSIF s02_axis, ASSOCIATED_RESET s02_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s02_axis_aclk CLK" *)
input wire s02_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s02_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s02_axis_aresetn RST" *)
input wire s02_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s02_axis TLAST" *)
input wire s02_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s02_axis TVALID" *)
input wire s02_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s02_axis TSTRB" *)
input wire [3 : 0] s02_axis_tstrb;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s03_axis_aclk, ASSOCIATED_BUSIF s03_axis, ASSOCIATED_RESET s03_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s03_axis_aclk CLK" *)
input wire s03_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s03_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s03_axis_aresetn RST" *)
input wire s03_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s03_axis TLAST" *)
input wire s03_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s03_axis TVALID" *)
input wire s03_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s03_axis TSTRB" *)
input wire [3 : 0] s03_axis_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s00_axis TREADY" *)
output wire s00_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s01_axis TREADY" *)
output wire s01_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s02_axis TREADY" *)
output wire s02_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s03_axis TREADY" *)
output wire s03_axis_tready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s04_axis_aclk, ASSOCIATED_BUSIF s04_axis, ASSOCIATED_RESET s04_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s04_axis_aclk CLK" *)
input wire s04_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s04_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s04_axis_aresetn RST" *)
input wire s04_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s04_axis TLAST" *)
input wire s04_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s04_axis TVALID" *)
input wire s04_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s04_axis TSTRB" *)
input wire [3 : 0] s04_axis_tstrb;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s05_axis_aclk, ASSOCIATED_BUSIF s05_axis, ASSOCIATED_RESET s05_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s05_axis_aclk CLK" *)
input wire s05_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s05_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s05_axis_aresetn RST" *)
input wire s05_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s05_axis TLAST" *)
input wire s05_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s05_axis TVALID" *)
input wire s05_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s05_axis TSTRB" *)
input wire [3 : 0] s05_axis_tstrb;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s06_axis_aclk, ASSOCIATED_BUSIF s06_axis, ASSOCIATED_RESET s06_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s06_axis_aclk CLK" *)
input wire s06_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s06_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s06_axis_aresetn RST" *)
input wire s06_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s06_axis TLAST" *)
input wire s06_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s06_axis TVALID" *)
input wire s06_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s06_axis TSTRB" *)
input wire [3 : 0] s06_axis_tstrb;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s07_axis_aclk, ASSOCIATED_BUSIF s07_axis, ASSOCIATED_RESET s07_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s07_axis_aclk CLK" *)
input wire s07_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s07_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s07_axis_aresetn RST" *)
input wire s07_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s07_axis TLAST" *)
input wire s07_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s07_axis TVALID" *)
input wire s07_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s07_axis TSTRB" *)
input wire [3 : 0] s07_axis_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s04_axis TREADY" *)
output wire s04_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s05_axis TREADY" *)
output wire s05_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s06_axis TREADY" *)
output wire s06_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s07_axis TREADY" *)
output wire s07_axis_tready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m00_axis_aclk, ASSOCIATED_BUSIF m00_axis, ASSOCIATED_RESET m00_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 m00_axis_aclk CLK" *)
input wire m00_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m00_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 m00_axis_aresetn RST" *)
input wire m00_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m00_axis TREADY" *)
input wire m00_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m00_axis TVALID" *)
output wire m00_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m00_axis TLAST" *)
output wire m00_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m00_axis TSTRB" *)
output wire [3 : 0] m00_axis_tstrb;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m01_axis_aclk, ASSOCIATED_BUSIF m01_axis, ASSOCIATED_RESET m01_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 m01_axis_aclk CLK" *)
input wire m01_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m01_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 m01_axis_aresetn RST" *)
input wire m01_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m01_axis TREADY" *)
input wire m01_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m01_axis TVALID" *)
output wire m01_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m01_axis TLAST" *)
output wire m01_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m01_axis TSTRB" *)
output wire [3 : 0] m01_axis_tstrb;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m02_axis_aclk, ASSOCIATED_BUSIF m02_axis, ASSOCIATED_RESET m02_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 m02_axis_aclk CLK" *)
input wire m02_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m02_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 m02_axis_aresetn RST" *)
input wire m02_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m02_axis TREADY" *)
input wire m02_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m02_axis TVALID" *)
output wire m02_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m02_axis TLAST" *)
output wire m02_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m02_axis TSTRB" *)
output wire [3 : 0] m02_axis_tstrb;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m03_axis_aclk, ASSOCIATED_BUSIF m03_axis, ASSOCIATED_RESET m03_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 m03_axis_aclk CLK" *)
input wire m03_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m03_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 m03_axis_aresetn RST" *)
input wire m03_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m03_axis TREADY" *)
input wire m03_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m03_axis TVALID" *)
output wire m03_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m03_axis TLAST" *)
output wire m03_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m03_axis TSTRB" *)
output wire [3 : 0] m03_axis_tstrb;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s00_axis, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s00_axis TDATA" *)
input wire [15 : 0] s00_axis_tdata;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s01_axis, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s01_axis TDATA" *)
input wire [15 : 0] s01_axis_tdata;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s02_axis, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s02_axis TDATA" *)
input wire [15 : 0] s02_axis_tdata;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s03_axis, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s03_axis TDATA" *)
input wire [15 : 0] s03_axis_tdata;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s04_axis, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s04_axis TDATA" *)
input wire [15 : 0] s04_axis_tdata;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s05_axis, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s05_axis TDATA" *)
input wire [15 : 0] s05_axis_tdata;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s06_axis, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s06_axis TDATA" *)
input wire [15 : 0] s06_axis_tdata;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s07_axis, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s07_axis TDATA" *)
input wire [15 : 0] s07_axis_tdata;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m00_axis, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m00_axis TDATA" *)
output wire [63 : 0] m00_axis_tdata;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m01_axis, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m01_axis TDATA" *)
output wire [63 : 0] m01_axis_tdata;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m02_axis, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m02_axis TDATA" *)
output wire [63 : 0] m02_axis_tdata;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m03_axis, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m03_axis TDATA" *)
output wire [63 : 0] m03_axis_tdata;

  DSP_top_level_w #(
    .C_S00_AXIS_TDATA_WIDTH(32),
    .C_M00_AXIS_TDATA_WIDTH(32)
  ) inst (
    .num_samples(num_samples),
    .s00_axis_aclk(s00_axis_aclk),
    .s00_axis_aresetn(s00_axis_aresetn),
    .s00_axis_tlast(s00_axis_tlast),
    .s00_axis_tvalid(s00_axis_tvalid),
    .s00_axis_tstrb(s00_axis_tstrb),
    .s01_axis_aclk(s01_axis_aclk),
    .s01_axis_aresetn(s01_axis_aresetn),
    .s01_axis_tlast(s01_axis_tlast),
    .s01_axis_tvalid(s01_axis_tvalid),
    .s01_axis_tstrb(s01_axis_tstrb),
    .s02_axis_aclk(s02_axis_aclk),
    .s02_axis_aresetn(s02_axis_aresetn),
    .s02_axis_tlast(s02_axis_tlast),
    .s02_axis_tvalid(s02_axis_tvalid),
    .s02_axis_tstrb(s02_axis_tstrb),
    .s03_axis_aclk(s03_axis_aclk),
    .s03_axis_aresetn(s03_axis_aresetn),
    .s03_axis_tlast(s03_axis_tlast),
    .s03_axis_tvalid(s03_axis_tvalid),
    .s03_axis_tstrb(s03_axis_tstrb),
    .s00_axis_tready(s00_axis_tready),
    .s01_axis_tready(s01_axis_tready),
    .s02_axis_tready(s02_axis_tready),
    .s03_axis_tready(s03_axis_tready),
    .s04_axis_aclk(s04_axis_aclk),
    .s04_axis_aresetn(s04_axis_aresetn),
    .s04_axis_tlast(s04_axis_tlast),
    .s04_axis_tvalid(s04_axis_tvalid),
    .s04_axis_tstrb(s04_axis_tstrb),
    .s05_axis_aclk(s05_axis_aclk),
    .s05_axis_aresetn(s05_axis_aresetn),
    .s05_axis_tlast(s05_axis_tlast),
    .s05_axis_tvalid(s05_axis_tvalid),
    .s05_axis_tstrb(s05_axis_tstrb),
    .s06_axis_aclk(s06_axis_aclk),
    .s06_axis_aresetn(s06_axis_aresetn),
    .s06_axis_tlast(s06_axis_tlast),
    .s06_axis_tvalid(s06_axis_tvalid),
    .s06_axis_tstrb(s06_axis_tstrb),
    .s07_axis_aclk(s07_axis_aclk),
    .s07_axis_aresetn(s07_axis_aresetn),
    .s07_axis_tlast(s07_axis_tlast),
    .s07_axis_tvalid(s07_axis_tvalid),
    .s07_axis_tstrb(s07_axis_tstrb),
    .s04_axis_tready(s04_axis_tready),
    .s05_axis_tready(s05_axis_tready),
    .s06_axis_tready(s06_axis_tready),
    .s07_axis_tready(s07_axis_tready),
    .m00_axis_aclk(m00_axis_aclk),
    .m00_axis_aresetn(m00_axis_aresetn),
    .m00_axis_tready(m00_axis_tready),
    .m00_axis_tvalid(m00_axis_tvalid),
    .m00_axis_tlast(m00_axis_tlast),
    .m00_axis_tstrb(m00_axis_tstrb),
    .m01_axis_aclk(m01_axis_aclk),
    .m01_axis_aresetn(m01_axis_aresetn),
    .m01_axis_tready(m01_axis_tready),
    .m01_axis_tvalid(m01_axis_tvalid),
    .m01_axis_tlast(m01_axis_tlast),
    .m01_axis_tstrb(m01_axis_tstrb),
    .m02_axis_aclk(m02_axis_aclk),
    .m02_axis_aresetn(m02_axis_aresetn),
    .m02_axis_tready(m02_axis_tready),
    .m02_axis_tvalid(m02_axis_tvalid),
    .m02_axis_tlast(m02_axis_tlast),
    .m02_axis_tstrb(m02_axis_tstrb),
    .m03_axis_aclk(m03_axis_aclk),
    .m03_axis_aresetn(m03_axis_aresetn),
    .m03_axis_tready(m03_axis_tready),
    .m03_axis_tvalid(m03_axis_tvalid),
    .m03_axis_tlast(m03_axis_tlast),
    .m03_axis_tstrb(m03_axis_tstrb),
    .s00_axis_tdata(s00_axis_tdata),
    .s01_axis_tdata(s01_axis_tdata),
    .s02_axis_tdata(s02_axis_tdata),
    .s03_axis_tdata(s03_axis_tdata),
    .s04_axis_tdata(s04_axis_tdata),
    .s05_axis_tdata(s05_axis_tdata),
    .s06_axis_tdata(s06_axis_tdata),
    .s07_axis_tdata(s07_axis_tdata),
    .m00_axis_tdata(m00_axis_tdata),
    .m01_axis_tdata(m01_axis_tdata),
    .m02_axis_tdata(m02_axis_tdata),
    .m03_axis_tdata(m03_axis_tdata)
  );
endmodule
