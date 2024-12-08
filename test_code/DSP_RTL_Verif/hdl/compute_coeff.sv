 module compute_coeff #   
    (
        parameter integer C_S00_AXIS_TDATA_WIDTH  = 32,
        parameter integer C_M00_AXIS_TDATA_WIDTH  = 32
    )
    (
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

    //m00/s00 output
    logic m00_axis_tvalid_reg;
    logic m00_axis_tlast_reg;
    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata_reg;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb_reg;
    
    assign m00_axis_tvalid = m00_axis_tvalid_reg;
    assign m00_axis_tlast = m00_axis_tlast_reg;
    assign m00_axis_tdata = m00_axis_tdata_reg;
    assign m00_axis_tstrb = m00_axis_tstrb_reg;
    assign s00_axis_tready = m00_axis_tready;

    //m01/s01 output
    logic m01_axis_tvalid_reg;
    logic m01_axis_tlast_reg;
    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m01_axis_tdata_reg;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m01_axis_tstrb_reg;
    
    assign m01_axis_tvalid = m01_axis_tvalid_reg;
    assign m01_axis_tlast = m01_axis_tlast_reg;
    assign m01_axis_tdata = m01_axis_tdata_reg;
    assign m01_axis_tstrb = m01_axis_tstrb_reg;
    assign s01_axis_tready = m01_axis_tready;

    //m02/s02 output
    logic m02_axis_tvalid_reg;
    logic m02_axis_tlast_reg;
    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m02_axis_tdata_reg;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m02_axis_tstrb_reg;
    
    assign m02_axis_tvalid = m02_axis_tvalid_reg;
    assign m02_axis_tlast = m02_axis_tlast_reg;
    assign m02_axis_tdata = m02_axis_tdata_reg;
    assign m02_axis_tstrb = m02_axis_tstrb_reg;
    assign s02_axis_tready = m02_axis_tready;

    //m03/s03 output
    logic m03_axis_tvalid_reg;
    logic m03_axis_tlast_reg;
    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m03_axis_tdata_reg;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m03_axis_tstrb_reg;
    
    assign m03_axis_tvalid = m03_axis_tvalid_reg;
    assign m03_axis_tlast = m03_axis_tlast_reg;
    assign m03_axis_tdata = m03_axis_tdata_reg;
    assign m03_axis_tstrb = m03_axis_tstrb_reg;
    assign s03_axis_tready = m03_axis_tready;
    
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
        end else begin

        //only if data handoff happened do we take more data
        //KEY ASSUMPTION: ALL AXI IS PERFECTLY SYNCHED, so one valid, tlast, tstrb can be used.
        if (m00_axis_tready)begin
            // S11 axi signals (b1/a1)
            m00_axis_tvalid_reg <= s00_axis_tvalid & s01_axis_tvalid;
            m00_axis_tlast_reg <= s00_axis_tlast;
            m00_axis_tstrb_reg <= s00_axis_tstrb;

            // S12 caxi signals (b1/a2)
            m01_axis_tvalid_reg <= s01_axis_tvalid & s02_axis_tvalid;
            m01_axis_tlast_reg <= s00_axis_tlast;
            m01_axis_tstrb_reg <= s00_axis_tstrb;

            // S21 axi signals (b2/a1)
            m02_axis_tvalid_reg <= s03_axis_tvalid & s00_axis_tvalid;
            m02_axis_tlast_reg <= s00_axis_tlast;
            m02_axis_tstrb_reg <= s00_axis_tstrb;

            // S22 axi signals (b2/a2)
            m03_axis_tvalid_reg <= s02_axis_tvalid & s03_axis_tvalid;
            m03_axis_tlast_reg <= s00_axis_tlast;
            m03_axis_tstrb_reg <= s00_axis_tstrb;

            // Do phasor division 
            if(s00_axis_tdata[15:0] != 0) begin
                // S11 calculation (b1/a1)
                m00_axis_tdata_reg <= {s01_axis_tdata[31:16]-s00_axis_tdata[31:16], s01_axis_tdata[15:0]/s00_axis_tdata[15:0]};

                // S21 calculation (b2/a1)
                m02_axis_tdata_reg <= {s03_axis_tdata[31:16]-s00_axis_tdata[31:16], s03_axis_tdata[15:0]/s00_axis_tdata[15:0]};
            end else begin
                m00_axis_tdata_reg <= 32'b0;
                m02_axis_tdata_reg <= 32'b0;
            end

            if(s00_axis_tdata[15:0] != 0) begin
                // S12 calculation (b1/a1)
                m01_axis_tdata_reg <= {s01_axis_tdata[31:16]-s02_axis_tdata[31:16], s01_axis_tdata[15:0]/s02_axis_tdata[15:0]};

                // S22 calculation (b2/a1)
                m03_axis_tdata_reg <= {s03_axis_tdata[31:16]-s02_axis_tdata[31:16], s03_axis_tdata[15:0]/s02_axis_tdata[15:0]};
            end else begin
                m01_axis_tdata_reg <= 32'b0;
                m03_axis_tdata_reg <= 32'b0;
            end

        end
        end
    end

 endmodule