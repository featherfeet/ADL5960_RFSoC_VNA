`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2024 04:13:51 PM
// Design Name: 
// Module Name: spi_control_w
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



module spi_control_w(

     input wire clk_in,
     input wire rst_in,
     input wire [19:0] data_in, //controller data to transmit through spi
     input wire trigger_in, //trigger data transmit
     output wire busy_out, //essentially ready
     output wire chip_data_out, //output spi data line
     output wire chip_clk_out, //output spi clk
     output wire chip_sel_out, //chip select
     input wire chip_data_in, //peripheral spi data in
     output wire data_valid_out, //peripheral data is valid to read
     output wire [19:0] data_out //output peripheral data 
    );
    spi_control  #(.DATA_WIDTH(20), .DATA_CLK_PERIOD(10000))
    mspi
    (   .clk_in(clk_in),
        .rst_in(~rst_in), //IMPOTANT!!!
        .data_in(data_in),
        .trigger_in(trigger_in),
        .busy_out(busy_out),
        .chip_data_out(chip_data_out),
        .chip_clk_out(chip_clk_out),
        .chip_sel_out(chip_sel_out),
        .chip_data_in(chip_data_in),
        .data_valid_out(data_valid_out),
        .data_out(data_out)
       );
endmodule

