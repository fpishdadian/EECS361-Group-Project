library ieee;
use ieee.std_logic_1164.all;

entity dffr_32bit is
  port (
	clk	: in  std_logic;
	d	: in  std_logic_vector(31 downto 0);
	q	: out std_logic_vector(31 downto 0)
  );
end dffr_32bit;

architecture behavioral of dffr_32bit is
begin
  proc : process (clk)
  begin
	if rising_edge(clk) then
	  q <= d;
	end if;
  end process;
end behavioral;
