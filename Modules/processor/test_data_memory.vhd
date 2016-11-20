--test data memory

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity test_data_memory is
end test_data_memory;

architecture test of test_data_memory is
signal data_in  : std_logic_vector(31 downto 0);
signal clk  : std_logic;
signal addr : std_logic_vector(31 downto 0);
signal we  : std_logic;
signal data_out : std_logic_vector(31 downto 0);

component data_memory
port(
      data_in   : in std_logic_vector(31 downto 0);
	  clk       : in std_logic;
	  addr      : in std_logic_vector(31 downto 0);
	  we        : in std_logic;
	  data_out  : out std_logic_vector(31 downto 0)
      
);
end component;

begin

test: data_memory port map(
       data_in => data_in,
	   clk => clk,
	   addr => addr,
	   we => we,
	   data_out => data_out);
	   
process
begin
clk <= '0';
data_in <= x"00000000";
addr <= x"10000000";
we <= '0';
wait for 50ns;
clk <= '1';
data_in <= x"00000000";
addr <= x"10000000";
we <= '0';
wait for 50ns;

clk <= '0';
data_in <= x"00000000";
addr <= x"10000004";
we <= '0';
wait for 50ns;
clk <= '1';
data_in <= x"00000000";
addr <= x"10000004";
we <= '0';
wait for 50ns;
wait;

end process;
end test;
