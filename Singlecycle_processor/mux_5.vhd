library ieee;
use ieee.std_logic_1164.all;

entity mux_5 is
  generic (
	n	: integer :=5
  );
  port (
	sel	  : in	std_logic;
	src0  :	in	std_logic_vector(n-1 downto 0);
	src1  :	in	std_logic_vector(n-1 downto 0);
	z	  : out std_logic_vector(n-1 downto 0)
  );
end entity mux_5;

architecture behavioral of mux_5 is
begin
  z	<= src0 when sel = '0' else src1;
end architecture behavioral;
