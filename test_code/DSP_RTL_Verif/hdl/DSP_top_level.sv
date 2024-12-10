`timescale 1ns / 1ps
`default_nettype none // prevents system from inferring an undeclared logic (good practice)

module DSP_top_level #
    (
        parameter integer C_S00_AXIS_TDATA_WIDTH  = 32,
        parameter integer C_M00_AXIS_TDATA_WIDTH  = 32
    )
    (
    // Ports of Axi Slave Bus Interface S00_AXIS
    input wire  s00_axis_aclk, s00_axis_aresetn,
    input wire  s00_axis_tlast, s00_axis_tvalid,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s00_axis_tstrb,
    input wire  s01_axis_aclk, s01_axis_aresetn,
    input wire  s01_axis_tlast, s01_axis_tvalid,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s01_axis_tstrb,
    input wire  s02_axis_aclk, s02_axis_aresetn,
    input wire  s02_axis_tlast, s02_axis_tvalid,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s02_axis_tstrb,
    input wire  s03_axis_aclk, s03_axis_aresetn,
    input wire  s03_axis_tlast, s03_axis_tvalid,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s03_axis_tstrb,
    output logic  s00_axis_tready,
    output logic  s01_axis_tready,
    output logic  s02_axis_tready,
    output logic  s03_axis_tready,
    
    // Ports of Axi Master Bus Interface M00_AXIS
    input wire  m00_axis_aclk, m00_axis_aresetn,
    input wire  m00_axis_tready,
    output logic  m00_axis_tvalid, m00_axis_tlast,
    output logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb,
    input wire  m01_axis_aclk, m01_axis_aresetn,
    input wire  m01_axis_tready,
    output logic  m01_axis_tvalid, m01_axis_tlast,
    output logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m01_axis_tstrb,
    input wire  m02_axis_aclk, m02_axis_aresetn,
    input wire  m02_axis_tready,
    output logic  m02_axis_tvalid, m02_axis_tlast,
    output logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m02_axis_tstrb,
    input wire  m03_axis_aclk, m03_axis_aresetn,
    input wire  m03_axis_tready,
    output logic  m03_axis_tvalid, m03_axis_tlast,
    output logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m03_axis_tstrb,

    //ports of ADC data in

    input wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata, //port 1 reverse
    input wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] s01_axis_tdata,  //port 1forward
    input wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] s02_axis_tdata, //port 2 reverse
    input wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] s03_axis_tdata, //port 2 forward

    output logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata, //S11_out
    output logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m01_axis_tdata, //S12_out, 
    output logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m02_axis_tdata, //S21_out,
    output logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] m03_axis_tdata //S22_out
    );

    //chain 1

    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] port1_reverse_fir_data;
    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] port1_reverse_cordic_data;

    logic m00_axis_tready_fir1, m00_axis_tvalid_fir1, m00_axis_tlast_fir1;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb_fir1;

    logic s00_axis_tlast_fir1, s00_axis_tvalid_fir1, s00_axis_tready_fir1;
    logic [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s00_axis_tstrb_fir1;

    logic m00_axis_tready_cordic1, m00_axis_tvalid_cordic1, m00_axis_tlast_cordic1;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb_cordic1;

    logic s00_axis_tlast_cordic1, s00_axis_tvalid_cordic1, s00_axis_tready_cordic1;
    logic [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s00_axis_tstrb_cordic1;

    assign m00_axis_tready_fir1 = s00_axis_tready_fir1;
    assign s00_axis_tvalid_fir1 = m00_axis_tvalid_fir1;
    assign s00_axis_tlast_fir1 = m00_axis_tlast_fir1;
    assign s00_axis_tstrb_fir1 = m00_axis_tstrb_fir1;

    assign s00_axis_tstrb_cordic1 = m00_axis_tstrb_cordic1;
    assign m00_axis_tready_cordic1 = s00_axis_tready_cordic1;
    assign s00_axis_tvalid_cordic1 = m00_axis_tvalid_cordic1;
    assign s00_axis_tlast_cordic1 = m00_axis_tlast_cordic1;



    fir_15  #(.C_S00_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH ), .C_M00_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH))
    fir_1(  .s00_axis_aclk(s00_axis_aclk),
            .s00_axis_aresetn(s00_axis_aresetn),
            .s00_axis_tready(s00_axis_tready_fir1),
            .s00_axis_tdata(s00_axis_tdata),
            .s00_axis_tstrb(s00_axis_tstrb),
            .s00_axis_tlast(s00_axis_tlast),
            .s00_axis_tvalid(s00_axis_tvalid),
 
            .m00_axis_aclk(s00_axis_aclk),
            .m00_axis_aresetn(s00_axis_aresetn),
            .m00_axis_tready(m00_axis_tready),
            .m00_axis_tdata(port1_reverse_fir_data),
            .m00_axis_tstrb(m00_axis_tstrb_fir1),
            .m00_axis_tlast(m00_axis_tlast_fir1),
            .m00_axis_tvalid(m00_axis_tvalid_fir1)
        );

    cordic  #(.C_S00_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH ), .C_M00_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH))
    cordic_1(  .s00_axis_aclk(s00_axis_aclk),
            .s00_axis_aresetn(s00_axis_aresetn),
            .s00_axis_tready(s00_axis_tready_cordic1),
            .s00_axis_tdata(port1_reverse_fir_data),
            .s00_axis_tstrb(s00_axis_tstrb_fir1),
            .s00_axis_tlast(s00_axis_tlast_fir1),
            .s00_axis_tvalid(s00_axis_tvalid_fir1),
 
            .m00_axis_aclk(s00_axis_aclk),
            .m00_axis_aresetn(s00_axis_aresetn),
            .m00_axis_tready(m00_axis_tready_fir1),
            .m00_axis_tdata(port1_reverse_cordic_data),
            .m00_axis_tstrb(m00_axis_tstrb_cordic1),
            .m00_axis_tlast(m00_axis_tlast_cordic1),
            .m00_axis_tvalid(m00_axis_tvalid_cordic1)
        );

    //chain 2

    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] port1_forward_fir_data;
    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] port1_forward_cordic_data;

    logic m00_axis_tready_fir2, m00_axis_tvalid_fir2, m00_axis_tlast_fir2;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb_fir2;

    logic s00_axis_tlast_fir2, s00_axis_tvalid_fir2, s00_axis_tready_fir2;
    logic [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s00_axis_tstrb_fir2;

    logic m00_axis_tready_cordic2, m00_axis_tvalid_cordic2, m00_axis_tlast_cordic2;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb_cordic2;

    logic s00_axis_tlast_cordic2, s00_axis_tvalid_cordic2, s00_axis_tready_cordic2;
    logic [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s00_axis_tstrb_cordic2;

    assign m00_axis_tready_fir2 = s00_axis_tready_fir2;
    assign s00_axis_tvalid_fir2 = m00_axis_tvalid_fir2;
    assign s00_axis_tlast_fir2 = m00_axis_tlast_fir2;
    assign s00_axis_tstrb_fir2 = m00_axis_tstrb_fir2;

    assign s00_axis_tstrb_cordic2 = m00_axis_tstrb_cordic2;
    assign m00_axis_tready_cordic2 = s00_axis_tready_cordic2;
    assign s00_axis_tvalid_cordic2 = m00_axis_tvalid_cordic2;
    assign s00_axis_tlast_cordic2 = m00_axis_tlast_cordic2;



    fir_15  #(.C_S00_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH ), .C_M00_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH))
    fir_2(  .s00_axis_aclk(s00_axis_aclk),
            .s00_axis_aresetn(s00_axis_aresetn),
            .s00_axis_tready(s00_axis_tready_fir2),
            .s00_axis_tdata(s01_axis_tdata),
            .s00_axis_tstrb(s01_axis_tstrb),
            .s00_axis_tlast(s01_axis_tlast),
            .s00_axis_tvalid(s01_axis_tvalid),
 
            .m00_axis_aclk(s00_axis_aclk),
            .m00_axis_aresetn(s00_axis_aresetn),
            .m00_axis_tready(m01_axis_tready),
            .m00_axis_tdata(port1_forward_fir_data),
            .m00_axis_tstrb(m00_axis_tstrb_fir2),
            .m00_axis_tlast(m00_axis_tlast_fir2),
            .m00_axis_tvalid(m00_axis_tvalid_fir2)
        );
       

    cordic  #(.C_S00_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH ), .C_M00_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH))
    cordic_2(   .s00_axis_aclk(s00_axis_aclk),
            .s00_axis_aresetn(s00_axis_aresetn),
            .s00_axis_tready(s00_axis_tready_cordic2),
            .s00_axis_tdata(port1_forward_fir_data),
            .s00_axis_tstrb(s00_axis_tstrb_fir2),
            .s00_axis_tlast(s00_axis_tlast_fir2),
            .s00_axis_tvalid(s00_axis_tvalid_fir2),
 
            .m00_axis_aclk(s00_axis_aclk),
            .m00_axis_aresetn(s00_axis_aresetn),
            .m00_axis_tready(m00_axis_tready_fir2),
            .m00_axis_tdata(port1_forward_cordic_data),
            .m00_axis_tstrb(m00_axis_tstrb_cordic2),
            .m00_axis_tlast(m00_axis_tlast_cordic2),
            .m00_axis_tvalid(m00_axis_tvalid_cordic2)
        );

    //chain 3

    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] port2_reverse_fir_data;
    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] port2_reverse_cordic_data;

    logic m00_axis_tready_fir3, m00_axis_tvalid_fir3, m00_axis_tlast_fir3;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb_fir3;

    logic s00_axis_tlast_fir3, s00_axis_tvalid_fir3, s00_axis_tready_fir3;
    logic [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s00_axis_tstrb_fir3;

    logic m00_axis_tready_cordic3, m00_axis_tvalid_cordic3, m00_axis_tlast_cordic3;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb_cordic3;

    logic s00_axis_tlast_cordic3, s00_axis_tvalid_cordic3, s00_axis_tready_cordic3;
    logic [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s00_axis_tstrb_cordic3;

    assign m00_axis_tready_fir3 = s00_axis_tready_fir3;
    assign s00_axis_tvalid_fir3 = m00_axis_tvalid_fir3;
    assign s00_axis_tlast_fir3 = m00_axis_tlast_fir3;
    assign s00_axis_tstrb_fir3 = m00_axis_tstrb_fir3;

    assign s00_axis_tstrb_cordic3 = m00_axis_tstrb_cordic3;
    assign m00_axis_tready_cordic3 = s00_axis_tready_cordic3;
    assign s00_axis_tvalid_cordic3 = m00_axis_tvalid_cordic3;
    assign s00_axis_tlast_cordic3 = m00_axis_tlast_cordic3;



    fir_15  #(.C_S00_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH ), .C_M00_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH))
    fir_3(  .s00_axis_aclk(s00_axis_aclk),
            .s00_axis_aresetn(s00_axis_aresetn),
            .s00_axis_tready(s00_axis_tready_fir3),
            .s00_axis_tdata(s02_axis_tdata),
            .s00_axis_tstrb(s02_axis_tstrb),
            .s00_axis_tlast(s02_axis_tlast),
            .s00_axis_tvalid(s02_axis_tvalid),
 
            .m00_axis_aclk(s00_axis_aclk),
            .m00_axis_aresetn(s00_axis_aresetn),
            .m00_axis_tready(m00_axis_tready),
            .m00_axis_tdata(port2_reverse_fir_data),
            .m00_axis_tstrb(m00_axis_tstrb_fir3),
            .m00_axis_tlast(m00_axis_tlast_fir3),
            .m00_axis_tvalid(m00_axis_tvalid_fir3)
        );

    cordic  #(.C_S00_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH ), .C_M00_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH))
    cordic_3(   .s00_axis_aclk(s00_axis_aclk),
            .s00_axis_aresetn(s00_axis_aresetn),
            .s00_axis_tready(s00_axis_tready_cordic3),
            .s00_axis_tdata(port2_reverse_fir_data),
            .s00_axis_tstrb(s00_axis_tstrb_fir3),
            .s00_axis_tlast(s00_axis_tlast_fir3),
            .s00_axis_tvalid(s00_axis_tvalid_fir3),
 
            .m00_axis_aclk(s00_axis_aclk),
            .m00_axis_aresetn(s00_axis_aresetn),
            .m00_axis_tready(m00_axis_tready_fir3),
            .m00_axis_tdata(port2_reverse_cordic_data),
            .m00_axis_tstrb(m00_axis_tstrb_cordic3),
            .m00_axis_tlast(m00_axis_tlast_cordic3),
            .m00_axis_tvalid(m00_axis_tvalid_cordic3)
        );

    //chain 4

    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] port2_forward_fir_data;
    logic [C_M00_AXIS_TDATA_WIDTH-1 : 0] port2_forward_cordic_data;

    logic m00_axis_tready_fir4, m00_axis_tvalid_fir4, m00_axis_tlast_fir4;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb_fir4;

    logic s00_axis_tlast_fir4, s00_axis_tvalid_fir4, s00_axis_tready_fir4;
    logic [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s00_axis_tstrb_fir4;

    logic  m00_axis_tready_cordic4, m00_axis_tvalid_cordic4, m00_axis_tlast_cordic4;
    logic [(C_M00_AXIS_TDATA_WIDTH/8)-1: 0] m00_axis_tstrb_cordic4;

    logic s00_axis_tlast_cordic4, s00_axis_tvalid_cordic4, s00_axis_tready_cordic4;
    logic [(C_S00_AXIS_TDATA_WIDTH/8)-1: 0] s00_axis_tstrb_cordic4;

    assign m00_axis_tready_fir4 = s00_axis_tready_fir4;
    assign s00_axis_tvalid_fir4 = m00_axis_tvalid_fir4;
    assign s00_axis_tlast_fir4 = m00_axis_tlast_fir4;
    assign s00_axis_tstrb_fir4 = m00_axis_tstrb_fir4;

    assign s00_axis_tstrb_cordic4 = m00_axis_tstrb_cordic4;
    assign m00_axis_tready_cordic4 = s00_axis_tready_cordic4;
    assign s00_axis_tvalid_cordic4 = m00_axis_tvalid_cordic4;
    assign s00_axis_tlast_cordic4 = m00_axis_tlast_cordic4;



    fir_15  #(.C_S00_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH ), .C_M00_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH))
    fir_4(  .s00_axis_aclk(s00_axis_aclk),
            .s00_axis_aresetn(s00_axis_aresetn),
            .s00_axis_tready(s00_axis_tready_fir4),
            .s00_axis_tdata(s03_axis_tdata),
            .s00_axis_tstrb(s03_axis_tstrb),
            .s00_axis_tlast(s03_axis_tlast),
            .s00_axis_tvalid(s03_axis_tvalid),
 
            .m00_axis_aclk(s00_axis_aclk),
            .m00_axis_aresetn(s00_axis_aresetn),
            .m00_axis_tready(m00_axis_tready),
            .m00_axis_tdata(port2_forward_fir_data),
            .m00_axis_tstrb(m00_axis_tstrb_fir4),
            .m00_axis_tlast(m00_axis_tlast_fir4),
            .m00_axis_tvalid(m00_axis_tvalid_fir4)
        );

    cordic  #(.C_S00_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH ), .C_M00_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH))
    cordic_4(   .s00_axis_aclk(s00_axis_aclk),
            .s00_axis_aresetn(s00_axis_aresetn),
            .s00_axis_tready(s00_axis_tready_cordic4),
            .s00_axis_tdata(port2_forward_fir_data),
            .s00_axis_tstrb(s00_axis_tstrb_fir4),
            .s00_axis_tlast(s00_axis_tlast_fir4),
            .s00_axis_tvalid(s00_axis_tvalid_fir4),
 
            .m00_axis_aclk(s00_axis_aclk),
            .m00_axis_aresetn(s00_axis_aresetn),
            .m00_axis_tready(m00_axis_tready_fir4),
            .m00_axis_tdata(port2_forward_cordic_data),
            .m00_axis_tstrb(m00_axis_tstrb_cordic4),
            .m00_axis_tlast(m00_axis_tlast_cordic4),
            .m00_axis_tvalid(m00_axis_tvalid_cordic4)
        );

    //final coefficient shit

    compute_coeff_averaging  #(.C_S00_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH ), .C_M00_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH))
    crying( .s00_axis_aclk(s00_axis_aclk), // Ports of Axi Slave Bus Interface S00_AXIS. (a1) forward 1
            .s00_axis_aresetn(s00_axis_aresetn),
            .s00_axis_tlast(s00_axis_tlast_cordic2),
            .s00_axis_tvalid(s00_axis_tvalid_cordic2),
            .s00_axis_tdata(port1_forward_cordic_data),
            .s00_axis_tstrb(s00_axis_tstrb_cordic2),
            .s00_axis_tready(s00_axis_tready),


            // Ports of Axi Slave Bus Interface S01_AXIS (b1) reverse 1
            .s01_axis_aclk(s00_axis_aclk), 
            .s01_axis_aresetn(s00_axis_aresetn),
            .s01_axis_tlast(s00_axis_tlast_cordic1),
            .s01_axis_tvalid(s00_axis_tvalid_cordic1),
            .s01_axis_tdata(port1_reverse_cordic_data),
            .s01_axis_tstrb(s00_axis_tstrb_cordic1),
            .s01_axis_tready(s01_axis_tready),

            // Ports of Axi Slave Bus Interface S02_AXIS (a2) forward 2
            .s02_axis_aclk(s00_axis_aclk), 
            .s02_axis_aresetn(s00_axis_aresetn),
            .s02_axis_tlast(s00_axis_tlast_cordic4),
            .s02_axis_tvalid(s00_axis_tvalid_cordic4),
            .s02_axis_tdata(port2_forward_cordic_data),
            .s02_axis_tstrb(s00_axis_tstrb_cordic4),
            .s02_axis_tready(s02_axis_tready),

            // Ports of Axi Slave Bus Interface S03_AXIS (b2) reverse 2
            .s03_axis_aclk(s00_axis_aclk), 
            .s03_axis_aresetn(s00_axis_aresetn),
            .s03_axis_tlast(s00_axis_tlast_cordic3),
            .s03_axis_tvalid(s00_axis_tvalid_cordic3),
            .s03_axis_tdata(port2_reverse_cordic_data),
            .s03_axis_tstrb(s00_axis_tstrb_cordic3),
            .s03_axis_tready(s03_axis_tready),

            // Ports of Axi Master Bus Interface M00_AXIS (S11)
          
            .m00_axis_aclk(s00_axis_aclk),
            .m00_axis_aresetn(s00_axis_aresetn),
            .m00_axis_tready(m00_axis_tready_cordic2),
            .m00_axis_tdata(m00_axis_tdata),
            .m00_axis_tstrb(m00_axis_tstrb),
            .m00_axis_tlast(m00_axis_tlast),
            .m00_axis_tvalid(m00_axis_tvalid),

            // Ports of Axi Master Bus Interface M01_AXIS (S12)
            .m01_axis_aclk(s00_axis_aclk),
            .m01_axis_aresetn(s00_axis_aresetn),
            .m01_axis_tready(m00_axis_tready_cordic1),
            .m01_axis_tdata(m01_axis_tdata),
            .m01_axis_tstrb(m01_axis_tstrb),
            .m01_axis_tlast(m01_axis_tlast),
            .m01_axis_tvalid(m01_axis_tvalid),

            // Ports of Axi Master Bus Interface M02_AXIS (S21)
            .m02_axis_aclk(s00_axis_aclk),
            .m02_axis_aresetn(s00_axis_aresetn),
            .m02_axis_tready(m00_axis_tready_cordic4),
            .m02_axis_tdata(m02_axis_tdata),
            .m02_axis_tstrb(m02_axis_tstrb),
            .m02_axis_tlast(m02_axis_tlast),
            .m02_axis_tvalid(m02_axis_tvalid),
            
            // Ports of Axi Master Bus Interface M03_AXIS (S22)
            .m03_axis_aclk(s00_axis_aclk),
            .m03_axis_aresetn(s00_axis_aresetn),
            .m03_axis_tready(m00_axis_tready_cordic3),
            .m03_axis_tdata(m03_axis_tdata),
            .m03_axis_tstrb(m03_axis_tstrb),
            .m03_axis_tlast(m03_axis_tlast),
            .m03_axis_tvalid(m03_axis_tvalid)
        );

    
 


 
endmodule

`default_nettype wire // prevents system from inferring an undeclared logic (good practice)