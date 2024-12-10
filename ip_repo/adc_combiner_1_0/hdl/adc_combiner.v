
`timescale 1 ns / 1 ps

	module adc_combiner #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXIS
		parameter integer C_S00_AXIS_TDATA_WIDTH	= 16,

		// Parameters of Axi Slave Bus Interface S01_AXIS
		parameter integer C_S01_AXIS_TDATA_WIDTH	= 16,

		// Parameters of Axi Slave Bus Interface S02_AXIS
		parameter integer C_S02_AXIS_TDATA_WIDTH	= 16,

		// Parameters of Axi Slave Bus Interface S03_AXIS
		parameter integer C_S03_AXIS_TDATA_WIDTH	= 16,

		// Parameters of Axi Slave Bus Interface S04_AXIS
		parameter integer C_S04_AXIS_TDATA_WIDTH	= 16,

		// Parameters of Axi Slave Bus Interface S05_AXIS
		parameter integer C_S05_AXIS_TDATA_WIDTH	= 16,

		// Parameters of Axi Slave Bus Interface S06_AXIS
		parameter integer C_S06_AXIS_TDATA_WIDTH	= 16,

		// Parameters of Axi Slave Bus Interface S07_AXIS
		parameter integer C_S07_AXIS_TDATA_WIDTH	= 16,

		// Parameters of Axi Master Bus Interface M00_AXIS
		parameter integer C_M00_AXIS_TDATA_WIDTH	= 128,
		parameter integer C_M00_AXIS_START_COUNT	= 32
	)
	(
		// Users to add ports here

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

		// Ports of Axi Slave Bus Interface S04_AXIS
		input wire  s04_axis_aclk,
		input wire  s04_axis_aresetn,
		output wire  s04_axis_tready,
		input wire [C_S04_AXIS_TDATA_WIDTH-1 : 0] s04_axis_tdata,
		input wire [(C_S04_AXIS_TDATA_WIDTH/8)-1 : 0] s04_axis_tstrb,
		input wire  s04_axis_tlast,
		input wire  s04_axis_tvalid,

		// Ports of Axi Slave Bus Interface S05_AXIS
		input wire  s05_axis_aclk,
		input wire  s05_axis_aresetn,
		output wire  s05_axis_tready,
		input wire [C_S05_AXIS_TDATA_WIDTH-1 : 0] s05_axis_tdata,
		input wire [(C_S05_AXIS_TDATA_WIDTH/8)-1 : 0] s05_axis_tstrb,
		input wire  s05_axis_tlast,
		input wire  s05_axis_tvalid,

		// Ports of Axi Slave Bus Interface S06_AXIS
		input wire  s06_axis_aclk,
		input wire  s06_axis_aresetn,
		output wire  s06_axis_tready,
		input wire [C_S06_AXIS_TDATA_WIDTH-1 : 0] s06_axis_tdata,
		input wire [(C_S06_AXIS_TDATA_WIDTH/8)-1 : 0] s06_axis_tstrb,
		input wire  s06_axis_tlast,
		input wire  s06_axis_tvalid,

		// Ports of Axi Slave Bus Interface S07_AXIS
		input wire  s07_axis_aclk,
		input wire  s07_axis_aresetn,
		output wire  s07_axis_tready,
		input wire [C_S07_AXIS_TDATA_WIDTH-1 : 0] s07_axis_tdata,
		input wire [(C_S07_AXIS_TDATA_WIDTH/8)-1 : 0] s07_axis_tstrb,
		input wire  s07_axis_tlast,
		input wire  s07_axis_tvalid,

		// Ports of Axi Master Bus Interface M00_AXIS
		input wire  m00_axis_aclk,
		input wire  m00_axis_aresetn,
		output wire  m00_axis_tvalid,
		output wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
		output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1 : 0] m00_axis_tstrb,
		output reg  m00_axis_tlast,
		input wire  m00_axis_tready
	);

    assign s00_axis_tready = m00_axis_tready;
    assign s01_axis_tready = m00_axis_tready;
    assign s02_axis_tready = m00_axis_tready;
    assign s03_axis_tready = m00_axis_tready;
    assign s04_axis_tready = m00_axis_tready;
    assign s05_axis_tready = m00_axis_tready;
    assign s06_axis_tready = m00_axis_tready;
    assign s07_axis_tready = m00_axis_tready;
    
    assign m00_axis_tvalid = s00_axis_tvalid;
    assign m00_axis_tdata = {s01_axis_tdata, s00_axis_tdata, s03_axis_tdata, s02_axis_tdata, s05_axis_tdata, s04_axis_tdata, s07_axis_tdata, s06_axis_tdata};
    assign m00_axis_tstrb = 16'b1111_1111_1111_1111;
    
    reg [17:0] count;
    
    always @(posedge s00_axis_aclk) begin
        if (~s00_axis_aresetn) begin
            count <= 18'b0;
        end
        else begin
            if (s00_axis_tready && s00_axis_tvalid) begin
                if (count == 18'd5000) begin
                    m00_axis_tlast <= 1'b1;
                    count <= 1'b0;
                end
                else begin
                    m00_axis_tlast <= 1'b0;
                    count <= count + 1'b1;
                end
            end
        end
    end

	endmodule
