--This is a mux which have 32 32-bit input and one 32-bit output, for building a 32 register file.
library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.data_type.all;

entity mux_reg_file is
port(sel : in std_logic_vector(4 downto 0);
     src : in src_type(31 downto 0);-- 32 32-bit register input
       z : out std_logic_vector(31 downto 0));
end mux_reg_file;

architecture dataflows of mux_reg_file is

signal level1 : src_type(15 downto 0);
signal level2 : src_type(7 downto 0);
signal level3 : src_type(3 downto 0);
signal level4 : src_type(1 downto 0);

component mux_32 is
port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(31 downto 0);
	src1  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end component;

begin
--level 1 mux,32 32-bit input and 16 32-bit output, stored in level1 vector. Select signal is sel(0)
G1: for I in 0 to 15 generate
mux_map0: mux_32 port map(sel=>sel(0),src0=>src(2*I),src1=>src((2*I+1)),z=>level1(I));
end generate G1;

--Level 2 mux, 16 32-bit  inout and 8 32-bit output, stored in level2 vector. Select signal is sel(1)
G2: for I in 0 to 7 generate
mux_map1: mux_32 port map(sel=>sel(1),src0=>level1(2*I),src1=>level1((2*I+1)),z=>level2(I));
end generate G2;

--Level 3 mux, 8 32-bit  inout and 4 32-bit output, stored in level3 vector. Select signal is sel(2)
G3: for I in 0 to 3 generate
mux_map2: mux_32 port map(sel=>sel(2),src0=>level2(2*I),src1=>level2((2*I+1)),z=>level3(I));
end generate G3;

--Level 4 mux, 4 32-bit  inout and 2 32-bit output, stored in level4 vector. Select signal is sel(3)
G4 :for I in 0 to 1 generate
mux_map3: mux_32 port map(sel=>sel(3),src0=>level3(2*I),src1=>level3((2*I+1)),z=>level4(I));
end generate G4;

--Level 5 mux, 2 32-bit  inout and 1 32-bit output(to z of mux_reg_file). Select signal is sel(4)
mux_map4: mux_32 port map(sel=>sel(4),src0=>level4(0),src1=>level4(1),z=>z);

end dataflows;
