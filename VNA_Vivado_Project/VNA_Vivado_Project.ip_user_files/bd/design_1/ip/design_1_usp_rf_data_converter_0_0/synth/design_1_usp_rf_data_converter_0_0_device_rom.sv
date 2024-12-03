//----------------------------------------------------------------------------
// Title : ROM for tile configuration
// Project : Ultrascale+ RF Data Converter Subsystem
//----------------------------------------------------------------------------
//
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


`timescale 1ps/1ps

module design_1_usp_rf_data_converter_0_0_device_rom (
    aux_clk,
    data_index,
    data_out,
    addr_out,
    tile_out
  );

    input aux_clk;

    input [10:0] data_index;

    output [15:0] data_out;
    output [10:0] addr_out;
    output [2:0]  tile_out;

    reg [29:0] data;

    // The 30-bit data in the array follows the format below:
    // 29:27 |  26:24  |    23:16    |    15:0
    // Tile  |  Slice  | DRP Address |  DRP Data

    (* rom_style = "distributed" *) reg [29:0] data_array [0:232] = '{
       30'h07230000,  // Clock Network Control 0 (ADC0)
       30'h07240000,  // Clock Network Control 1 (ADC0)
       30'h07222000,  // Clock Distribution Control (ADC0)
       30'h07170016,  // PLL FB Div (ADC0)
       30'h070c00c2,  // PLL Output Divide (ADC0)
       30'h07100010,  // PLL Ref clock divide (ADC0)
       30'h07000080,  // PLL SDM CONFIG0 (ADC0)
       30'h07060111,  // PLL SDM seed (ADC0)
       30'h07070011,  // PLL SDM seed setup (ADC0)
       30'h070e0d37,  // PLL ChargePump setup (ADC0)
       30'h070f2080,  // PLL temprature sensor control (ADC0)
       30'h0712ffff,  // PLL ChargePump setup (ADC0)
       30'h07137f95,  // PLL loop filter setup (ADC0)
       30'h07140006,  // PLL loop filter setup (ADC0)
       30'h07155800,  // PLL VCO setup (ADC0)
       30'h07160008,  // PLL VCO setup (ADC0)
       30'h070a7a20,  // PLL Coarse Frequency setup (ADC0)
       30'h070b7008,  // PLL Coarse Frequency setup (ADC0)
       30'h0711002d,  // PLL Voltage Regulator setup (ADC0)
       30'h072c0025,  // CLK_DIV (ADC0)
       30'h07280280,  // SYSREF Distribution (ADC0)
       30'h072dfffc,  // HSCOM_PWR_MASK (ADC0)
       30'h07310062,  // CLOCK_DETECT_CTRL0 (ADC0)
       30'h07320032,  // CLOCK_DETECT_CTRL1 (ADC0)
       30'h07300040,  // FIFO_START (ADC0)
       30'h00020101,  // ADC00 Data Width
       30'h00100003,  // ADC00 Decimation Config
       30'h0011000a,  // ADC00 Decimation Mode
       30'h00221015,  // ADC00 Mixer Mode
       30'h002a0001,  // ADC00 NCO Phase Mode
       30'h0027e38e,  // ADC00 NCO Frequency Word 0
       30'h00268e38,  // ADC00 NCO Frequency Word 1
       30'h0025fe43,  // ADC00 NCO Frequency Word 2
       30'h00290000,  // ADC00 NCO Phase Offset Word 0
       30'h00280000,  // ADC00 NCO Phase Offset Word 1
       30'h003a0020,  // ADC00 Switch Matrix Config
       30'h007101f1,  // ADC00 RX MC Config 0
       30'h00780002,  // ADC00 DSA Control
       30'h005181c3,  // ADC00 TI_DCB_CTRL0
       30'h0055d44a,  // ADC00 TI_TIME_SKEW_CTRL0
       30'h005a0002,  // ADC00 TI_TIME_SKEW_CTRL5
       30'h001d001c,  // ADC00 CAL_FREEZE_MASK
       30'h00450091,  // ADC00_SIG_DET_CTRL
       30'h00460148,  // ADC00_SIG_DET_THRESHOLD_LEVEL0
       30'h0047012c,  // ADC00_SIG_DET_THRESHOLD_LEVEL0_CNT_ON
       30'h0048012c,  // ADC00_SIG_DET_THRESHOLD_LEVEL0_CNT_OFF
       30'h00060001,  // ADC00 FABRIC_DEBUG
       30'h01020101,  // ADC01 Data Width
       30'h01100003,  // ADC01 Decimation Config
       30'h0111000a,  // ADC01 Decimation Mode
       30'h01221015,  // ADC01 Mixer Mode
       30'h012a0002,  // ADC01 NCO Phase Mode
       30'h0127e38e,  // ADC01 NCO Frequency Word 0
       30'h01268e38,  // ADC01 NCO Frequency Word 1
       30'h0125fe43,  // ADC01 NCO Frequency Word 2
       30'h01290000,  // ADC01 NCO Phase Offset Word 0
       30'h01280000,  // ADC01 NCO Phase Offset Word 1
       30'h013a0024,  // ADC01 Switch Matrix Config
       30'h017101f9,  // ADC01 RX MC Config 0
       30'h01780002,  // ADC01 DSA Control
       30'h015181c7,  // ADC01 TI_DCB_CTRL0
       30'h0155d44a,  // ADC01 TI_TIME_SKEW_CTRL0
       30'h015a0002,  // ADC01 TI_TIME_SKEW_CTRL5
       30'h011d001c,  // ADC01 CAL_FREEZE_MASK
       30'h01450091,  // ADC01_SIG_DET_CTRL
       30'h01460148,  // ADC01_SIG_DET_THRESHOLD_LEVEL0
       30'h0147012c,  // ADC01_SIG_DET_THRESHOLD_LEVEL0_CNT_ON
       30'h0148012c,  // ADC01_SIG_DET_THRESHOLD_LEVEL0_CNT_OFF
       30'h01060001,  // ADC01 FABRIC_DEBUG
       30'h02020101,  // ADC02 Data Width
       30'h02100003,  // ADC02 Decimation Config
       30'h0211000a,  // ADC02 Decimation Mode
       30'h02221015,  // ADC02 Mixer Mode
       30'h022a0001,  // ADC02 NCO Phase Mode
       30'h0227e38e,  // ADC02 NCO Frequency Word 0
       30'h02268e38,  // ADC02 NCO Frequency Word 1
       30'h0225fe43,  // ADC02 NCO Frequency Word 2
       30'h02290000,  // ADC02 NCO Phase Offset Word 0
       30'h02280000,  // ADC02 NCO Phase Offset Word 1
       30'h023a0028,  // ADC02 Switch Matrix Config
       30'h027101f1,  // ADC02 RX MC Config 0
       30'h02780002,  // ADC02 DSA Control
       30'h025181c3,  // ADC02 TI_DCB_CTRL0
       30'h0255d44a,  // ADC02 TI_TIME_SKEW_CTRL0
       30'h025a0002,  // ADC02 TI_TIME_SKEW_CTRL5
       30'h021d001c,  // ADC02 CAL_FREEZE_MASK
       30'h02450091,  // ADC02_SIG_DET_CTRL
       30'h02460148,  // ADC02_SIG_DET_THRESHOLD_LEVEL0
       30'h0247012c,  // ADC02_SIG_DET_THRESHOLD_LEVEL0_CNT_ON
       30'h0248012c,  // ADC02_SIG_DET_THRESHOLD_LEVEL0_CNT_OFF
       30'h02060001,  // ADC02 FABRIC_DEBUG
       30'h03020101,  // ADC03 Data Width
       30'h03100003,  // ADC03 Decimation Config
       30'h0311000a,  // ADC03 Decimation Mode
       30'h03221015,  // ADC03 Mixer Mode
       30'h032a0002,  // ADC03 NCO Phase Mode
       30'h0327e38e,  // ADC03 NCO Frequency Word 0
       30'h03268e38,  // ADC03 NCO Frequency Word 1
       30'h0325fe43,  // ADC03 NCO Frequency Word 2
       30'h03290000,  // ADC03 NCO Phase Offset Word 0
       30'h03280000,  // ADC03 NCO Phase Offset Word 1
       30'h033a002c,  // ADC03 Switch Matrix Config
       30'h037101f9,  // ADC03 RX MC Config 0
       30'h03780002,  // ADC03 DSA Control
       30'h035181c7,  // ADC03 TI_DCB_CTRL0
       30'h0355d44a,  // ADC03 TI_TIME_SKEW_CTRL0
       30'h035a0002,  // ADC03 TI_TIME_SKEW_CTRL5
       30'h031d001c,  // ADC03 CAL_FREEZE_MASK
       30'h03450091,  // ADC03_SIG_DET_CTRL
       30'h03460148,  // ADC03_SIG_DET_THRESHOLD_LEVEL0
       30'h0347012c,  // ADC03_SIG_DET_THRESHOLD_LEVEL0_CNT_ON
       30'h0348012c,  // ADC03_SIG_DET_THRESHOLD_LEVEL0_CNT_OFF
       30'h03060001,  // ADC03 FABRIC_DEBUG
       30'h0f280600,  // SYSREF Distribution (ADC1)
       30'h17230000,  // Clock Network Control 0 (ADC2)
       30'h17240000,  // Clock Network Control 1 (ADC2)
       30'h17222000,  // Clock Distribution Control (ADC2)
       30'h17170016,  // PLL FB Div (ADC2)
       30'h170c00c2,  // PLL Output Divide (ADC2)
       30'h17100010,  // PLL Ref clock divide (ADC2)
       30'h17000080,  // PLL SDM CONFIG0 (ADC2)
       30'h17060111,  // PLL SDM seed (ADC2)
       30'h17070011,  // PLL SDM seed setup (ADC2)
       30'h170e0d37,  // PLL ChargePump setup (ADC2)
       30'h170f2080,  // PLL temprature sensor control (ADC2)
       30'h1712ffff,  // PLL ChargePump setup (ADC2)
       30'h17137f95,  // PLL loop filter setup (ADC2)
       30'h17140006,  // PLL loop filter setup (ADC2)
       30'h17155800,  // PLL VCO setup (ADC2)
       30'h17160008,  // PLL VCO setup (ADC2)
       30'h170a7a20,  // PLL Coarse Frequency setup (ADC2)
       30'h170b7008,  // PLL Coarse Frequency setup (ADC2)
       30'h1711002d,  // PLL Voltage Regulator setup (ADC2)
       30'h172c0025,  // CLK_DIV (ADC2)
       30'h17288880,  // SYSREF Distribution (ADC2)
       30'h172dfffc,  // HSCOM_PWR_MASK (ADC2)
       30'h17310062,  // CLOCK_DETECT_CTRL0 (ADC2)
       30'h17320032,  // CLOCK_DETECT_CTRL1 (ADC2)
       30'h17300040,  // FIFO_START (ADC2)
       30'h10020101,  // ADC20 Data Width
       30'h10100003,  // ADC20 Decimation Config
       30'h1011000a,  // ADC20 Decimation Mode
       30'h10221015,  // ADC20 Mixer Mode
       30'h102a0001,  // ADC20 NCO Phase Mode
       30'h1027e38e,  // ADC20 NCO Frequency Word 0
       30'h10268e38,  // ADC20 NCO Frequency Word 1
       30'h1025fe43,  // ADC20 NCO Frequency Word 2
       30'h10290000,  // ADC20 NCO Phase Offset Word 0
       30'h10280000,  // ADC20 NCO Phase Offset Word 1
       30'h103a0020,  // ADC20 Switch Matrix Config
       30'h107101f1,  // ADC20 RX MC Config 0
       30'h10780002,  // ADC20 DSA Control
       30'h105181c3,  // ADC20 TI_DCB_CTRL0
       30'h1055d44a,  // ADC20 TI_TIME_SKEW_CTRL0
       30'h105a0002,  // ADC20 TI_TIME_SKEW_CTRL5
       30'h101d001c,  // ADC20 CAL_FREEZE_MASK
       30'h10450091,  // ADC20_SIG_DET_CTRL
       30'h10460148,  // ADC20_SIG_DET_THRESHOLD_LEVEL0
       30'h1047012c,  // ADC20_SIG_DET_THRESHOLD_LEVEL0_CNT_ON
       30'h1048012c,  // ADC20_SIG_DET_THRESHOLD_LEVEL0_CNT_OFF
       30'h10060001,  // ADC20 FABRIC_DEBUG
       30'h11020101,  // ADC21 Data Width
       30'h11100003,  // ADC21 Decimation Config
       30'h1111000a,  // ADC21 Decimation Mode
       30'h11221015,  // ADC21 Mixer Mode
       30'h112a0002,  // ADC21 NCO Phase Mode
       30'h1127e38e,  // ADC21 NCO Frequency Word 0
       30'h11268e38,  // ADC21 NCO Frequency Word 1
       30'h1125fe43,  // ADC21 NCO Frequency Word 2
       30'h11290000,  // ADC21 NCO Phase Offset Word 0
       30'h11280000,  // ADC21 NCO Phase Offset Word 1
       30'h113a0024,  // ADC21 Switch Matrix Config
       30'h117101f9,  // ADC21 RX MC Config 0
       30'h11780002,  // ADC21 DSA Control
       30'h115181c7,  // ADC21 TI_DCB_CTRL0
       30'h1155d44a,  // ADC21 TI_TIME_SKEW_CTRL0
       30'h115a0002,  // ADC21 TI_TIME_SKEW_CTRL5
       30'h111d001c,  // ADC21 CAL_FREEZE_MASK
       30'h11450091,  // ADC21_SIG_DET_CTRL
       30'h11460148,  // ADC21_SIG_DET_THRESHOLD_LEVEL0
       30'h1147012c,  // ADC21_SIG_DET_THRESHOLD_LEVEL0_CNT_ON
       30'h1148012c,  // ADC21_SIG_DET_THRESHOLD_LEVEL0_CNT_OFF
       30'h11060001,  // ADC21 FABRIC_DEBUG
       30'h12020101,  // ADC22 Data Width
       30'h12100003,  // ADC22 Decimation Config
       30'h1211000a,  // ADC22 Decimation Mode
       30'h12221015,  // ADC22 Mixer Mode
       30'h122a0001,  // ADC22 NCO Phase Mode
       30'h1227e38e,  // ADC22 NCO Frequency Word 0
       30'h12268e38,  // ADC22 NCO Frequency Word 1
       30'h1225fe43,  // ADC22 NCO Frequency Word 2
       30'h12290000,  // ADC22 NCO Phase Offset Word 0
       30'h12280000,  // ADC22 NCO Phase Offset Word 1
       30'h123a0028,  // ADC22 Switch Matrix Config
       30'h127101f1,  // ADC22 RX MC Config 0
       30'h12780002,  // ADC22 DSA Control
       30'h125181c3,  // ADC22 TI_DCB_CTRL0
       30'h1255d44a,  // ADC22 TI_TIME_SKEW_CTRL0
       30'h125a0002,  // ADC22 TI_TIME_SKEW_CTRL5
       30'h121d001c,  // ADC22 CAL_FREEZE_MASK
       30'h12450091,  // ADC22_SIG_DET_CTRL
       30'h12460148,  // ADC22_SIG_DET_THRESHOLD_LEVEL0
       30'h1247012c,  // ADC22_SIG_DET_THRESHOLD_LEVEL0_CNT_ON
       30'h1248012c,  // ADC22_SIG_DET_THRESHOLD_LEVEL0_CNT_OFF
       30'h12060001,  // ADC22 FABRIC_DEBUG
       30'h13020101,  // ADC23 Data Width
       30'h13100003,  // ADC23 Decimation Config
       30'h1311000a,  // ADC23 Decimation Mode
       30'h13221015,  // ADC23 Mixer Mode
       30'h132a0002,  // ADC23 NCO Phase Mode
       30'h1327e38e,  // ADC23 NCO Frequency Word 0
       30'h13268e38,  // ADC23 NCO Frequency Word 1
       30'h1325fe43,  // ADC23 NCO Frequency Word 2
       30'h13290000,  // ADC23 NCO Phase Offset Word 0
       30'h13280000,  // ADC23 NCO Phase Offset Word 1
       30'h133a002c,  // ADC23 Switch Matrix Config
       30'h137101f9,  // ADC23 RX MC Config 0
       30'h13780002,  // ADC23 DSA Control
       30'h135181c7,  // ADC23 TI_DCB_CTRL0
       30'h1355d44a,  // ADC23 TI_TIME_SKEW_CTRL0
       30'h135a0002,  // ADC23 TI_TIME_SKEW_CTRL5
       30'h131d001c,  // ADC23 CAL_FREEZE_MASK
       30'h13450091,  // ADC23_SIG_DET_CTRL
       30'h13460148,  // ADC23_SIG_DET_THRESHOLD_LEVEL0
       30'h1347012c,  // ADC23_SIG_DET_THRESHOLD_LEVEL0_CNT_ON
       30'h1348012c,  // ADC23_SIG_DET_THRESHOLD_LEVEL0_CNT_OFF
       30'h13060001,  // ADC23 FABRIC_DEBUG
       30'h1f280700,  // SYSREF Distribution (ADC3)
       30'h2728ca80,  // SYSREF Distribution (DAC0)
       30'h2f282400,  // SYSREF Distribution (DAC1)
       30'h37280980,  // SYSREF Distribution (DAC2)
       30'h3f280100,  // SYSREF Distribution (DAC3)
       30'h00000000};

    //-------------------------------------------------------------------------
    // Output the tile number, address and data for the DRP writes
    // depending on the data_index input
    //-------------------------------------------------------------------------
    always @(posedge aux_clk)
    begin
      data <= data_array[data_index];
    end

    assign data_out = data[15:0];
    assign addr_out = data[26:16];
    assign tile_out = data[29:27];

endmodule
