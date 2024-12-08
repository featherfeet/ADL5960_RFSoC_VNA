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
    enum {ACCUMULATE, AVERAGE, DIVIDE, CALCULATE, SEND, WAITING} state;
    logic [15:0] count;
    logic [31:0] phase_s11_accumulator;
    logic [31:0] phase_s12_accumulator;
    logic [31:0] phase_s21_accumulator;
    logic [31:0] phase_s22_accumulator;
    logic [31:0] mag_a1_accumulator;
    logic [31:0] mag_b1_accumulator;
    logic [31:0] mag_a2_accumulator;
    logic [31:0] mag_b2_accumulator;
    logic [16:0] mag_a1_accumulator_av;
    logic [16:0] mag_b1_accumulator_av;
    logic [16:0] mag_a2_accumulator_av;
    logic [16:0] mag_b2_accumulator_av;
    logic [16:0] gamma_mag_s11;
    logic [16:0] gamma_mag_s12;
    logic [16:0] gamma_mag_s21;
    logic [16:0] gamma_mag_s22;

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
            phase_s11_accumulator <= 0;
            phase_s12_accumulator <= 0;
            phase_s21_accumulator <= 0;
            phase_s22_accumulator <= 0;
            mag_a1_accumulator <= 0;
            mag_b1_accumulator <= 0;
            mag_a2_accumulator <= 0;
            mag_b2_accumulator <= 0;

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
                        mag_a1_accumulator <= mag_a1_accumulator + s00_axis_tdata[15:0];
                        mag_b1_accumulator <= mag_b1_accumulator + s01_axis_tdata[15:0];
                        mag_a2_accumulator <= mag_a2_accumulator + s02_axis_tdata[15:0];
                        mag_b2_accumulator <= mag_b2_accumulator + s03_axis_tdata[15:0];

                        //Accumulate phase difference (may need to check this)
                        phase_s11_accumulator <= phase_s11_accumulator + s01_axis_tdata[31:16]-s00_axis_tdata[31:16];
                        phase_s21_accumulator <= phase_s21_accumulator + s03_axis_tdata[31:16]-s00_axis_tdata[31:16];
                        phase_s12_accumulator <= phase_s12_accumulator + s01_axis_tdata[31:16]-s02_axis_tdata[31:16];
                        phase_s22_accumulator <= phase_s22_accumulator + s03_axis_tdata[31:16]-s02_axis_tdata[31:16];
                    end

                    //disable all valids
                    m00_axis_tvalid_reg <= 0;
                    m01_axis_tvalid_reg <= 0;
                    m02_axis_tvalid_reg <= 0;
                    m03_axis_tvalid_reg <= 0;
                end
                AVERAGE: begin
                    //This state is basically just here to give the huge divides a fighting chance. Can stall this out if it's a problem
                    phase_s11_accumulator <= phase_s11_accumulator / num_samples;
                    phase_s12_accumulator <= phase_s12_accumulator / num_samples;
                    phase_s21_accumulator <= phase_s21_accumulator / num_samples;
                    phase_s22_accumulator <= phase_s22_accumulator / num_samples;
                    mag_a1_accumulator_av <= mag_a1_accumulator / num_samples;
                    mag_b1_accumulator_av <= mag_b1_accumulator / num_samples;
                    mag_a2_accumulator_av <= mag_a2_accumulator / num_samples;
                    mag_b2_accumulator_av <= mag_b2_accumulator / num_samples;
                    state <= CALCULATE;
                end
                CALCULATE: begin
                    // Once again lets give the divides a chance
                    if(mag_a1_accumulator != 0) begin
                        gamma_mag_s11 <= mag_b1_accumulator_av/mag_a1_accumulator_av;
                        gamma_mag_s12 <= mag_b2_accumulator_av/mag_a1_accumulator_av;
                    end else begin
                        gamma_mag_s11 <= 0;
                        gamma_mag_s12 <= 0;
                    end

                    if(mag_a2_accumulator != 0) begin 
                        gamma_mag_s21 <= mag_b1_accumulator_av/mag_a2_accumulator_av;
                        gamma_mag_s22 <= mag_b2_accumulator_av/mag_a2_accumulator_av;
                    end else begin
                        gamma_mag_s21 <= 0;
                        gamma_mag_s22 <= 0;
                    end

                    state <= SEND;
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
                    m00_axis_tdata_reg <= {phase_s11_accumulator[15:0], gamma_mag_s11};

                    // S21 calculation (b2/a1)
                    m02_axis_tdata_reg <= {phase_s21_accumulator[15:0], gamma_mag_s21};

                    // S12 calculation (b1/a2)
                    m01_axis_tdata_reg <= {phase_s12_accumulator[15:0], gamma_mag_s12};;

                    // S22 calculation (b2/a2)
                    m03_axis_tdata_reg <= {phase_s22_accumulator[15:0], gamma_mag_s22};

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
                        phase_s11_accumulator <= 0;
                        phase_s12_accumulator <= 0;
                        phase_s21_accumulator <= 0;
                        phase_s22_accumulator <= 0;
                        mag_a1_accumulator <= 0;
                        mag_b1_accumulator <= 0;
                        mag_a2_accumulator <= 0;
                        mag_b2_accumulator <= 0;
                    end
                end
            endcase
        end
    end

 endmodule