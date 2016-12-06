library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.mux_n;

entity mux_3bit is
  port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(2 downto 0);
	src1  : in  std_logic_vector(2 downto 0);
	z	    : out std_logic_vector(2 downto 0)
  );
end mux_3bit;

architecture structural of mux_3bit is
begin
  mux_map: mux_n
	generic map (n => 3)
	port map (
	  sel => sel,
	  src0 => src0,
	  src1 => src1,
	  z => z);
end structural;
