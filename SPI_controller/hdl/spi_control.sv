`timescale 1ns / 1ps
`default_nettype none // prevents system from inferring an undeclared logic (good practice)
module spi_control
       #(   parameter DATA_WIDTH = 8,
            parameter DATA_CLK_PERIOD = 100
        )
        ( input wire clk_in,
          input wire rst_in,
          input wire [DATA_WIDTH-1:0] data_in, //controller data to transmit through spi
          input wire trigger_in, //trigger data transmit
          output logic busy_out, //essentially ready
          output logic chip_data_out, //output spi data line
          output logic chip_clk_out, //output spi clk
          output logic chip_sel_out, //chip select
          input wire chip_data_in, //peripheral spi data in
          output logic data_valid_out, //peripheral data is valid to read
          output wire [DATA_WIDTH-1:0] data_out //output peripheral data 
        );

  logic[DATA_WIDTH-1:0] data_buffer; //buffer to store controller input data
  logic[DATA_WIDTH-1:0] chip_data_buffer; //buffer to store data from the chip/peripheral
  logic busy; //bool for if it is busy
  logic last; //if its on the last set of data, it doesnt get sent anywhere though so I am confused
  logic[15:0] half_clk_prd;
  logic[15:0] clk_prd;
  logic[15:0] prd_count; //15 bits is enough for 1MHz and i dont think we are going that low ! 
  logic [5:0] data_num; //which data piece we are on

  assign data_out = chip_data_buffer; //peripheral data out is tied to buffer

  /* 
  //not actually being used but theoretically here to buffer input for clock mixing
  logic chip_data_in_buffer;
  logic chip_data_in_buffered;
  always_ff @(posedge clk_in) begin
      chip_data_in_buffer <= chip_data_in;
      chip_data_in_buffered <= chip_data_in_buffer;
  end
  */

  always_ff @(posedge clk_in)begin
    if(rst_in) begin
      busy <=1'b0;
      busy_out <= 1'b0;
      chip_sel_out <= 1'b1;
      chip_clk_out <= 1'b0;
      half_clk_prd <= (DATA_CLK_PERIOD >> 1)-1;
      clk_prd <= ((DATA_CLK_PERIOD >> 1) << 1)-1; //make sure its even :)
      prd_count <= 16'b0;
      chip_data_out <= 0;
      data_num <= DATA_WIDTH -1;
      last=1'b0;
      data_valid_out <=1'b0;
      chip_data_buffer <= 0;

    end else begin 
      if(trigger_in && !busy) begin //can only trigger if its not also busy 
        busy<=1'b1;
        data_buffer<=data_in;
        busy_out <= 1'b1;
        chip_sel_out <= 1'b0;
        chip_clk_out <=1'b0;
        prd_count <= 16'b0;
        chip_data_out <= data_in[data_num];
        data_num <= data_num -1;
        last<=1'b0;
        data_valid_out <=1'b0;
      end else if((prd_count == clk_prd) && busy) begin //once full cycle has passed
        prd_count <=  16'b0;
        chip_clk_out <=  ~chip_clk_out;
        if(data_num ==0) begin //last piece of data
          last <= 1'b1;
          data_num <= DATA_WIDTH -1;
          chip_data_out <= data_buffer[data_num];
          chip_data_buffer[data_num+1] <= chip_data_in;
        end else if(last) begin //after everything is sent
          busy_out<=1'b0;
          chip_sel_out<=1'b1;
          busy<=1'b0;
          last <= 1'b0;
          data_valid_out <=1'b1;
          chip_data_buffer[0] <= chip_data_in;
        end else begin  //while still transmitting
          data_num <= data_num-1;
          chip_data_out <= data_buffer[data_num];
          chip_data_buffer[data_num+1] <= chip_data_in;
        end
      end else begin //not a full cycle
        chip_clk_out <= (prd_count == half_clk_prd) ? ~chip_clk_out: chip_clk_out; //switch out clock if at halfway period
        prd_count <= prd_count + 16'b1; //count up clock 
        data_valid_out<=1'b0; //only valid for one clock cycle i guess for test bench to work
      end
    end
    
  end
endmodule
`default_nettype wire // prevents system from inferring an undeclared logic (good practice)