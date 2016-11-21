library ieee;
use ieee.std_logic_1164.all;

entity dffr_32 is
  port (
	clk	   : in  std_logic;
    arst   : in  std_logic;
    aload  : in  std_logic;
    adata  : in  std_logic_vector(31 downto 0);
	d	   : in  std_logic_vector(31 downto 0);
    enable : in  std_logic;
	q	   : out std_logic_vector(31 downto 0)
  );
end dffr_32;

architecture behavioral of dffr_32 is
begin
  proc : process (clk, arst, aload)
  begin
    if arst = '1' then             -- If reset=1, reset the output to '0';
      q <= x"00400020";
    elsif aload = '1' then         -- If aload=1, give the adata to output;
      q <= adata;
    elsif rising_edge(clk) then    -- If clk rises and WrEn=1, write the input to output;
      if enable = '1' then
	    q <= d;
      end if;
	end if;
  end process;
end behavioral;
