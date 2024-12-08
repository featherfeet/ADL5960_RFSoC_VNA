`timescale 1ns / 1ps
`default_nettype none // prevents system from inferring an undeclared logic (good practice)

module fir_15 #
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
 
    localparam NUM_COEFFS = 15;
    logic signed [16:0] coeffs [NUM_COEFFS-1 : 0];
    enum {PROCESSING, TLAST, WAITING, TLAST_WAIT} state;
    logic signed [C_S00_AXIS_TDATA_WIDTH-1+16 : 0] fir_regs [15];
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] fir_tstrb [15];
    logic [4:0] tlast_count;
    logic [3:0] txn_count;
    logic past_fifteen_flag;
    logic signed [C_S00_AXIS_TDATA_WIDTH-1+16 : 0] zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen;

    logic m00_axis_tvalid_reg, m00_axis_tlast_reg;
    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata_reg;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb_reg;
    
    assign m00_axis_tvalid = m00_axis_tvalid_reg;
    assign m00_axis_tlast = m00_axis_tlast_reg;
    assign m00_axis_tdata = m00_axis_tdata_reg;
    assign m00_axis_tstrb = m00_axis_tstrb_reg;

    assign s00_axis_tready = m00_axis_tready & (state == PROCESSING);
    assign m00_axis_tdata_reg = fir_regs[14] >> 16; //convert back to integer from 48 bit fixed pt
    assign m00_axis_tstrb_reg = fir_tstrb[14];

    // Doing this so I can see the values in GTKwave for debugging
    assign zero = fir_regs[0];
    assign one = fir_regs[1];
    assign two = fir_regs[2];
    assign three = fir_regs[3];
    assign four = fir_regs[4];
    assign five= fir_regs[5];
    assign six = fir_regs[6];
    assign seven = fir_regs[7];
    assign eight = fir_regs[8];
    assign nine = fir_regs[9];
    assign ten = fir_regs[10];
    assign eleven = fir_regs[11];
    assign twelve = fir_regs[12];
    assign thirteen = fir_regs[13];
    assign fourteen = fir_regs[14];


    //initializing values
    initial begin //updated coefficients
        coeffs[0] = 16'd666;
        coeffs[1] = 16'd1058;
        coeffs[2] = 16'd2155;
        coeffs[3] = 16'd3756;
        coeffs[4] = 16'd5548;
        coeffs[5] = 16'd7174;
        coeffs[6] = 16'd8304;
        coeffs[7] = 16'd8708;
        coeffs[8] = 16'd8304;
        coeffs[9] = 16'd7174;
        coeffs[10] = 16'd5548;
        coeffs[11] = 16'd3756;
        coeffs[12] = 16'd2155;
        coeffs[13] = 16'd1058;
        coeffs[14] = 16'd666;
        for(int i=0; i<NUM_COEFFS; i++)begin
            fir_regs[i] = 0;
            fir_tstrb[i] = 16'hF;
        end
        $display("DONE!");
    end

    always_ff @(posedge s00_axis_aclk)begin
        if (s00_axis_aresetn==0)begin
            m00_axis_tvalid_reg <= 0;
            m00_axis_tlast_reg <= 0;

            // internal vars
            state <= PROCESSING;
            txn_count <= 1'b0;
            tlast_count <= 0;
            past_fifteen_flag <= 1'b0;
            for(int i = 0; i < 15; i++) begin
                fir_regs[i] <= 0;
            end
        end else begin
            //only if data handoff happened do we take more data
            case(state)
                PROCESSING: begin
                    m00_axis_tlast_reg <= 1'b0;
                    if(s00_axis_tvalid) begin
                        for(int i = 0; i<15; i++) begin
                            if(i != 0) begin
                                fir_regs[i] <= fir_regs[i-1] + ($signed(s00_axis_tdata) * coeffs[i]);
                                fir_tstrb[i] <= fir_tstrb[i-1];
                            end else begin
                                fir_regs[i] <= ($signed(s00_axis_tdata) * coeffs[i]);
                                fir_tstrb[i] <= s00_axis_tstrb;
                            end
                        end

                        // Allow data to propagate through the system 
                        if(past_fifteen_flag) begin
                            m00_axis_tvalid_reg <= 1'b1;
                        end else if (txn_count == 14) begin
                            past_fifteen_flag <= 1'b1;
                            m00_axis_tvalid_reg <= 1'b1;
                            txn_count++;
                        end else begin
                            txn_count++;
                        end

                        if(s00_axis_tlast) begin
                            state <= TLAST;
                            tlast_count <= 1'b1;
                            txn_count <= 1'b0;
                            past_fifteen_flag <= 1'b0;
                        end 

                    end else begin
                        m00_axis_tvalid_reg <= 1'b0;
                    end
                    if(!m00_axis_tready) begin
                        state <= WAITING;
                    end
                end

                TLAST: begin
                    if (tlast_count < 15) begin
                        m00_axis_tvalid_reg <= 1'b1;
                        for(int i = 0; i < 15; i++) begin
                            if(i != 0) begin
                                fir_regs[i] <= fir_regs[i-1] + ($signed(s00_axis_tdata) * coeffs[i]);
                                fir_tstrb[i] <= fir_tstrb[i-1];
                            end else begin
                                fir_regs[i] <= 0;
                                fir_tstrb[i] <= 16'hF;
                            end
                        end
                        if(tlast_count == 14) begin
                            m00_axis_tlast_reg <= 1'b1;
                        end
                        if(!m00_axis_tready) begin
                            state <= TLAST_WAIT;
                        end
                        tlast_count++;
                    end else begin
                        m00_axis_tlast_reg <= 1'b0;
                        m00_axis_tvalid_reg <= 1'b0;
                        state <= PROCESSING;    
                    end
                end

                WAITING: begin
                    if(m00_axis_tready) begin
                        state <= PROCESSING;
                        m00_axis_tvalid_reg <= 1'b0;
                    end
                end
                TLAST_WAIT: begin
                    if(m00_axis_tready) begin
                        state <= TLAST;
                        m00_axis_tvalid_reg <= 1'b0;
                    end
                end
            endcase
        end
    end
 
endmodule

`default_nettype wire // prevents system from inferring an undeclared logic (good practice)