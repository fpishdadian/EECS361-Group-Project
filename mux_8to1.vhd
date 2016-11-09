--Mux 8to1
--Shuyue Zheng

library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity mux_8to1 is
  port(
    ctrlsig : in std_logic_vector(2 downto 0);
	src_0  :	in	std_logic_vector(31 downto 0);
	src_1  :	in	std_logic_vector(31 downto 0);
	src_2  :	in	std_logic_vector(31 downto 0);
	src_3  :	in	std_logic_vector(31 downto 0);
	src_4  :	in	std_logic_vector(31 downto 0);
	src_5  :	in	std_logic_vector(31 downto 0);
	src_6  :	in	std_logic_vector(31 downto 0);
	src_7  :	in	std_logic_vector(31 downto 0);
	result :    out std_logic_vector(31 downto 0)
  );
 end entity mux_8to1;
 
architecture structural of mux_8to1 is
signal s1 : std_logic_vector(127 downto 0);
signal s2 : std_logic_vector(127 downto 0);
signal s3 : std_logic_vector(63 downto 0);
signal s4 : std_logic_vector(31 downto 0);
signal z1 : std_logic_vector(127 downto 0);
signal z2 : std_logic_vector(63 downto 0);
signal z3 : std_logic_vector(31 downto 0);

component mux_128
    port (
      sel   : in  std_logic;
      src0  : in  std_logic_vector(127 downto 0);
      src1  : in  std_logic_vector(127 downto 0);
      z	    : out std_logic_vector(127 downto 0)
    );
  end component mux_128;
  
  component mux_64
    port (
      sel   : in  std_logic;
      src0  : in  std_logic_vector(63 downto 0);
      src1  : in  std_logic_vector(63 downto 0);
      z	    : out std_logic_vector(63 downto 0)
    );
  end component mux_64;
  
  component mux_32
    port (
      sel   : in  std_logic;
      src0  : in  std_logic_vector(31 downto 0);
      src1  : in  std_logic_vector(31 downto 0);
      z	    : out std_logic_vector(31 downto 0)
    );
  end component mux_32;
  
  
begin
s1(31 downto 0) <= src_0(31 downto 0);
s1(63 downto 32) <= src_1(31 downto 0);
s1(95 downto 64) <= src_2(31 downto 0);
s1(127 downto 96) <= src_3(31 downto 0);
s2(31 downto 0) <= src_4(31 downto 0);
s2(63 downto 32) <= src_5(31 downto 0);
s2(95 downto 64) <= src_6(31 downto 0);
s2(127 downto 96) <= src_7(31 downto 0);
mux1: mux_128 port map(sel=>ctrlsig(2), src0=>s1, src1=>s2, z=>z1);

s3(63 downto 0) <= z1(127 downto 64);
mux2: mux_64 port map(sel=>ctrlsig(1), src0=>z1(63 downto 0), src1=>s3(63 downto 0), z=>z2);

s4(31 downto 0) <= z2(63 downto 32);
mux3: mux_32 port map(sel=>ctrlsig(0), src0=>z2(31 downto 0), src1=>s4(31 downto 0), z=>z3);

result <= z3;

end structural;
