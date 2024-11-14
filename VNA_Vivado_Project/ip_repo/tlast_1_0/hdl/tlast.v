`timescale 1 ns / 1 ps

module tlast #
(
    // Users to add parameters here

    // User parameters ends
    // Do not modify the parameters beyond this line
    

    // Parameters of Axi Slave Bus Interface S00_AXIS
    parameter integer C_S00_AXIS_TDATA_WIDTH	= 16,

    // Parameters of Axi Slave Bus Interface S01_AXIS
    parameter integer C_S01_AXIS_TDATA_WIDTH	= 16,

    // Parameters of Axi Master Bus Interface M00_AXIS
    parameter integer C_M00_AXIS_TDATA_WIDTH	= 32,
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

assign m00_axis_tvalid = s00_axis_tvalid;
assign m00_axis_tdata = {s01_axis_tdata, s00_axis_tdata};
assign m00_axis_tstrb = 4'b1111;

reg [17:0] count;

always @(posedge s00_axis_aclk) begin
    if (~s00_axis_aresetn) begin
        count <= 18'b0;
    end
    else begin
        if (s00_axis_tready && s00_axis_tvalid) begin
            if (count == 18'd65535) begin
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