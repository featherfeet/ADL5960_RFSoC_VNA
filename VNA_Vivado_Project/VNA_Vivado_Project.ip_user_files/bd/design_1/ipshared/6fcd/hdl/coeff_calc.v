
`timescale 1 ns / 1 ps

	module coeff_calc #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXIS
		parameter integer C_S00_AXIS_TDATA_WIDTH	= 32,

		// Parameters of Axi Slave Bus Interface S01_AXIS
		parameter integer C_S01_AXIS_TDATA_WIDTH	= 32,

		// Parameters of Axi Slave Bus Interface S02_AXIS
		parameter integer C_S02_AXIS_TDATA_WIDTH	= 32,

		// Parameters of Axi Slave Bus Interface S03_AXIS
		parameter integer C_S03_AXIS_TDATA_WIDTH	= 32,

		// Parameters of Axi Master Bus Interface M00_AXIS
		parameter integer C_M00_AXIS_TDATA_WIDTH	= 128,
		parameter integer C_M00_AXIS_START_COUNT	= 32
	)
	(
		// Users to add ports here
        input wire [15:0] num_samples,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXIS
		input wire  s00_axis_aclk,
		input wire  s00_axis_aresetn,
		output wire  s00_axis_tready,
		input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
		input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1 : 0] s00_axis_tstrb,
		input wire  s00_axis_tlast,
		input wire  s00_axis_tvalid,

		// Ports of Axi Slave Bus Interface S01_AXIS
		input wire  s01_axis_aclk,
		input wire  s01_axis_aresetn,
		output wire  s01_axis_tready,
		input wire [C_S01_AXIS_TDATA_WIDTH-1 : 0] s01_axis_tdata,
		input wire [(C_S01_AXIS_TDATA_WIDTH/8)-1 : 0] s01_axis_tstrb,
		input wire  s01_axis_tlast,
		input wire  s01_axis_tvalid,

		// Ports of Axi Slave Bus Interface S02_AXIS
		input wire  s02_axis_aclk,
		input wire  s02_axis_aresetn,
		output wire  s02_axis_tready,
		input wire [C_S02_AXIS_TDATA_WIDTH-1 : 0] s02_axis_tdata,
		input wire [(C_S02_AXIS_TDATA_WIDTH/8)-1 : 0] s02_axis_tstrb,
		input wire  s02_axis_tlast,
		input wire  s02_axis_tvalid,

		// Ports of Axi Slave Bus Interface S03_AXIS
		input wire  s03_axis_aclk,
		input wire  s03_axis_aresetn,
		output wire  s03_axis_tready,
		input wire [C_S03_AXIS_TDATA_WIDTH-1 : 0] s03_axis_tdata,
		input wire [(C_S03_AXIS_TDATA_WIDTH/8)-1 : 0] s03_axis_tstrb,
		input wire  s03_axis_tlast,
		input wire  s03_axis_tvalid,

		// Ports of Axi Master Bus Interface M00_AXIS
		input wire  m00_axis_aclk,
		input wire  m00_axis_aresetn,
		output wire  m00_axis_tvalid,
		output wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
		output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1 : 0] m00_axis_tstrb,
		output wire  m00_axis_tlast,
		input wire  m00_axis_tready
	);
	// Add user logic here
	wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] m00_out, m01_out, m02_out, m03_out;
	assign m00_axis_tdata = {m00_out, m01_out, m02_out, m03_out};
	
    compute_coeff_averaging (  
        .num_samples(num_samples),
        
        .s00_axis_aclk(s00_axis_aclk),
        .s00_axis_aresetn(s00_axis_aresetn),
        .s00_axis_tready(s00_axis_tready),
        .s00_axis_tdata(s00_axis_tdata),
        .s00_axis_tstrb(s00_axis_tstrb),
        .s00_axis_tlast(s00_axis_tlast),
        .s00_axis_tvalid(s00_axis_tvalid),
        
        .s01_axis_aclk(s00_axis_aclk),
        .s01_axis_aresetn(s00_axis_aresetn),
        .s01_axis_tready(s01_axis_tready),
        .s01_axis_tdata(s01_axis_tdata),
        .s01_axis_tstrb(s00_axis_tstrb),
        .s01_axis_tlast(s00_axis_tlast),
        .s01_axis_tvalid(s00_axis_tvalid),
        
        .s02_axis_aclk(s00_axis_aclk),
        .s02_axis_aresetn(s00_axis_aresetn),
        .s02_axis_tready(s02_axis_tready),
        .s02_axis_tdata(s02_axis_tdata),
        .s02_axis_tstrb(s00_axis_tstrb),
        .s02_axis_tlast(s00_axis_tlast),
        .s02_axis_tvalid(s00_axis_tvalid),
        
        .s03_axis_aclk(s00_axis_aclk),
        .s03_axis_aresetn(s00_axis_aresetn),
        .s03_axis_tready(s03_axis_tready),
        .s03_axis_tdata(s03_axis_tdata),
        .s03_axis_tstrb(s00_axis_tstrb),
        .s03_axis_tlast(s00_axis_tlast),
        .s03_axis_tvalid(s00_axis_tvalid),               

        .m00_axis_aclk(m00_axis_aclk),
        .m00_axis_aresetn(m00_axis_aresetn),
        .m00_axis_tready(m00_axis_tready),
        .m00_axis_tdata(m00_out),
        .m00_axis_tstrb(m00_axis_tstrb),
        .m00_axis_tlast(m00_axis_tlast),
        .m00_axis_tvalid(m00_axis_tvalid),
        
        .m01_axis_aclk(m00_axis_aclk),
        .m01_axis_aresetn(m00_axis_aresetn),
        .m01_axis_tready(m00_axis_tready),
        .m01_axis_tdata(m01_out),
        .m01_axis_tstrb(),
        .m01_axis_tlast(),
        .m01_axis_tvalid(),
        
        .m02_axis_aclk(m00_axis_aclk),
        .m02_axis_aresetn(m00_axis_aresetn),
        .m02_axis_tready(m00_axis_tready),
        .m02_axis_tdata(m02_out),
        .m02_axis_tstrb(),
        .m02_axis_tlast(),
        .m02_axis_tvalid(),
        
        .m03_axis_aclk(m00_axis_aclk),
        .m03_axis_aresetn(m00_axis_aresetn),
        .m03_axis_tready(m00_axis_tready),
        .m03_axis_tdata(m03_out),
        .m03_axis_tstrb(),
        .m03_axis_tlast(),
        .m03_axis_tvalid()
    );
	// User logic ends

	endmodule
