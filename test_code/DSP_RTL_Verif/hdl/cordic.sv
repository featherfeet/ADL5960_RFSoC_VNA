`timescale 1ns / 1ps
`default_nettype none // prevents system from inferring an undeclared logic (good practice)

module cordic #
    (
        parameter integer C_S00_AXIS_TDATA_WIDTH  = 32,
        parameter integer C_M00_AXIS_TDATA_WIDTH  = 32
    )
    (
    // Ports of Axi Slave Bus Interface S00_AXIS
    input wire  s00_axis_aclk, s00_axis_aresetn,
    input wire  s00_axis_tlast, s00_axis_tvalid,
    input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s00_axis_tstrb,
    output logic  s00_axis_tready,
    
    // Ports of Axi Master Bus Interface M00_AXIS
    input wire  m00_axis_aclk, m00_axis_aresetn,
    input wire  m00_axis_tready,
    output logic  m00_axis_tvalid, m00_axis_tlast,
    output logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
    output logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb
    );

    // Doing this so I can see the values in GTKwave for debugging
    wire [15:0] cordic_imag_part_in;
    wire [15:0] cordic_real_part_in;
    assign cordic_real_part_in = s00_axis_tdata[31:16];
    assign cordic_imag_part_in = s00_axis_tdata[15:0];
    wire [15:0] cordic_angle_out;
    wire [15:0] cordic_radius_out;
    assign cordic_angle_out = m00_axis_tdata_reg[31:16];
    assign cordic_radius_out = m00_axis_tdata_reg[15:0];
 
    localparam NUM_ITERS = 15;
    localparam K = 34'b00_0000_0000_0000_0001_1010_0101_1001_0010; //1.64676 in 34 bit fixed point (16 bits of decimal)
    logic signed [16:0] atan_table [NUM_ITERS-1 : 0];

    logic signed [C_S00_AXIS_TDATA_WIDTH+1 : 0] x_regs [NUM_ITERS];
    logic signed [C_S00_AXIS_TDATA_WIDTH+1 : 0] y_regs [NUM_ITERS];
    logic [C_S00_AXIS_TDATA_WIDTH/2-1 : 0] z_regs [NUM_ITERS];
    logic signed [C_S00_AXIS_TDATA_WIDTH/2-1 : 0] abs_x;
    logic signed [C_S00_AXIS_TDATA_WIDTH/2-1 : 0] abs_y;
    logic signed [C_S00_AXIS_TDATA_WIDTH+1 : 0] x_dat; //34 bits (2 bits for overflow, 16 for value, 16 for decimal)
    logic signed [C_S00_AXIS_TDATA_WIDTH+1 : 0] y_dat;
    logic signed [C_S00_AXIS_TDATA_WIDTH/2-1 : 0] x_true; //For ease of deciding quadrant
    logic signed [C_S00_AXIS_TDATA_WIDTH/2-1 : 0] y_true;
    logic zero_flag [NUM_ITERS]; //take care of (0,0) case
    logic [1:0] quadrant [NUM_ITERS]; //This keeps track of which quadrant things are in since they are moved to q1 for cordic
    logic [C_S00_AXIS_TDATA_WIDTH/2-1 : 0] final_angle; //final angle after z has been ajusted to right quadrant
    logic [C_S00_AXIS_TDATA_WIDTH+1 : 0] final_radius; //Final radius after adjusting for k, but containing extra precision bits. Max value must be smaller than 2**16.

    //Sets of regs to hold each iteration associated axi metadata
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] tstrb [NUM_ITERS];
    logic tvalid [NUM_ITERS];
    logic tlast [NUM_ITERS];

    //Output regs
    logic m00_axis_tvalid_reg, m00_axis_tlast_reg;
    logic signed [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata_reg;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb_reg;

    //Assign outputs to output regs
    assign m00_axis_tvalid = m00_axis_tvalid_reg;
    assign m00_axis_tlast = m00_axis_tlast_reg;
    assign m00_axis_tdata = m00_axis_tdata_reg;
    assign m00_axis_tstrb = m00_axis_tstrb_reg;
    assign s00_axis_tready = m00_axis_tready;

    //Assign output regs to right values
    assign m00_axis_tstrb_reg = tstrb[NUM_ITERS-1];
    assign m00_axis_tvalid_reg = tvalid[NUM_ITERS-1];
    assign m00_axis_tlast_reg = tlast[NUM_ITERS-1];

    logic tlast_0;
    logic tlast_1;
    logic tlast_2;
    logic tlast_3;
    logic tlast_4;
    logic tlast_5;
    logic tlast_6;
    logic tlast_7;
    logic tlast_8;
    logic tlast_9;
    logic tlast_10;
    logic tlast_11;
    logic tlast_12;
    logic tlast_13;
    logic tlast_14;

    assign tlast_0 = tlast[0];
    assign tlast_1 = tlast[1];
    assign tlast_2 = tlast[2];
    assign tlast_3 = tlast[3];
    assign tlast_4 = tlast[4];
    assign tlast_5 = tlast[5];
    assign tlast_6 = tlast[6];
    assign tlast_7 = tlast[7];
    assign tlast_8 = tlast[8];
    assign tlast_9 = tlast[9];
    assign tlast_10 = tlast[10];
    assign tlast_11 = tlast[11];
    assign tlast_12 = tlast[12];
    assign tlast_13 = tlast[13];
    assign tlast_14 = tlast[14];

    
    //Re-add the quadrant info and take from z. Then truncate x/k so amplitude is 16 bit integer.
    assign m00_axis_tdata_reg = {final_angle, final_radius[15:0]};

    //Split into i and q (x and y in cordic). Convert to abs for use. Pad by 16 on tail and 2 on top for 34 bit fixed point (decimal after 16 bits), additional 2 bits for rollover during calculation
    assign abs_x = s00_axis_tdata[15] ? ~s00_axis_tdata[C_S00_AXIS_TDATA_WIDTH/2-1:0]+1 : s00_axis_tdata[C_S00_AXIS_TDATA_WIDTH/2-1:0];
    assign abs_y = s00_axis_tdata[31] ? ~s00_axis_tdata[C_S00_AXIS_TDATA_WIDTH-1:C_S00_AXIS_TDATA_WIDTH/2]+1 : s00_axis_tdata[C_S00_AXIS_TDATA_WIDTH-1:C_S00_AXIS_TDATA_WIDTH/2];
    assign x_dat = {2'b00, abs_x, 16'b0};
    assign y_dat = {2'b00, abs_y, 16'b0};
    assign x_true = $signed(s00_axis_tdata[C_S00_AXIS_TDATA_WIDTH/2-1:0]);
    assign y_true = $signed(s00_axis_tdata[C_S00_AXIS_TDATA_WIDTH-1:C_S00_AXIS_TDATA_WIDTH/2]);

    //initializing values
    initial begin // atan(2^-i) angle values
        atan_table[0] = 16'd8192;
        atan_table[1] = 16'd4836;
        atan_table[2] = 16'd2555;
        atan_table[3] = 16'd1297;
        atan_table[4] = 16'd651;
        atan_table[5] = 16'd326;
        atan_table[6] = 16'd163;
        atan_table[7] = 16'd81;
        atan_table[8] = 16'd41;
        atan_table[9] = 16'd20;
        atan_table[10] = 16'd10;
        atan_table[11] = 16'd5;
        atan_table[12] = 16'd3;
        atan_table[13] = 16'd1;
        atan_table[14] = 16'd1;

        final_angle = 0;
        final_radius = 0;
        for(int i=0; i<NUM_ITERS; i++)begin
            x_regs[i] = 0;
            y_regs[i] = 0;
            z_regs[i] = 0;
            tstrb[i] = 16'hF;
            tvalid[i] = 0;
            tlast[i] = 0;
            quadrant[i] = 0;
            zero_flag[i] = 0;
        end
    end

    always_ff @(posedge s00_axis_aclk)begin
        if (s00_axis_aresetn==0)begin
            for(int i = 0; i < NUM_ITERS; i++) begin
                x_regs[i] <= 0;
                y_regs[i] <= 0;
                z_regs[i] <= 0;
                tstrb[i] <= 16'hF;
                tvalid[i] <= 0;
                tlast[i] <= 0;
                quadrant[i] <= 0;
                zero_flag[i] <= 0;
            end
        end else begin
            if(m00_axis_tready) begin
                for (int i = 0; i < NUM_ITERS; i++) begin
                    if(i == 0) begin
                        if(y_dat > 0) begin
                            x_regs[i] <= x_dat + (y_dat >>> i);
                            y_regs[i] <= y_dat - (x_dat >>> i);
                            z_regs[i] <= atan_table[i];
                        end else begin
                            x_regs[i] <= x_dat - (y_dat >>> i);
                            y_regs[i] <= y_dat + (x_dat >>> i);
                            z_regs[i] <= -1 * atan_table[i];
                        end
                        tvalid[i] <= s00_axis_tvalid;
                        tlast[i] <= s00_axis_tlast;
                        tstrb[i] <= s00_axis_tstrb;

                        //select quadrant based on sign of original data 
                        // q1 -> 00, q2 -> 01, q3 -> 11, q4 -> 10
                        quadrant[i][0] <= x_true >= 0 ? 0 : 1;
                        quadrant[i][1] <= y_true >= 0 ? 0 : 1;
                        zero_flag[i] <= s00_axis_tdata == 0;

                    end else begin
                        if(y_regs[i-1] > 0) begin
                            x_regs[i] <= x_regs[i-1] + (y_regs[i-1] >>> i);
                            y_regs[i] <= y_regs[i-1] - (x_regs[i-1] >>> i);
                            z_regs[i] <= z_regs[i-1] + atan_table[i];
                        end else begin
                            x_regs[i] <= x_regs[i-1] - (y_regs[i-1] >>> i);
                            y_regs[i] <= y_regs[i-1] + (x_regs[i-1] >>> i);
                            z_regs[i] <= z_regs[i-1] - atan_table[i];
                        end
                        tvalid[i] <= tvalid[i-1];
                        tlast[i] <= tlast[i-1];
                        tstrb[i] <= tstrb[i-1];
                        quadrant[i] <= quadrant[i-1];
                        zero_flag[i] <= zero_flag[i-1];
                    end
                end
            end
        end
    end

    //Do some math to reajust the final angle back
    always_comb begin
        if(!zero_flag[NUM_ITERS-1]) begin
            case(quadrant[NUM_ITERS-1])
                2'b00: final_angle = z_regs[NUM_ITERS-1];
                2'b01: final_angle = 16'd32768 - z_regs[NUM_ITERS-1]; //180 - angle
                2'b11: final_angle = 16'd32768 + z_regs[NUM_ITERS-1]; //180 + angle
                2'b10: final_angle = 16'd65535 - z_regs[NUM_ITERS-1]; //360 - angle
            endcase
        end else begin
            final_angle = 16'b0;
        end

        final_radius = x_regs[NUM_ITERS-1]/K; //Cut off the top two rollover bits and the 16 bits for decimal
    end
 
endmodule


`default_nettype wire // prevents system from inferring an undeclared logic (good practice)