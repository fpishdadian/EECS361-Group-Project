library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity sll_32 is
port(x : in std_logic_vector(31 downto 0);
 shift : in std_logic_vector(31 downto 0);
     z :out std_logic_vector(31 downto 0));
end sll_32;

architecture dataflows of sll_32 is

component mux is
port (
	sel	  : in	std_logic;
	src0  :	in	std_logic;
	src1  :	in	std_logic;
	z	  : out std_logic
  );
end component;

signal level1 : std_logic_vector(31 downto 0);
signal level2 : std_logic_vector(31 downto 0);
signal level3 : std_logic_vector(31 downto 0);
signal level4 : std_logic_vector(31 downto 0);

begin
--level ones shift one bit when shift(0)=1
mux_map0: mux port map(sel=>shift(0), src0=>x(0), src1=>'0', z=>level1(0));

G1: for I in 1 to 31 generate
mux_map1: mux port map(sel=>shift(0), src0=>x(I), src1=>x(I-1), z=>level1(I));
end generate G1;

--level2 shift 2 bits when shift(1)=1
u0: mux port map(sel=>shift(1),src0=>level1(0),src1=>'0',z=>level2(0));
u1: mux port map(sel=>shift(1),src0=>level1(1),src1=>'0',z=>level2(1));

G2: for I in 2 to 31 generate
u2: mux port map(sel=>shift(1),src0=>level1(I),src1=>level1(I-2),z=>level2(I));
end generate G2;

--level3 shift 4 bits when shift(2)=1
G3: for I in 0 to 3 generate
d0: mux port map(sel=>shift(2),src0=>level2(I),src1=>'0',z=>level3(I));
end generate G3;

G4: for I in 4 to 31 generate
d1: mux port map(sel=>shift(2),src0=>level2(I),src1=>level2(I-4),z=>level3(I));
end generate G4;

--level4 shift 8 bits when shift(3)=1
G5: for I in 0 to 7 generate
e0: mux port map(sel=>shift(3),src0=>level3(I),src1=>'0',z=>level4(I));
end generate G5;

G6: for I in 8 to 31 generate
e1: mux port map(sel=>shift(3),src0=>level3(I),src1=>level3(I-8),z=>level4(I));
end generate G6;

--level4 shift 16 bits when shift(4)=1
G7: for I in 0 to 15 generate
f0: mux port map(sel=>shift(4),src0=>level4(I),src1=>'0',z=>z(I));
end generate G7;
G8: for I in 16 to 31 generate
f1: mux port map(sel=>shift(4),src0=>level4(I),src1=>level4(I-16),z=>z(I));
end generate G8;

end dataflows;

