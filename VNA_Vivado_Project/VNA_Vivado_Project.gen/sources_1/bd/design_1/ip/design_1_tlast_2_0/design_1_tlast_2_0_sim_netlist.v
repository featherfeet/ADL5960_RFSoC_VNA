// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
// Date        : Thu Nov 14 14:45:11 2024
// Host        : eecs-digital-27 running 64-bit Ubuntu 24.04.1 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/olt/ADL5960_RFSoC_VNA/VNA_Vivado_Project/VNA_Vivado_Project.gen/sources_1/bd/design_1/ip/design_1_tlast_2_0/design_1_tlast_2_0_sim_netlist.v
// Design      : design_1_tlast_2_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu48dr-ffvg1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_tlast_2_0,tlast,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "tlast,Vivado 2024.1" *) 
(* NotValidForBitStream *)
module design_1_tlast_2_0
   (s00_axis_aclk,
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
    m00_axis_aclk,
    m00_axis_aresetn,
    m00_axis_tvalid,
    m00_axis_tdata,
    m00_axis_tstrb,
    m00_axis_tlast,
    m00_axis_tready);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S00_AXIS_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXIS_CLK, ASSOCIATED_BUSIF S00_AXIS, ASSOCIATED_RESET s00_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *) input s00_axis_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S00_AXIS_RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s00_axis_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TREADY" *) output s00_axis_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TDATA" *) input [15:0]s00_axis_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TSTRB" *) input [1:0]s00_axis_tstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TLAST" *) input s00_axis_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *) input s00_axis_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S01_AXIS_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S01_AXIS_CLK, ASSOCIATED_BUSIF S01_AXIS, ASSOCIATED_RESET s01_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *) input s01_axis_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S01_AXIS_RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S01_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s01_axis_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S01_AXIS TREADY" *) output s01_axis_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S01_AXIS TDATA" *) input [15:0]s01_axis_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S01_AXIS TSTRB" *) input [1:0]s01_axis_tstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S01_AXIS TLAST" *) input s01_axis_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S01_AXIS TVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S01_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *) input s01_axis_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 M00_AXIS_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M00_AXIS_CLK, ASSOCIATED_BUSIF M00_AXIS, ASSOCIATED_RESET m00_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *) input m00_axis_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 M00_AXIS_RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M00_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input m00_axis_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TVALID" *) output m00_axis_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TDATA" *) output [31:0]m00_axis_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TSTRB" *) output [3:0]m00_axis_tstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TLAST" *) output m00_axis_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M00_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *) input m00_axis_tready;

  wire \<const1> ;
  wire m00_axis_tlast;
  wire m00_axis_tready;
  wire s00_axis_aclk;
  wire s00_axis_aresetn;
  wire [15:0]s00_axis_tdata;
  wire s00_axis_tvalid;
  wire [15:0]s01_axis_tdata;

  assign m00_axis_tdata[31:16] = s01_axis_tdata;
  assign m00_axis_tdata[15:0] = s00_axis_tdata;
  assign m00_axis_tstrb[3] = \<const1> ;
  assign m00_axis_tstrb[2] = \<const1> ;
  assign m00_axis_tstrb[1] = \<const1> ;
  assign m00_axis_tstrb[0] = \<const1> ;
  assign m00_axis_tvalid = s00_axis_tvalid;
  assign s00_axis_tready = m00_axis_tready;
  assign s01_axis_tready = m00_axis_tready;
  VCC VCC
       (.P(\<const1> ));
  design_1_tlast_2_0_tlast inst
       (.m00_axis_tlast(m00_axis_tlast),
        .m00_axis_tready(m00_axis_tready),
        .s00_axis_aclk(s00_axis_aclk),
        .s00_axis_aresetn(s00_axis_aresetn),
        .s00_axis_tvalid(s00_axis_tvalid));
endmodule

(* ORIG_REF_NAME = "tlast" *) 
module design_1_tlast_2_0_tlast
   (m00_axis_tlast,
    s00_axis_aclk,
    s00_axis_tvalid,
    m00_axis_tready,
    s00_axis_aresetn);
  output m00_axis_tlast;
  input s00_axis_aclk;
  input s00_axis_tvalid;
  input m00_axis_tready;
  input s00_axis_aresetn;

  wire [17:0]count;
  wire count0;
  wire \count0_inferred__0/i__carry__0_n_0 ;
  wire \count0_inferred__0/i__carry__0_n_1 ;
  wire \count0_inferred__0/i__carry__0_n_2 ;
  wire \count0_inferred__0/i__carry__0_n_3 ;
  wire \count0_inferred__0/i__carry__0_n_4 ;
  wire \count0_inferred__0/i__carry__0_n_5 ;
  wire \count0_inferred__0/i__carry__0_n_6 ;
  wire \count0_inferred__0/i__carry__0_n_7 ;
  wire \count0_inferred__0/i__carry_n_0 ;
  wire \count0_inferred__0/i__carry_n_1 ;
  wire \count0_inferred__0/i__carry_n_2 ;
  wire \count0_inferred__0/i__carry_n_3 ;
  wire \count0_inferred__0/i__carry_n_4 ;
  wire \count0_inferred__0/i__carry_n_5 ;
  wire \count0_inferred__0/i__carry_n_6 ;
  wire \count0_inferred__0/i__carry_n_7 ;
  wire [17:0]count_0;
  wire [17:1]data0;
  wire m00_axis_tlast;
  wire m00_axis_tlast_i_1_n_0;
  wire m00_axis_tlast_i_2_n_0;
  wire m00_axis_tlast_i_3_n_0;
  wire m00_axis_tlast_i_4_n_0;
  wire m00_axis_tlast_i_5_n_0;
  wire m00_axis_tlast_i_6_n_0;
  wire m00_axis_tready;
  wire p_0_in;
  wire s00_axis_aclk;
  wire s00_axis_aresetn;
  wire s00_axis_tvalid;
  wire [7:0]\NLW_count0_inferred__0/i__carry__1_CO_UNCONNECTED ;
  wire [7:1]\NLW_count0_inferred__0/i__carry__1_O_UNCONNECTED ;

  (* ADDER_THRESHOLD = "35" *) 
  CARRY8 \count0_inferred__0/i__carry 
       (.CI(count[0]),
        .CI_TOP(1'b0),
        .CO({\count0_inferred__0/i__carry_n_0 ,\count0_inferred__0/i__carry_n_1 ,\count0_inferred__0/i__carry_n_2 ,\count0_inferred__0/i__carry_n_3 ,\count0_inferred__0/i__carry_n_4 ,\count0_inferred__0/i__carry_n_5 ,\count0_inferred__0/i__carry_n_6 ,\count0_inferred__0/i__carry_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:1]),
        .S(count[8:1]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY8 \count0_inferred__0/i__carry__0 
       (.CI(\count0_inferred__0/i__carry_n_0 ),
        .CI_TOP(1'b0),
        .CO({\count0_inferred__0/i__carry__0_n_0 ,\count0_inferred__0/i__carry__0_n_1 ,\count0_inferred__0/i__carry__0_n_2 ,\count0_inferred__0/i__carry__0_n_3 ,\count0_inferred__0/i__carry__0_n_4 ,\count0_inferred__0/i__carry__0_n_5 ,\count0_inferred__0/i__carry__0_n_6 ,\count0_inferred__0/i__carry__0_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O(data0[16:9]),
        .S(count[16:9]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY8 \count0_inferred__0/i__carry__1 
       (.CI(\count0_inferred__0/i__carry__0_n_0 ),
        .CI_TOP(1'b0),
        .CO(\NLW_count0_inferred__0/i__carry__1_CO_UNCONNECTED [7:0]),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_count0_inferred__0/i__carry__1_O_UNCONNECTED [7:1],data0[17]}),
        .S({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,count[17]}));
  LUT1 #(
    .INIT(2'h1)) 
    \count[0]_i_1 
       (.I0(count[0]),
        .O(count_0[0]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[10]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[10]),
        .O(count_0[10]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[11]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[11]),
        .O(count_0[11]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[12]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[12]),
        .O(count_0[12]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[13]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[13]),
        .O(count_0[13]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[14]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[14]),
        .O(count_0[14]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[15]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[15]),
        .O(count_0[15]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[16]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[16]),
        .O(count_0[16]));
  LUT1 #(
    .INIT(2'h1)) 
    \count[17]_i_1 
       (.I0(s00_axis_aresetn),
        .O(p_0_in));
  LUT2 #(
    .INIT(4'h8)) 
    \count[17]_i_2 
       (.I0(m00_axis_tready),
        .I1(s00_axis_tvalid),
        .O(count0));
  LUT2 #(
    .INIT(4'h8)) 
    \count[17]_i_3 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[17]),
        .O(count_0[17]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[1]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[1]),
        .O(count_0[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[2]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[2]),
        .O(count_0[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[3]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[3]),
        .O(count_0[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[4]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[4]),
        .O(count_0[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[5]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[5]),
        .O(count_0[5]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[6]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[6]),
        .O(count_0[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[7]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[7]),
        .O(count_0[7]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[8]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[8]),
        .O(count_0[8]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \count[9]_i_1 
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(data0[9]),
        .O(count_0[9]));
  FDRE \count_reg[0] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[0]),
        .Q(count[0]),
        .R(p_0_in));
  FDRE \count_reg[10] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[10]),
        .Q(count[10]),
        .R(p_0_in));
  FDRE \count_reg[11] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[11]),
        .Q(count[11]),
        .R(p_0_in));
  FDRE \count_reg[12] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[12]),
        .Q(count[12]),
        .R(p_0_in));
  FDRE \count_reg[13] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[13]),
        .Q(count[13]),
        .R(p_0_in));
  FDRE \count_reg[14] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[14]),
        .Q(count[14]),
        .R(p_0_in));
  FDRE \count_reg[15] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[15]),
        .Q(count[15]),
        .R(p_0_in));
  FDRE \count_reg[16] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[16]),
        .Q(count[16]),
        .R(p_0_in));
  FDRE \count_reg[17] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[17]),
        .Q(count[17]),
        .R(p_0_in));
  FDRE \count_reg[1] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[1]),
        .Q(count[1]),
        .R(p_0_in));
  FDRE \count_reg[2] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[2]),
        .Q(count[2]),
        .R(p_0_in));
  FDRE \count_reg[3] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[3]),
        .Q(count[3]),
        .R(p_0_in));
  FDRE \count_reg[4] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[4]),
        .Q(count[4]),
        .R(p_0_in));
  FDRE \count_reg[5] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[5]),
        .Q(count[5]),
        .R(p_0_in));
  FDRE \count_reg[6] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[6]),
        .Q(count[6]),
        .R(p_0_in));
  FDRE \count_reg[7] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[7]),
        .Q(count[7]),
        .R(p_0_in));
  FDRE \count_reg[8] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[8]),
        .Q(count[8]),
        .R(p_0_in));
  FDRE \count_reg[9] 
       (.C(s00_axis_aclk),
        .CE(count0),
        .D(count_0[9]),
        .Q(count[9]),
        .R(p_0_in));
  LUT5 #(
    .INIT(32'h7FFF4000)) 
    m00_axis_tlast_i_1
       (.I0(m00_axis_tlast_i_2_n_0),
        .I1(s00_axis_tvalid),
        .I2(m00_axis_tready),
        .I3(s00_axis_aresetn),
        .I4(m00_axis_tlast),
        .O(m00_axis_tlast_i_1_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    m00_axis_tlast_i_2
       (.I0(m00_axis_tlast_i_3_n_0),
        .I1(m00_axis_tlast_i_4_n_0),
        .I2(m00_axis_tlast_i_5_n_0),
        .I3(m00_axis_tlast_i_6_n_0),
        .O(m00_axis_tlast_i_2_n_0));
  LUT4 #(
    .INIT(16'h7FFF)) 
    m00_axis_tlast_i_3
       (.I0(count[3]),
        .I1(count[2]),
        .I2(count[5]),
        .I3(count[4]),
        .O(m00_axis_tlast_i_3_n_0));
  LUT6 #(
    .INIT(64'hEFFFFFFFFFFFFFFF)) 
    m00_axis_tlast_i_4
       (.I0(count[16]),
        .I1(count[17]),
        .I2(count[14]),
        .I3(count[15]),
        .I4(count[1]),
        .I5(count[0]),
        .O(m00_axis_tlast_i_4_n_0));
  LUT4 #(
    .INIT(16'h7FFF)) 
    m00_axis_tlast_i_5
       (.I0(count[11]),
        .I1(count[10]),
        .I2(count[13]),
        .I3(count[12]),
        .O(m00_axis_tlast_i_5_n_0));
  LUT4 #(
    .INIT(16'h7FFF)) 
    m00_axis_tlast_i_6
       (.I0(count[7]),
        .I1(count[6]),
        .I2(count[9]),
        .I3(count[8]),
        .O(m00_axis_tlast_i_6_n_0));
  FDRE m00_axis_tlast_reg
       (.C(s00_axis_aclk),
        .CE(1'b1),
        .D(m00_axis_tlast_i_1_n_0),
        .Q(m00_axis_tlast),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
