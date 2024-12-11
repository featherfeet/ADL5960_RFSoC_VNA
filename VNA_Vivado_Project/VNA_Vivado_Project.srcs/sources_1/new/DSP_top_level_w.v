`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 01:55:49 PM
// Design Name: 
// Module Name: DSP_top_level_w
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

       
      
module DSP_top_level_w #
    (
        parameter integer C_S00_AXIS_TDATA_WIDTH  = 32,
        parameter integer C_M00_AXIS_TDATA_WIDTH  = 32
    )
    (
    // Ports of Axi Slave Bus Interface S00_AXIS
    input wire [15:0] num_samples,
    input wire  s00_axis_aclk, s00_axis_aresetn,
    input wire  s00_axis_tlast, s00_axis_tvalid,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s00_axis_tstrb,
    input wire  s01_axis_aclk, s01_axis_aresetn,
    input wire  s01_axis_tlast, s01_axis_tvalid,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s01_axis_tstrb,
    input wire  s02_axis_aclk, s02_axis_aresetn,
    input wire  s02_axis_tlast, s02_axis_tvalid,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s02_axis_tstrb,
    input wire  s03_axis_aclk, s03_axis_aresetn,
    input wire  s03_axis_tlast, s03_axis_tvalid,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s03_axis_tstrb,
    output wire  s00_axis_tready,
    output wire  s01_axis_tready,
    output wire  s02_axis_tready,
    output wire  s03_axis_tready,
    
    input wire  s04_axis_aclk, s04_axis_aresetn,
    input wire  s04_axis_tlast, s04_axis_tvalid,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s04_axis_tstrb,
    input wire  s05_axis_aclk, s05_axis_aresetn,
    input wire  s05_axis_tlast, s05_axis_tvalid,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s05_axis_tstrb,
    input wire  s06_axis_aclk, s06_axis_aresetn,
    input wire  s06_axis_tlast, s06_axis_tvalid,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s06_axis_tstrb,
    input wire  s07_axis_aclk, s07_axis_aresetn,
    input wire  s07_axis_tlast, s07_axis_tvalid,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s07_axis_tstrb,
    output wire  s04_axis_tready,
    output wire  s05_axis_tready,
    output wire  s06_axis_tready,
    output wire  s07_axis_tready,

    // Ports of Axi Master Bus Interface M00_AXIS
    input wire  m00_axis_aclk, m00_axis_aresetn,
    input wire  m00_axis_tready,
    output wire  m00_axis_tvalid, m00_axis_tlast,
    output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb,
    input wire  m01_axis_aclk, m01_axis_aresetn,
    input wire  m01_axis_tready,
    output wire  m01_axis_tvalid, m01_axis_tlast,
    output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m01_axis_tstrb,
    input wire  m02_axis_aclk, m02_axis_aresetn,
    input wire  m02_axis_tready,
    output wire  m02_axis_tvalid, m02_axis_tlast,
    output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m02_axis_tstrb,
    input wire  m03_axis_aclk, m03_axis_aresetn,
    input wire  m03_axis_tready,
    output wire  m03_axis_tvalid, m03_axis_tlast,
    output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m03_axis_tstrb,

    //ports of ADC data in
    
    input wire [(C_M00_AXIS_TDATA_WIDTH/2)-1 : 0] s00_axis_tdata, //port 1 reverse Q
    input wire [(C_M00_AXIS_TDATA_WIDTH/2)-1 : 0] s01_axis_tdata,  //port 1 reverse I
    input wire [(C_M00_AXIS_TDATA_WIDTH/2)-1 : 0] s02_axis_tdata, //port 1 forward Q
    input wire [(C_M00_AXIS_TDATA_WIDTH/2)-1 : 0] s03_axis_tdata, //port 1 forward I
    
    input wire [(C_M00_AXIS_TDATA_WIDTH/2)-1 : 0] s04_axis_tdata, //port 2 reverse Q
    input wire [(C_M00_AXIS_TDATA_WIDTH/2)-1 : 0] s05_axis_tdata,  //port 2 reverse I
    input wire [(C_M00_AXIS_TDATA_WIDTH/2)-1 : 0] s06_axis_tdata, //port 2 forward Q
    input wire [(C_M00_AXIS_TDATA_WIDTH/2)-1 : 0] s07_axis_tdata, //port 2 forward I
    
    
    output wire [C_M00_AXIS_TDATA_WIDTH+15 : 0] m00_axis_tdata, //S11_out
    output wire [C_M00_AXIS_TDATA_WIDTH+15 : 0] m01_axis_tdata, //S12_out, 
    output wire [C_M00_AXIS_TDATA_WIDTH+15 : 0] m02_axis_tdata, //S21_out,
    output wire [C_M00_AXIS_TDATA_WIDTH+15 : 0] m03_axis_tdata //S22_out
    
    );
    DSP_top_level #(.C_S00_AXIS_TDATA_WIDTH(32), .C_M00_AXIS_TDATA_WIDTH(32))
    top(
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
    
        // Ports of Axi Master Bus Interface M00_AXIS
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
    
        //ports of ADC data in
    
        .s00_axis_tdata(s00_axis_tdata), //port 1 reverse Q
        .s01_axis_tdata(s01_axis_tdata),  //port 1 reverse I
        .s02_axis_tdata(s02_axis_tdata), //port 1 forward Q
        .s03_axis_tdata(s03_axis_tdata), //port 1 forward I
        .s04_axis_tdata(s04_axis_tdata), //port 2 reverse Q
        .s05_axis_tdata(s05_axis_tdata),  //port 2 reverse I
        .s06_axis_tdata(s06_axis_tdata), //port 2 forward Q
        .s07_axis_tdata(s07_axis_tdata), //port 2 forward I
    
        .m00_axis_tdata(m00_axis_tdata), //S11_out
        .m01_axis_tdata(m01_axis_tdata), //S12_out, 
        .m02_axis_tdata(m02_axis_tdata), //S21_out,
        .m03_axis_tdata(m03_axis_tdata) //S22_out
    );

       
endmodule

