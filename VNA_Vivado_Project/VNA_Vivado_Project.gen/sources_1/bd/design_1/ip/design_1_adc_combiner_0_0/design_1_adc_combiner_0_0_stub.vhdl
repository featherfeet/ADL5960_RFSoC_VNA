-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
-- Date        : Mon Nov 25 14:31:14 2024
-- Host        : eecs-digital-28 running 64-bit Ubuntu 24.04.1 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/olt/ADL5960_RFSoC_VNA/VNA_Vivado_Project/VNA_Vivado_Project.gen/sources_1/bd/design_1/ip/design_1_adc_combiner_0_0/design_1_adc_combiner_0_0_stub.vhdl
-- Design      : design_1_adc_combiner_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xczu48dr-ffvg1517-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_adc_combiner_0_0 is
  Port ( 
    s00_axis_aclk : in STD_LOGIC;
    s00_axis_aresetn : in STD_LOGIC;
    s00_axis_tready : out STD_LOGIC;
    s00_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s00_axis_tstrb : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axis_tlast : in STD_LOGIC;
    s00_axis_tvalid : in STD_LOGIC;
    s01_axis_aclk : in STD_LOGIC;
    s01_axis_aresetn : in STD_LOGIC;
    s01_axis_tready : out STD_LOGIC;
    s01_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s01_axis_tstrb : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s01_axis_tlast : in STD_LOGIC;
    s01_axis_tvalid : in STD_LOGIC;
    s02_axis_aclk : in STD_LOGIC;
    s02_axis_aresetn : in STD_LOGIC;
    s02_axis_tready : out STD_LOGIC;
    s02_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s02_axis_tstrb : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s02_axis_tlast : in STD_LOGIC;
    s02_axis_tvalid : in STD_LOGIC;
    s03_axis_aclk : in STD_LOGIC;
    s03_axis_aresetn : in STD_LOGIC;
    s03_axis_tready : out STD_LOGIC;
    s03_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s03_axis_tstrb : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s03_axis_tlast : in STD_LOGIC;
    s03_axis_tvalid : in STD_LOGIC;
    s04_axis_aclk : in STD_LOGIC;
    s04_axis_aresetn : in STD_LOGIC;
    s04_axis_tready : out STD_LOGIC;
    s04_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s04_axis_tstrb : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s04_axis_tlast : in STD_LOGIC;
    s04_axis_tvalid : in STD_LOGIC;
    s05_axis_aclk : in STD_LOGIC;
    s05_axis_aresetn : in STD_LOGIC;
    s05_axis_tready : out STD_LOGIC;
    s05_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s05_axis_tstrb : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s05_axis_tlast : in STD_LOGIC;
    s05_axis_tvalid : in STD_LOGIC;
    s06_axis_aclk : in STD_LOGIC;
    s06_axis_aresetn : in STD_LOGIC;
    s06_axis_tready : out STD_LOGIC;
    s06_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s06_axis_tstrb : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s06_axis_tlast : in STD_LOGIC;
    s06_axis_tvalid : in STD_LOGIC;
    s07_axis_aclk : in STD_LOGIC;
    s07_axis_aresetn : in STD_LOGIC;
    s07_axis_tready : out STD_LOGIC;
    s07_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s07_axis_tstrb : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s07_axis_tlast : in STD_LOGIC;
    s07_axis_tvalid : in STD_LOGIC;
    m00_axis_aclk : in STD_LOGIC;
    m00_axis_aresetn : in STD_LOGIC;
    m00_axis_tvalid : out STD_LOGIC;
    m00_axis_tdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m00_axis_tstrb : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m00_axis_tlast : out STD_LOGIC;
    m00_axis_tready : in STD_LOGIC
  );

end design_1_adc_combiner_0_0;

architecture stub of design_1_adc_combiner_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "s00_axis_aclk,s00_axis_aresetn,s00_axis_tready,s00_axis_tdata[15:0],s00_axis_tstrb[1:0],s00_axis_tlast,s00_axis_tvalid,s01_axis_aclk,s01_axis_aresetn,s01_axis_tready,s01_axis_tdata[15:0],s01_axis_tstrb[1:0],s01_axis_tlast,s01_axis_tvalid,s02_axis_aclk,s02_axis_aresetn,s02_axis_tready,s02_axis_tdata[15:0],s02_axis_tstrb[1:0],s02_axis_tlast,s02_axis_tvalid,s03_axis_aclk,s03_axis_aresetn,s03_axis_tready,s03_axis_tdata[15:0],s03_axis_tstrb[1:0],s03_axis_tlast,s03_axis_tvalid,s04_axis_aclk,s04_axis_aresetn,s04_axis_tready,s04_axis_tdata[15:0],s04_axis_tstrb[1:0],s04_axis_tlast,s04_axis_tvalid,s05_axis_aclk,s05_axis_aresetn,s05_axis_tready,s05_axis_tdata[15:0],s05_axis_tstrb[1:0],s05_axis_tlast,s05_axis_tvalid,s06_axis_aclk,s06_axis_aresetn,s06_axis_tready,s06_axis_tdata[15:0],s06_axis_tstrb[1:0],s06_axis_tlast,s06_axis_tvalid,s07_axis_aclk,s07_axis_aresetn,s07_axis_tready,s07_axis_tdata[15:0],s07_axis_tstrb[1:0],s07_axis_tlast,s07_axis_tvalid,m00_axis_aclk,m00_axis_aresetn,m00_axis_tvalid,m00_axis_tdata[127:0],m00_axis_tstrb[15:0],m00_axis_tlast,m00_axis_tready";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "adc_combiner,Vivado 2024.1";
begin
end;
