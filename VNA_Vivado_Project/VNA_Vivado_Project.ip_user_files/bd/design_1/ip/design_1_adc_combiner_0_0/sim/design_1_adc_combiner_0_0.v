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


// IP VLNV: user.org:user:adc_combiner:1.0
// IP Revision: 2

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_adc_combiner_0_0 (
  s00_axis_aclk,
  s00_axis_aresetn,
  s00_axis_tready,
  s00_axis_tdata,
  s00_axis_tstrb,
  s00_axis_tlast,
  s00_axis_tvalid,
  s01_axis_aclk,
  s01_axis_aresetn,
  s01_axis_tready,
  s01_axis_tdata,
  s01_axis_tstrb,
  s01_axis_tlast,
  s01_axis_tvalid,
  s02_axis_aclk,
  s02_axis_aresetn,
  s02_axis_tready,
  s02_axis_tdata,
  s02_axis_tstrb,
  s02_axis_tlast,
  s02_axis_tvalid,
  s03_axis_aclk,
  s03_axis_aresetn,
  s03_axis_tready,
  s03_axis_tdata,
  s03_axis_tstrb,
  s03_axis_tlast,
  s03_axis_tvalid,
  s04_axis_aclk,
  s04_axis_aresetn,
  s04_axis_tready,
  s04_axis_tdata,
  s04_axis_tstrb,
  s04_axis_tlast,
  s04_axis_tvalid,
  s05_axis_aclk,
  s05_axis_aresetn,
  s05_axis_tready,
  s05_axis_tdata,
  s05_axis_tstrb,
  s05_axis_tlast,
  s05_axis_tvalid,
  s06_axis_aclk,
  s06_axis_aresetn,
  s06_axis_tready,
  s06_axis_tdata,
  s06_axis_tstrb,
  s06_axis_tlast,
  s06_axis_tvalid,
  s07_axis_aclk,
  s07_axis_aresetn,
  s07_axis_tready,
  s07_axis_tdata,
  s07_axis_tstrb,
  s07_axis_tlast,
  s07_axis_tvalid,
  m00_axis_aclk,
  m00_axis_aresetn,
  m00_axis_tvalid,
  m00_axis_tdata,
  m00_axis_tstrb,
  m00_axis_tlast,
  m00_axis_tready
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXIS_CLK, ASSOCIATED_BUSIF S00_AXIS, ASSOCIATED_RESET s00_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S00_AXIS_CLK CLK" *)
input wire s00_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S00_AXIS_RST RST" *)
input wire s00_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TREADY" *)
output wire s00_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TDATA" *)
input wire [15 : 0] s00_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TSTRB" *)
input wire [1 : 0] s00_axis_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TLAST" *)
input wire s00_axis_tlast;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TVALID" *)
input wire s00_axis_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S01_AXIS_CLK, ASSOCIATED_BUSIF S01_AXIS, ASSOCIATED_RESET s01_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S01_AXIS_CLK CLK" *)
input wire s01_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S01_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S01_AXIS_RST RST" *)
input wire s01_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S01_AXIS TREADY" *)
output wire s01_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S01_AXIS TDATA" *)
input wire [15 : 0] s01_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S01_AXIS TSTRB" *)
input wire [1 : 0] s01_axis_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S01_AXIS TLAST" *)
input wire s01_axis_tlast;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S01_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S01_AXIS TVALID" *)
input wire s01_axis_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S02_AXIS_CLK, ASSOCIATED_BUSIF S02_AXIS, ASSOCIATED_RESET s02_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S02_AXIS_CLK CLK" *)
input wire s02_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S02_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S02_AXIS_RST RST" *)
input wire s02_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S02_AXIS TREADY" *)
output wire s02_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S02_AXIS TDATA" *)
input wire [15 : 0] s02_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S02_AXIS TSTRB" *)
input wire [1 : 0] s02_axis_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S02_AXIS TLAST" *)
input wire s02_axis_tlast;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S02_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S02_AXIS TVALID" *)
input wire s02_axis_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S03_AXIS_CLK, ASSOCIATED_BUSIF S03_AXIS, ASSOCIATED_RESET s03_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S03_AXIS_CLK CLK" *)
input wire s03_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S03_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S03_AXIS_RST RST" *)
input wire s03_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S03_AXIS TREADY" *)
output wire s03_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S03_AXIS TDATA" *)
input wire [15 : 0] s03_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S03_AXIS TSTRB" *)
input wire [1 : 0] s03_axis_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S03_AXIS TLAST" *)
input wire s03_axis_tlast;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S03_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S03_AXIS TVALID" *)
input wire s03_axis_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S04_AXIS_CLK, ASSOCIATED_BUSIF S04_AXIS, ASSOCIATED_RESET s04_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S04_AXIS_CLK CLK" *)
input wire s04_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S04_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S04_AXIS_RST RST" *)
input wire s04_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S04_AXIS TREADY" *)
output wire s04_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S04_AXIS TDATA" *)
input wire [15 : 0] s04_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S04_AXIS TSTRB" *)
input wire [1 : 0] s04_axis_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S04_AXIS TLAST" *)
input wire s04_axis_tlast;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S04_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S04_AXIS TVALID" *)
input wire s04_axis_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S05_AXIS_CLK, ASSOCIATED_BUSIF S05_AXIS, ASSOCIATED_RESET s05_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S05_AXIS_CLK CLK" *)
input wire s05_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S05_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S05_AXIS_RST RST" *)
input wire s05_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S05_AXIS TREADY" *)
output wire s05_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S05_AXIS TDATA" *)
input wire [15 : 0] s05_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S05_AXIS TSTRB" *)
input wire [1 : 0] s05_axis_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S05_AXIS TLAST" *)
input wire s05_axis_tlast;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S05_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S05_AXIS TVALID" *)
input wire s05_axis_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S06_AXIS_CLK, ASSOCIATED_BUSIF S06_AXIS, ASSOCIATED_RESET s06_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S06_AXIS_CLK CLK" *)
input wire s06_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S06_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S06_AXIS_RST RST" *)
input wire s06_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S06_AXIS TREADY" *)
output wire s06_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S06_AXIS TDATA" *)
input wire [15 : 0] s06_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S06_AXIS TSTRB" *)
input wire [1 : 0] s06_axis_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S06_AXIS TLAST" *)
input wire s06_axis_tlast;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S06_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S06_AXIS TVALID" *)
input wire s06_axis_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S07_AXIS_CLK, ASSOCIATED_BUSIF S07_AXIS, ASSOCIATED_RESET s07_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S07_AXIS_CLK CLK" *)
input wire s07_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S07_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S07_AXIS_RST RST" *)
input wire s07_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S07_AXIS TREADY" *)
output wire s07_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S07_AXIS TDATA" *)
input wire [15 : 0] s07_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S07_AXIS TSTRB" *)
input wire [1 : 0] s07_axis_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S07_AXIS TLAST" *)
input wire s07_axis_tlast;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S07_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S07_AXIS TVALID" *)
input wire s07_axis_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M00_AXIS_CLK, ASSOCIATED_BUSIF M00_AXIS, ASSOCIATED_RESET m00_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 M00_AXIS_CLK CLK" *)
input wire m00_axis_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M00_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 M00_AXIS_RST RST" *)
input wire m00_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TVALID" *)
output wire m00_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TDATA" *)
output wire [127 : 0] m00_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TSTRB" *)
output wire [15 : 0] m00_axis_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TLAST" *)
output wire m00_axis_tlast;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M00_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 16, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TREADY" *)
input wire m00_axis_tready;

  adc_combiner #(
    .C_S07_AXIS_TDATA_WIDTH(16),  // AXI4Stream sink: Data Width
    .C_S06_AXIS_TDATA_WIDTH(16),  // AXI4Stream sink: Data Width
    .C_S03_AXIS_TDATA_WIDTH(16),  // AXI4Stream sink: Data Width
    .C_M00_AXIS_TDATA_WIDTH(128),  // Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
    .C_M00_AXIS_START_COUNT(32),  // Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.
    .C_S04_AXIS_TDATA_WIDTH(16),  // AXI4Stream sink: Data Width
    .C_S05_AXIS_TDATA_WIDTH(16),  // AXI4Stream sink: Data Width
    .C_S01_AXIS_TDATA_WIDTH(16),  // AXI4Stream sink: Data Width
    .C_S00_AXIS_TDATA_WIDTH(16),  // AXI4Stream sink: Data Width
    .C_S02_AXIS_TDATA_WIDTH(16)  // AXI4Stream sink: Data Width
  ) inst (
    .s00_axis_aclk(s00_axis_aclk),
    .s00_axis_aresetn(s00_axis_aresetn),
    .s00_axis_tready(s00_axis_tready),
    .s00_axis_tdata(s00_axis_tdata),
    .s00_axis_tstrb(s00_axis_tstrb),
    .s00_axis_tlast(s00_axis_tlast),
    .s00_axis_tvalid(s00_axis_tvalid),
    .s01_axis_aclk(s01_axis_aclk),
    .s01_axis_aresetn(s01_axis_aresetn),
    .s01_axis_tready(s01_axis_tready),
    .s01_axis_tdata(s01_axis_tdata),
    .s01_axis_tstrb(s01_axis_tstrb),
    .s01_axis_tlast(s01_axis_tlast),
    .s01_axis_tvalid(s01_axis_tvalid),
    .s02_axis_aclk(s02_axis_aclk),
    .s02_axis_aresetn(s02_axis_aresetn),
    .s02_axis_tready(s02_axis_tready),
    .s02_axis_tdata(s02_axis_tdata),
    .s02_axis_tstrb(s02_axis_tstrb),
    .s02_axis_tlast(s02_axis_tlast),
    .s02_axis_tvalid(s02_axis_tvalid),
    .s03_axis_aclk(s03_axis_aclk),
    .s03_axis_aresetn(s03_axis_aresetn),
    .s03_axis_tready(s03_axis_tready),
    .s03_axis_tdata(s03_axis_tdata),
    .s03_axis_tstrb(s03_axis_tstrb),
    .s03_axis_tlast(s03_axis_tlast),
    .s03_axis_tvalid(s03_axis_tvalid),
    .s04_axis_aclk(s04_axis_aclk),
    .s04_axis_aresetn(s04_axis_aresetn),
    .s04_axis_tready(s04_axis_tready),
    .s04_axis_tdata(s04_axis_tdata),
    .s04_axis_tstrb(s04_axis_tstrb),
    .s04_axis_tlast(s04_axis_tlast),
    .s04_axis_tvalid(s04_axis_tvalid),
    .s05_axis_aclk(s05_axis_aclk),
    .s05_axis_aresetn(s05_axis_aresetn),
    .s05_axis_tready(s05_axis_tready),
    .s05_axis_tdata(s05_axis_tdata),
    .s05_axis_tstrb(s05_axis_tstrb),
    .s05_axis_tlast(s05_axis_tlast),
    .s05_axis_tvalid(s05_axis_tvalid),
    .s06_axis_aclk(s06_axis_aclk),
    .s06_axis_aresetn(s06_axis_aresetn),
    .s06_axis_tready(s06_axis_tready),
    .s06_axis_tdata(s06_axis_tdata),
    .s06_axis_tstrb(s06_axis_tstrb),
    .s06_axis_tlast(s06_axis_tlast),
    .s06_axis_tvalid(s06_axis_tvalid),
    .s07_axis_aclk(s07_axis_aclk),
    .s07_axis_aresetn(s07_axis_aresetn),
    .s07_axis_tready(s07_axis_tready),
    .s07_axis_tdata(s07_axis_tdata),
    .s07_axis_tstrb(s07_axis_tstrb),
    .s07_axis_tlast(s07_axis_tlast),
    .s07_axis_tvalid(s07_axis_tvalid),
    .m00_axis_aclk(m00_axis_aclk),
    .m00_axis_aresetn(m00_axis_aresetn),
    .m00_axis_tvalid(m00_axis_tvalid),
    .m00_axis_tdata(m00_axis_tdata),
    .m00_axis_tstrb(m00_axis_tstrb),
    .m00_axis_tlast(m00_axis_tlast),
    .m00_axis_tready(m00_axis_tready)
  );
endmodule
