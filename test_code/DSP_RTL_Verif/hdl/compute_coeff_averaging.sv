 module compute_coeff_averaging #   
    (
        parameter integer C_S00_AXIS_TDATA_WIDTH  = 32,
        parameter integer C_M00_AXIS_TDATA_WIDTH  = 32
    )
    (
    // Input for number of signals to take (this should be held constant to some value) CANNOT BE 0!
    input wire [15:0] num_samples,

    // Ports of Axi Slave Bus Interface S00_AXIS. (a1)
    input wire  s00_axis_aclk, s00_axis_aresetn,
    input wire  s00_axis_tlast, s00_axis_tvalid,
    input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s00_axis_tstrb,
    output logic  s00_axis_tready,

    // Ports of Axi Slave Bus Interface S01_AXIS (b1)
    input wire  s01_axis_aclk, s01_axis_aresetn,
    input wire  s01_axis_tlast, s01_axis_tvalid,
    input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s01_axis_tdata,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s01_axis_tstrb,
    output logic  s01_axis_tready,

    // Ports of Axi Slave Bus Interface S02_AXIS (a2)
    input wire  s02_axis_aclk, s02_axis_aresetn,
    input wire  s02_axis_tlast, s02_axis_tvalid,
    input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s02_axis_tdata,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s02_axis_tstrb,
    output logic  s02_axis_tready,

    // Ports of Axi Slave Bus Interface S03_AXIS (b2)
    input wire  s03_axis_aclk, s03_axis_aresetn,
    input wire  s03_axis_tlast, s03_axis_tvalid,
    input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s03_axis_tdata,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s03_axis_tstrb,
    output logic s03_axis_tready,

    // Ports of Axi Master Bus Interface M00_AXIS (S11)
    input wire  m00_axis_aclk, m00_axis_aresetn,
    input wire  m00_axis_tready,
    output logic  m00_axis_tvalid, m00_axis_tlast,
    output logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
    output logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb,

    // Ports of Axi Master Bus Interface M01_AXIS (S12)
    input wire  m01_axis_aclk, m01_axis_aresetn,
    input wire  m01_axis_tready,
    output logic  m01_axis_tvalid, m01_axis_tlast,
    output logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m01_axis_tdata,
    output logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m01_axis_tstrb,

    // Ports of Axi Master Bus Interface M02_AXIS (S21)
    input wire  m02_axis_aclk, m02_axis_aresetn,
    input wire  m02_axis_tready,
    output logic  m02_axis_tvalid, m02_axis_tlast,
    output logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m02_axis_tdata,
    output logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m02_axis_tstrb,
    
    // Ports of Axi Master Bus Interface M03_AXIS (S22)
    input wire  m03_axis_aclk, m03_axis_aresetn,
    input wire  m03_axis_tready,
    output logic  m03_axis_tvalid, m03_axis_tlast,
    output logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m03_axis_tdata,
    output logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m03_axis_tstrb
    );

    //Averaging count state machine
    enum {ACCUMULATE, AVERAGE, DIVIDE_ONE, DIVIDE_TWO, CALCULATE, SEND, WAITING} state;
    logic [15:0] count;
    logic [31:0] phase_accumulator [3:0]; //[s11, s21, s12, s22]
    logic [31:0] mag_accumulator [3:0]; //[a1, b1, a2, b2]
    logic [15:0] gamma_mag_s11;
    logic [15:0] gamma_mag_s12;
    logic [15:0] gamma_mag_s21;
    logic [15:0] gamma_mag_s22;

    logic [31:0] ph_check;
    assign ph_check = phase_accumulator[1];

    //Divisor modules
    logic [31:0] dividend [7:0]; 
    logic [31:0] divisor [7:0];
    logic valid_in [7:0];
    logic [31:0] data_out [7:0];
    logic valid_out [7:0];
    logic error_out [7:0];
    logic busy_out [7:0];

    genvar i;
    generate
        for(i = 0; i < 8; i++ ) begin
            divider2 div(.clk_in(s00_axis_aclk),
                            .rst_in(~s00_axis_aresetn),
                            .dividend_in(dividend[i]),
                            .divisor_in(divisor[i]),
                            .data_valid_in(valid_in[i]),
                            .quotient_out(data_out[i]),
                            .remainder_out(),
                            .data_valid_out(valid_out[i]),
                            .error_out(error_out[i]),
                            .busy_out(busy_out[i]));
        end
    endgenerate

    //m00/s00 output
    logic m00_axis_tvalid_reg;
    logic m00_axis_tlast_reg;
    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata_reg;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb_reg;
    
    assign m00_axis_tvalid = m00_axis_tvalid_reg;
    assign m00_axis_tlast = m00_axis_tlast_reg;
    assign m00_axis_tdata = m00_axis_tdata_reg;
    assign m00_axis_tstrb = m00_axis_tstrb_reg;
    assign s00_axis_tready = (state == ACCUMULATE);

    //m01/s01 output
    logic m01_axis_tvalid_reg;
    logic m01_axis_tlast_reg;
    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m01_axis_tdata_reg;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m01_axis_tstrb_reg;
    
    assign m01_axis_tvalid = m01_axis_tvalid_reg;
    assign m01_axis_tlast = m01_axis_tlast_reg;
    assign m01_axis_tdata = m01_axis_tdata_reg;
    assign m01_axis_tstrb = m01_axis_tstrb_reg;
    assign s01_axis_tready = (state == ACCUMULATE);

    //m02/s02 output
    logic m02_axis_tvalid_reg;
    logic m02_axis_tlast_reg;
    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m02_axis_tdata_reg;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m02_axis_tstrb_reg;
    
    assign m02_axis_tvalid = m02_axis_tvalid_reg;
    assign m02_axis_tlast = m02_axis_tlast_reg;
    assign m02_axis_tdata = m02_axis_tdata_reg;
    assign m02_axis_tstrb = m02_axis_tstrb_reg;
    assign s02_axis_tready = (state == ACCUMULATE);

    //m03/s03 output
    logic m03_axis_tvalid_reg;
    logic m03_axis_tlast_reg;
    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m03_axis_tdata_reg;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m03_axis_tstrb_reg;
    
    assign m03_axis_tvalid = m03_axis_tvalid_reg;
    assign m03_axis_tlast = m03_axis_tlast_reg;
    assign m03_axis_tdata = m03_axis_tdata_reg;
    assign m03_axis_tstrb = m03_axis_tstrb_reg;
    assign s03_axis_tready = (state == ACCUMULATE);
    
    always_ff @(posedge s00_axis_aclk)begin
        if (s00_axis_aresetn==0)begin
            m00_axis_tvalid_reg <= 0;
            m00_axis_tlast_reg <= 0;
            m00_axis_tdata_reg <= 0;
            m00_axis_tstrb_reg <= 0;

            m01_axis_tvalid_reg <= 0;
            m01_axis_tlast_reg <= 0;
            m01_axis_tdata_reg <= 0;
            m01_axis_tstrb_reg <= 0;

            m02_axis_tvalid_reg <= 0;
            m02_axis_tlast_reg <= 0;
            m02_axis_tdata_reg <= 0;
            m02_axis_tstrb_reg <= 0;

            m03_axis_tvalid_reg <= 0;
            m03_axis_tlast_reg <= 0;
            m03_axis_tdata_reg <= 0;
            m03_axis_tstrb_reg <= 0;

            count <= 0;
            state <= ACCUMULATE;
            for(int i = 0; i < 4; i++) begin
               phase_accumulator[i] <= 0; 
               mag_accumulator[i] <= 0;
            end
            for(int i = 0; i < 8; i++) begin
                dividend[i] <= 32'b0; 
                divisor[i] <= 32'b0;
                valid_in[i] <= 1'b0;
            end
            gamma_mag_s11 <= 16'b0;
            gamma_mag_s12 <= 16'b0;
            gamma_mag_s21 <= 16'b0;
            gamma_mag_s22 <= 16'b0;

        end else begin
            //only if data handoff happened do we take more data
            //KEY ASSUMPTION: ALL AXI IS PERFECTLY SYNCHED, so one valid, tlast, tstrb can be used for all four input/output axi ports.
            case(state)
                ACCUMULATE: begin
                    if(s00_axis_tvalid) begin
                        if(count == num_samples -1) begin
                            state <= AVERAGE;
                            count <= 0;
                        end else begin
                            count <= count + 1;
                        end

                        // Accumulate mags
                        mag_accumulator[0] <= mag_accumulator[0] + s00_axis_tdata[15:0];
                        mag_accumulator[1] <= mag_accumulator[1] + s01_axis_tdata[15:0];
                        mag_accumulator[2] <= mag_accumulator[2] + s02_axis_tdata[15:0];
                        mag_accumulator[3] <= mag_accumulator[3] + s03_axis_tdata[15:0];

                        //Accumulate phase difference (may need to check this)
                        phase_accumulator[0] <= phase_accumulator[0] + {16'b0, (s01_axis_tdata[31:16]-s00_axis_tdata[31:16])}; //s11
                        phase_accumulator[1] <= phase_accumulator[1] + {16'b0, (s01_axis_tdata[31:16]-s02_axis_tdata[31:16])}; //s12
                        phase_accumulator[2] <= phase_accumulator[2] + {16'b0, (s03_axis_tdata[31:16]-s00_axis_tdata[31:16])}; //s21
                        phase_accumulator[3] <= phase_accumulator[3] + {16'b0, (s03_axis_tdata[31:16]-s02_axis_tdata[31:16])}; //s22
                    end

                    //disable all valids
                    m00_axis_tvalid_reg <= 0;
                    m01_axis_tvalid_reg <= 0;
                    m02_axis_tvalid_reg <= 0;
                    m03_axis_tvalid_reg <= 0;
                end
                AVERAGE: begin
                    //Use this state to allow divides time to finish
                    // phase_s11_accumulator <= phase_s11_accumulator / num_samples;
                    // phase_s12_accumulator <= phase_s12_accumulator / num_samples;
                    // phase_s21_accumulator <= phase_s21_accumulator / num_samples;
                    // phase_s22_accumulator <= phase_s22_accumulator / num_samples;
                    // mag_a1_accumulator <= mag_a1_accumulator / num_samples;
                    // mag_b1_accumulator <= mag_b1_accumulator / num_samples;
                    // mag_a2_accumulator <= mag_a2_accumulator / num_samples;
                    // mag_b2_accumulator <= mag_b2_accumulator / num_samples;

                    //Feed the divide modules
                    if(busy_out[0] == 0) begin //assume synched since there is constant time
                        for (int i = 0; i < 8; i++) begin
                            if(i > 3) begin
                                dividend[i] <= mag_accumulator[i-4];
                            end else begin
                                dividend[i] <= phase_accumulator[i];
                            end
                            divisor[i] <= num_samples;
                            valid_in[i] <= 1'b1; 
                        end
                    end
                    state <= DIVIDE_ONE;
                end
                DIVIDE_ONE: begin
                    for (int i = 0; i < 8; i++) begin
                        valid_in[i] <= 1'b0;
                    end
                    if(valid_out[0] == 1'b1) begin
                        for(int i = 0; i < 4; i++) begin
                            phase_accumulator[i] <= data_out[i];
                        end
                        for(int i = 4; i < 8; i++) begin
                            mag_accumulator[i-4] <= data_out[i];
                        end
                        state <= DIVIDE_TWO;
                    end
                end
                DIVIDE_TWO: begin
                    if(busy_out[0] == 0) begin
                        dividend[0] <= mag_accumulator[1]; //b1
                        divisor[0] <= mag_accumulator[0]; //a1

                        dividend[1] <= mag_accumulator[1]; //b1
                        divisor[1] <= mag_accumulator[2]; //a2

                        dividend[2] <= mag_accumulator[3]; //b2
                        divisor[2] <= mag_accumulator[0]; //a1

                        dividend[3] <= mag_accumulator[3]; //b2
                        divisor[3] <= mag_accumulator[2]; //a2

                        for(int i = 0; i < 4; i++) begin
                            valid_in[i] <= 1'b1; 
                        end
                        state <= CALCULATE;
                    end
                end
                CALCULATE: begin
                    for (int i = 0; i < 4; i++) begin
                        valid_in[i] <= 1'b0;
                    end
                    // Once again lets give the divides a chance
                    if(valid_out[0] == 1'b1) begin
                        gamma_mag_s11 <= error_out[0] ? 32'b0: data_out[0];
                        gamma_mag_s12 <= error_out[1] ? 32'b0: data_out[1];
                        gamma_mag_s21 <= error_out[2] ? 32'b0: data_out[2];
                        gamma_mag_s22 <= error_out[3] ? 32'b0: data_out[3];

                        state <= SEND;
                    end
                end
                SEND: begin
                    // S11 axi signals (b1/a1)
                    m00_axis_tvalid_reg <= 1'b1;
                    m00_axis_tlast_reg <= 1'b1;
                    m00_axis_tstrb_reg <= 4'hF; //Let's assume this is always high

                    // S12 axi signals (b1/a2)
                    m01_axis_tvalid_reg <= 1'b1;
                    m01_axis_tlast_reg <= 1'b1;
                    m01_axis_tstrb_reg <= 4'hF;

                    // S21 axi signals (b2/a1)
                    m02_axis_tvalid_reg <= 1'b1;
                    m02_axis_tlast_reg <= 1'b1;
                    m02_axis_tstrb_reg <= 4'hF;

                    // S22 axi signals (b2/a2)
                    m03_axis_tvalid_reg <= 1'b1;
                    m03_axis_tlast_reg <= 1'b1;
                    m03_axis_tstrb_reg <= 4'hF;

                    // S11 calculation (b1/a1)
                    m00_axis_tdata_reg <= {phase_accumulator[0][15:0], gamma_mag_s11};
                    
                    // S12 calculation (b1/a2)
                    m01_axis_tdata_reg <= {phase_accumulator[1][15:0], gamma_mag_s12};;

                    // S21 calculation (b2/a1)
                    m02_axis_tdata_reg <= {phase_accumulator[2][15:0], gamma_mag_s21};

                    // S22 calculation (b2/a2)
                    m03_axis_tdata_reg <= {phase_accumulator[3][15:0], gamma_mag_s22};

                    state <= WAITING;
                end 
                WAITING: begin
                    if(m00_axis_tready) begin //assume these are all in synch...
                        state <= ACCUMULATE;
                        m00_axis_tvalid_reg <= 0;
                        m01_axis_tvalid_reg <= 0;
                        m02_axis_tvalid_reg <= 0;
                        m03_axis_tvalid_reg <= 0;

                        //reset to restart
                        count <= 0;
                        for(int i = 0; i < 4; i++) begin
                            phase_accumulator[i] <= 0;
                            mag_accumulator[i] <= 0;
                        end
                    end
                end
            endcase
        end
    end

 endmodule

 module divider2 #(parameter WIDTH = 32) (input wire clk_in,
                input wire rst_in,
                input wire[WIDTH-1:0] dividend_in,
                input wire[WIDTH-1:0] divisor_in,
                input wire data_valid_in,
                output logic[WIDTH-1:0] quotient_out,
                output logic[WIDTH-1:0] remainder_out,
                output logic data_valid_out,
                output logic error_out,
                output logic busy_out);
  logic [WIDTH-1:0] quotient, dividend;
  logic [WIDTH-1:0] divisor;
  logic [5:0] count;
  logic [31:0] p;
  enum {RESTING, DIVIDING} state;
  always_ff @(posedge clk_in)begin
    if (rst_in)begin
      quotient <= 0;
      dividend <= 0;
      divisor <= 0;
      remainder_out <= 0;
      busy_out <= 1'b0;
      error_out <= 1'b0;
      state <= RESTING;
      data_valid_out <= 1'b0;
      count <= 0;
    end else begin
      case (state)
        RESTING: begin
          if (data_valid_in)begin
            state <= DIVIDING;
            quotient <= 0;
            dividend <= dividend_in;
            divisor <= divisor_in;
            busy_out <= 1'b1;
            error_out <= 1'b0;
            count <= 31;//load all up
            p <= 0;
          end
          data_valid_out <= 1'b0;
        end
        DIVIDING: begin
          if (count==0)begin
            state <= RESTING;
            if ({p[30:0],dividend[31]}>=divisor[31:0])begin
              remainder_out <= {p[30:0],dividend[31]} - divisor[31:0];
              quotient_out <= {dividend[30:0],1'b1};
            end else begin
              remainder_out <= {p[30:0],dividend[31]};
              quotient_out <= {dividend[30:0],1'b0};
            end
            busy_out <= 1'b0; //tell outside world i'm done
            error_out <= 1'b0;
            data_valid_out <= 1'b1; //good stuff!
          end else begin
            if ({p[30:0],dividend[31]}>=divisor[31:0])begin
              p <= {p[30:0],dividend[31]} - divisor[31:0];
              dividend <= {dividend[30:0],1'b1};
            end else begin
              p <= {p[30:0],dividend[31]};
              dividend <= {dividend[30:0],1'b0};
            end
            count <= count-1;
          end
        end
      endcase
    end
  end
endmodule