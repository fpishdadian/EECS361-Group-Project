--mux_127
--Shuyue Zheng

library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.mux_n;

entity mux_128 is
  port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(127 downto 0);
	src1  : in  std_logic_vector(127 downto 0);
	z	    : out std_logic_vector(127 downto 0)
  );
end mux_128;

architecture structural of mux_128 is
begin
  mux_map: mux_n
	generic map (n => 128)
	port map (
	  sel => sel,
	  src0 => src0,
	  src1 => src1,
	  z => z);
end structural;

