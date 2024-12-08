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

    //Re-add the quadrant info and take from z. Then truncate x/k so amplitude is 16 bit integer.
    assign m00_axis_tdata_reg = {final_angle, final_radius[15:0]};

    //Split into i and q (x and y in cordic). Convert to abs for use. Pad by 16 for 32 bit fixed point (decimal after 16 bits)
    assign abs_x = s00_axis_tdata[15] ? ~s00_axis_tdata[C_S00_AXIS_TDATA_WIDTH/2-1:0]+1 : s00_axis_tdata[C_S00_AXIS_TDATA_WIDTH/2-1:0];
    assign abs_y = s00_axis_tdata[31] ? ~s00_axis_tdata[C_S00_AXIS_TDATA_WIDTH-1:C_S00_AXIS_TDATA_WIDTH/2]+1 : s00_axis_tdata[C_S00_AXIS_TDATA_WIDTH-1:C_S00_AXIS_TDATA_WIDTH/2];
    assign x_dat = {2'b00, abs_x, 16'b0};
    assign y_dat = {2'b00, abs_y, 16'b0};
    assign x_true = $signed(s00_axis_tdata[C_S00_AXIS_TDATA_WIDTH/2-1:0]);
    assign y_true = $signed(s00_axis_tdata[C_S00_AXIS_TDATA_WIDTH-1:C_S00_AXIS_TDATA_WIDTH/2]);

    logic signed [C_S00_AXIS_TDATA_WIDTH/2-1 : 0] zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen;
    logic signed [C_S00_AXIS_TDATA_WIDTH+1 : 0] zero_y, one_y, two_y, three_y, four_y, five_y, six_y, seven_y, eight_y, nine_y, ten_y, eleven_y, twelve_y, thirteen_y, fourteen_y;
    logic signed [C_S00_AXIS_TDATA_WIDTH+1 : 0] x_zero, x_one, x_two, x_three, x_four, x_five, x_six, x_seven, x_eight, x_nine, x_ten, x_eleven, x_twelve, x_thirteen, x_fourteen;
    logic [1:0] q_fin;
    assign q_fin = quadrant[NUM_ITERS-1];
    // Doing this so I can see the values in GTKwave for debugging
    assign zero = z_regs[0];
    assign one = z_regs[1];
    assign two = z_regs[2];
    assign three = z_regs[3];
    assign four = z_regs[4];
    assign five= z_regs[5];
    assign six = z_regs[6];
    assign seven = z_regs[7];
    assign eight = z_regs[8];
    assign nine = z_regs[9];
    assign ten = z_regs[10];
    assign eleven = z_regs[11];
    assign twelve = z_regs[12];
    assign thirteen = z_regs[13];
    assign fourteen = z_regs[14];

    assign x_zero = x_regs[0];
    assign x_one = x_regs[1];
    assign x_two = x_regs[2];
    assign x_three = x_regs[3];
    assign x_four = x_regs[4];
    assign x_five= x_regs[5];
    assign x_six = x_regs[6];
    assign x_seven = x_regs[7];
    assign x_eight = x_regs[8];
    assign x_nine = x_regs[9];
    assign x_ten = x_regs[10];
    assign x_eleven = x_regs[11];
    assign x_twelve = x_regs[12];
    assign x_thirteen = x_regs[13];
    assign x_fourteen = x_regs[14];

    assign zero_y = y_regs[0];
    assign one_y = y_regs[1];
    assign two_y = y_regs[2];
    assign three_y = y_regs[3];
    assign four_y = y_regs[4];
    assign five_y= y_regs[5];
    assign six_y = y_regs[6];
    assign seven_y = y_regs[7];
    assign eight_y = y_regs[8];
    assign nine_y = y_regs[9];
    assign ten_y = y_regs[10];
    assign eleven_y = y_regs[11];
    assign twelve_y = y_regs[12];
    assign thirteen_y = y_regs[13];
    assign fourteen_y = y_regs[14];


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