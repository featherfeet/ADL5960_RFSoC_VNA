-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
-- Date        : Thu Nov 14 14:45:11 2024
-- Host        : eecs-digital-27 running 64-bit Ubuntu 24.04.1 LTS
-- Command     : write_vhdl -force -mode funcsim -rename_top design_1_tlast_3_0 -prefix
--               design_1_tlast_3_0_ design_1_tlast_2_0_sim_netlist.vhdl
-- Design      : design_1_tlast_2_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xczu48dr-ffvg1517-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_tlast_3_0_tlast is
  port (
    m00_axis_tlast : out STD_LOGIC;
    s00_axis_aclk : in STD_LOGIC;
    s00_axis_tvalid : in STD_LOGIC;
    m00_axis_tready : in STD_LOGIC;
    s00_axis_aresetn : in STD_LOGIC
  );
end design_1_tlast_3_0_tlast;

architecture STRUCTURE of design_1_tlast_3_0_tlast is
  signal count : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal count0 : STD_LOGIC;
  signal \count0_inferred__0/i__carry__0_n_0\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry__0_n_1\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry__0_n_2\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry__0_n_3\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry__0_n_4\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry__0_n_5\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry__0_n_6\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry__0_n_7\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry_n_0\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry_n_1\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry_n_2\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry_n_3\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry_n_4\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry_n_5\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry_n_6\ : STD_LOGIC;
  signal \count0_inferred__0/i__carry_n_7\ : STD_LOGIC;
  signal count_0 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal data0 : STD_LOGIC_VECTOR ( 17 downto 1 );
  signal \^m00_axis_tlast\ : STD_LOGIC;
  signal m00_axis_tlast_i_1_n_0 : STD_LOGIC;
  signal m00_axis_tlast_i_2_n_0 : STD_LOGIC;
  signal m00_axis_tlast_i_3_n_0 : STD_LOGIC;
  signal m00_axis_tlast_i_4_n_0 : STD_LOGIC;
  signal m00_axis_tlast_i_5_n_0 : STD_LOGIC;
  signal m00_axis_tlast_i_6_n_0 : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal \NLW_count0_inferred__0/i__carry__1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_count0_inferred__0/i__carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 1 );
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \count0_inferred__0/i__carry\ : label is 35;
  attribute ADDER_THRESHOLD of \count0_inferred__0/i__carry__0\ : label is 35;
  attribute ADDER_THRESHOLD of \count0_inferred__0/i__carry__1\ : label is 35;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \count[10]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \count[11]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \count[12]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \count[13]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \count[14]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \count[15]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \count[16]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \count[1]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \count[2]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \count[3]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \count[4]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \count[5]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \count[6]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \count[7]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \count[8]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \count[9]_i_1\ : label is "soft_lutpair4";
begin
  m00_axis_tlast <= \^m00_axis_tlast\;
\count0_inferred__0/i__carry\: unisim.vcomponents.CARRY8
     port map (
      CI => count(0),
      CI_TOP => '0',
      CO(7) => \count0_inferred__0/i__carry_n_0\,
      CO(6) => \count0_inferred__0/i__carry_n_1\,
      CO(5) => \count0_inferred__0/i__carry_n_2\,
      CO(4) => \count0_inferred__0/i__carry_n_3\,
      CO(3) => \count0_inferred__0/i__carry_n_4\,
      CO(2) => \count0_inferred__0/i__carry_n_5\,
      CO(1) => \count0_inferred__0/i__carry_n_6\,
      CO(0) => \count0_inferred__0/i__carry_n_7\,
      DI(7 downto 0) => B"00000000",
      O(7 downto 0) => data0(8 downto 1),
      S(7 downto 0) => count(8 downto 1)
    );
\count0_inferred__0/i__carry__0\: unisim.vcomponents.CARRY8
     port map (
      CI => \count0_inferred__0/i__carry_n_0\,
      CI_TOP => '0',
      CO(7) => \count0_inferred__0/i__carry__0_n_0\,
      CO(6) => \count0_inferred__0/i__carry__0_n_1\,
      CO(5) => \count0_inferred__0/i__carry__0_n_2\,
      CO(4) => \count0_inferred__0/i__carry__0_n_3\,
      CO(3) => \count0_inferred__0/i__carry__0_n_4\,
      CO(2) => \count0_inferred__0/i__carry__0_n_5\,
      CO(1) => \count0_inferred__0/i__carry__0_n_6\,
      CO(0) => \count0_inferred__0/i__carry__0_n_7\,
      DI(7 downto 0) => B"00000000",
      O(7 downto 0) => data0(16 downto 9),
      S(7 downto 0) => count(16 downto 9)
    );
\count0_inferred__0/i__carry__1\: unisim.vcomponents.CARRY8
     port map (
      CI => \count0_inferred__0/i__carry__0_n_0\,
      CI_TOP => '0',
      CO(7 downto 0) => \NLW_count0_inferred__0/i__carry__1_CO_UNCONNECTED\(7 downto 0),
      DI(7 downto 0) => B"00000000",
      O(7 downto 1) => \NLW_count0_inferred__0/i__carry__1_O_UNCONNECTED\(7 downto 1),
      O(0) => data0(17),
      S(7 downto 1) => B"0000000",
      S(0) => count(17)
    );
\count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => count(0),
      O => count_0(0)
    );
\count[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(10),
      O => count_0(10)
    );
\count[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(11),
      O => count_0(11)
    );
\count[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(12),
      O => count_0(12)
    );
\count[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(13),
      O => count_0(13)
    );
\count[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(14),
      O => count_0(14)
    );
\count[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(15),
      O => count_0(15)
    );
\count[16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(16),
      O => count_0(16)
    );
\count[17]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => s00_axis_aresetn,
      O => p_0_in
    );
\count[17]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tready,
      I1 => s00_axis_tvalid,
      O => count0
    );
\count[17]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(17),
      O => count_0(17)
    );
\count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(1),
      O => count_0(1)
    );
\count[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(2),
      O => count_0(2)
    );
\count[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(3),
      O => count_0(3)
    );
\count[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(4),
      O => count_0(4)
    );
\count[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(5),
      O => count_0(5)
    );
\count[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(6),
      O => count_0(6)
    );
\count[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(7),
      O => count_0(7)
    );
\count[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(8),
      O => count_0(8)
    );
\count[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => data0(9),
      O => count_0(9)
    );
\count_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(0),
      Q => count(0),
      R => p_0_in
    );
\count_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(10),
      Q => count(10),
      R => p_0_in
    );
\count_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(11),
      Q => count(11),
      R => p_0_in
    );
\count_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(12),
      Q => count(12),
      R => p_0_in
    );
\count_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(13),
      Q => count(13),
      R => p_0_in
    );
\count_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(14),
      Q => count(14),
      R => p_0_in
    );
\count_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(15),
      Q => count(15),
      R => p_0_in
    );
\count_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(16),
      Q => count(16),
      R => p_0_in
    );
\count_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(17),
      Q => count(17),
      R => p_0_in
    );
\count_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(1),
      Q => count(1),
      R => p_0_in
    );
\count_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(2),
      Q => count(2),
      R => p_0_in
    );
\count_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(3),
      Q => count(3),
      R => p_0_in
    );
\count_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(4),
      Q => count(4),
      R => p_0_in
    );
\count_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(5),
      Q => count(5),
      R => p_0_in
    );
\count_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(6),
      Q => count(6),
      R => p_0_in
    );
\count_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(7),
      Q => count(7),
      R => p_0_in
    );
\count_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(8),
      Q => count(8),
      R => p_0_in
    );
\count_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => count0,
      D => count_0(9),
      Q => count(9),
      R => p_0_in
    );
m00_axis_tlast_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF4000"
    )
        port map (
      I0 => m00_axis_tlast_i_2_n_0,
      I1 => s00_axis_tvalid,
      I2 => m00_axis_tready,
      I3 => s00_axis_aresetn,
      I4 => \^m00_axis_tlast\,
      O => m00_axis_tlast_i_1_n_0
    );
m00_axis_tlast_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => m00_axis_tlast_i_3_n_0,
      I1 => m00_axis_tlast_i_4_n_0,
      I2 => m00_axis_tlast_i_5_n_0,
      I3 => m00_axis_tlast_i_6_n_0,
      O => m00_axis_tlast_i_2_n_0
    );
m00_axis_tlast_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => count(3),
      I1 => count(2),
      I2 => count(5),
      I3 => count(4),
      O => m00_axis_tlast_i_3_n_0
    );
m00_axis_tlast_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFFFFFFFFFFFFFFF"
    )
        port map (
      I0 => count(16),
      I1 => count(17),
      I2 => count(14),
      I3 => count(15),
      I4 => count(1),
      I5 => count(0),
      O => m00_axis_tlast_i_4_n_0
    );
m00_axis_tlast_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => count(11),
      I1 => count(10),
      I2 => count(13),
      I3 => count(12),
      O => m00_axis_tlast_i_5_n_0
    );
m00_axis_tlast_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => count(7),
      I1 => count(6),
      I2 => count(9),
      I3 => count(8),
      O => m00_axis_tlast_i_6_n_0
    );
m00_axis_tlast_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axis_aclk,
      CE => '1',
      D => m00_axis_tlast_i_1_n_0,
      Q => \^m00_axis_tlast\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_tlast_3_0 is
  port (
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
    m00_axis_aclk : in STD_LOGIC;
    m00_axis_aresetn : in STD_LOGIC;
    m00_axis_tvalid : out STD_LOGIC;
    m00_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m00_axis_tstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m00_axis_tlast : out STD_LOGIC;
    m00_axis_tready : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_tlast_3_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_tlast_3_0 : entity is "design_1_tlast_2_0,tlast,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_tlast_3_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_tlast_3_0 : entity is "tlast,Vivado 2024.1";
end design_1_tlast_3_0;

architecture STRUCTURE of design_1_tlast_3_0 is
  signal \<const1>\ : STD_LOGIC;
  signal \^m00_axis_tready\ : STD_LOGIC;
  signal \^s00_axis_tdata\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^s00_axis_tvalid\ : STD_LOGIC;
  signal \^s01_axis_tdata\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of m00_axis_aclk : signal is "xilinx.com:signal:clock:1.0 M00_AXIS_CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of m00_axis_aclk : signal is "XIL_INTERFACENAME M00_AXIS_CLK, ASSOCIATED_BUSIF M00_AXIS, ASSOCIATED_RESET m00_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m00_axis_aresetn : signal is "xilinx.com:signal:reset:1.0 M00_AXIS_RST RST";
  attribute X_INTERFACE_PARAMETER of m00_axis_aresetn : signal is "XIL_INTERFACENAME M00_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m00_axis_tlast : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TLAST";
  attribute X_INTERFACE_INFO of m00_axis_tready : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TREADY";
  attribute X_INTERFACE_PARAMETER of m00_axis_tready : signal is "XIL_INTERFACENAME M00_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m00_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TVALID";
  attribute X_INTERFACE_INFO of s00_axis_aclk : signal is "xilinx.com:signal:clock:1.0 S00_AXIS_CLK CLK";
  attribute X_INTERFACE_PARAMETER of s00_axis_aclk : signal is "XIL_INTERFACENAME S00_AXIS_CLK, ASSOCIATED_BUSIF S00_AXIS, ASSOCIATED_RESET s00_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s00_axis_aresetn : signal is "xilinx.com:signal:reset:1.0 S00_AXIS_RST RST";
  attribute X_INTERFACE_PARAMETER of s00_axis_aresetn : signal is "XIL_INTERFACENAME S00_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s00_axis_tlast : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TLAST";
  attribute X_INTERFACE_INFO of s00_axis_tready : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TREADY";
  attribute X_INTERFACE_INFO of s00_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TVALID";
  attribute X_INTERFACE_PARAMETER of s00_axis_tvalid : signal is "XIL_INTERFACENAME S00_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s01_axis_aclk : signal is "xilinx.com:signal:clock:1.0 S01_AXIS_CLK CLK";
  attribute X_INTERFACE_PARAMETER of s01_axis_aclk : signal is "XIL_INTERFACENAME S01_AXIS_CLK, ASSOCIATED_BUSIF S01_AXIS, ASSOCIATED_RESET s01_axis_aresetn, FREQ_HZ 147456000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s01_axis_aresetn : signal is "xilinx.com:signal:reset:1.0 S01_AXIS_RST RST";
  attribute X_INTERFACE_PARAMETER of s01_axis_aresetn : signal is "XIL_INTERFACENAME S01_AXIS_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s01_axis_tlast : signal is "xilinx.com:interface:axis:1.0 S01_AXIS TLAST";
  attribute X_INTERFACE_INFO of s01_axis_tready : signal is "xilinx.com:interface:axis:1.0 S01_AXIS TREADY";
  attribute X_INTERFACE_INFO of s01_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 S01_AXIS TVALID";
  attribute X_INTERFACE_PARAMETER of s01_axis_tvalid : signal is "XIL_INTERFACENAME S01_AXIS, WIZ_DATA_WIDTH 32, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 147456000, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m00_axis_tdata : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TDATA";
  attribute X_INTERFACE_INFO of m00_axis_tstrb : signal is "xilinx.com:interface:axis:1.0 M00_AXIS TSTRB";
  attribute X_INTERFACE_INFO of s00_axis_tdata : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TDATA";
  attribute X_INTERFACE_INFO of s00_axis_tstrb : signal is "xilinx.com:interface:axis:1.0 S00_AXIS TSTRB";
  attribute X_INTERFACE_INFO of s01_axis_tdata : signal is "xilinx.com:interface:axis:1.0 S01_AXIS TDATA";
  attribute X_INTERFACE_INFO of s01_axis_tstrb : signal is "xilinx.com:interface:axis:1.0 S01_AXIS TSTRB";
begin
  \^m00_axis_tready\ <= m00_axis_tready;
  \^s00_axis_tdata\(15 downto 0) <= s00_axis_tdata(15 downto 0);
  \^s00_axis_tvalid\ <= s00_axis_tvalid;
  \^s01_axis_tdata\(15 downto 0) <= s01_axis_tdata(15 downto 0);
  m00_axis_tdata(31 downto 16) <= \^s01_axis_tdata\(15 downto 0);
  m00_axis_tdata(15 downto 0) <= \^s00_axis_tdata\(15 downto 0);
  m00_axis_tstrb(3) <= \<const1>\;
  m00_axis_tstrb(2) <= \<const1>\;
  m00_axis_tstrb(1) <= \<const1>\;
  m00_axis_tstrb(0) <= \<const1>\;
  m00_axis_tvalid <= \^s00_axis_tvalid\;
  s00_axis_tready <= \^m00_axis_tready\;
  s01_axis_tready <= \^m00_axis_tready\;
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
inst: entity work.design_1_tlast_3_0_tlast
     port map (
      m00_axis_tlast => m00_axis_tlast,
      m00_axis_tready => \^m00_axis_tready\,
      s00_axis_aclk => s00_axis_aclk,
      s00_axis_aresetn => s00_axis_aresetn,
      s00_axis_tvalid => \^s00_axis_tvalid\
    );
end STRUCTURE;
