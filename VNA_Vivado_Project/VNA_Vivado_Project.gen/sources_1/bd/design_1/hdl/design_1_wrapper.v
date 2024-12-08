//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
//Date        : Sun Dec  8 16:47:18 2024
//Host        : eecs-digital-27 running 64-bit Ubuntu 24.04.1 LTS
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (adc0_clk_clk_n,
    adc0_clk_clk_p,
    adc2_clk_clk_n,
    adc2_clk_clk_p,
    adl1_cs,
    adl1_sck,
    adl1_sdi,
    adl1_sdo,
    adl2_cs,
    adl2_sck,
    adl2_sdi,
    adl2_sdo,
    lmx_cs,
    lmx_sck,
    lmx_sdi,
    lmx_sdo,
    sysref_in_diff_n,
    sysref_in_diff_p,
    vin0_01_v_n,
    vin0_01_v_p,
    vin0_23_v_n,
    vin0_23_v_p,
    vin2_01_v_n,
    vin2_01_v_p,
    vin2_23_v_n,
    vin2_23_v_p);
  input adc0_clk_clk_n;
  input adc0_clk_clk_p;
  input adc2_clk_clk_n;
  input adc2_clk_clk_p;
  output adl1_cs;
  output adl1_sck;
  input adl1_sdi;
  output adl1_sdo;
  output adl2_cs;
  output adl2_sck;
  input adl2_sdi;
  output adl2_sdo;
  output lmx_cs;
  output lmx_sck;
  input lmx_sdi;
  output lmx_sdo;
  input sysref_in_diff_n;
  input sysref_in_diff_p;
  input vin0_01_v_n;
  input vin0_01_v_p;
  input vin0_23_v_n;
  input vin0_23_v_p;
  input vin2_01_v_n;
  input vin2_01_v_p;
  input vin2_23_v_n;
  input vin2_23_v_p;

  wire adc0_clk_clk_n;
  wire adc0_clk_clk_p;
  wire adc2_clk_clk_n;
  wire adc2_clk_clk_p;
  wire adl1_cs;
  wire adl1_sck;
  wire adl1_sdi;
  wire adl1_sdo;
  wire adl2_cs;
  wire adl2_sck;
  wire adl2_sdi;
  wire adl2_sdo;
  wire lmx_cs;
  wire lmx_sck;
  wire lmx_sdi;
  wire lmx_sdo;
  wire sysref_in_diff_n;
  wire sysref_in_diff_p;
  wire vin0_01_v_n;
  wire vin0_01_v_p;
  wire vin0_23_v_n;
  wire vin0_23_v_p;
  wire vin2_01_v_n;
  wire vin2_01_v_p;
  wire vin2_23_v_n;
  wire vin2_23_v_p;

  design_1 design_1_i
       (.adc0_clk_clk_n(adc0_clk_clk_n),
        .adc0_clk_clk_p(adc0_clk_clk_p),
        .adc2_clk_clk_n(adc2_clk_clk_n),
        .adc2_clk_clk_p(adc2_clk_clk_p),
        .adl1_cs(adl1_cs),
        .adl1_sck(adl1_sck),
        .adl1_sdi(adl1_sdi),
        .adl1_sdo(adl1_sdo),
        .adl2_cs(adl2_cs),
        .adl2_sck(adl2_sck),
        .adl2_sdi(adl2_sdi),
        .adl2_sdo(adl2_sdo),
        .lmx_cs(lmx_cs),
        .lmx_sck(lmx_sck),
        .lmx_sdi(lmx_sdi),
        .lmx_sdo(lmx_sdo),
        .sysref_in_diff_n(sysref_in_diff_n),
        .sysref_in_diff_p(sysref_in_diff_p),
        .vin0_01_v_n(vin0_01_v_n),
        .vin0_01_v_p(vin0_01_v_p),
        .vin0_23_v_n(vin0_23_v_n),
        .vin0_23_v_p(vin0_23_v_p),
        .vin2_01_v_n(vin2_01_v_n),
        .vin2_01_v_p(vin2_01_v_p),
        .vin2_23_v_n(vin2_23_v_n),
        .vin2_23_v_p(vin2_23_v_p));
endmodule
