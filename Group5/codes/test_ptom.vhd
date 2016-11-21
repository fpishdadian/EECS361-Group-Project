--processor ro memory testbench

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity test_ptom is
end test_ptom;

architecture test of test_ptom is
signal clk :std_logic;
signal arst :std_logic;

component processor_to_mem
port(  clk : in std_logic;
       arst : in std_logic
	   );
end component;

begin test: processor_to_mem port map(
       clk => clk,
	   arst => arst);

process
begin 

clk <= '0';
arst <= '1';
wait for 100ns;
clk <= '1';
arst <= '0';
wait for 100ns;


clk <= '0';
arst <= '0';
wait for 100ns;
clk <= '1';
arst <= '0';
wait for 100ns;

clk <= '0';
arst <= '0';
wait for 100ns;
clk <= '1';
arst <= '0';
wait for 100ns;

clk <= '0';
arst <= '0';
wait for 100ns;
clk <= '1';
arst <= '0';
wait for 100ns;

clk <= '0';
arst <= '0';
wait for 100ns;
clk <= '1';
arst <= '0';
wait for 100ns;

clk <= '0';
arst <= '0';
wait for 100ns;
clk <= '1';
arst <= '0';
wait for 100ns;

clk <= '0';
arst <= '0';
wait for 100ns;
clk <= '1';
arst <= '0';
wait for 100ns;

clk <= '0';
arst <= '0';
wait for 100ns;
clk <= '1';
arst <= '0';
wait for 100ns;

clk <= '0';
arst <= '0';
wait for 100ns;
clk <= '1';
arst <= '0';
wait for 100ns;

clk <= '0';
arst <= '0';
wait for 100ns;
clk <= '1';
arst <= '0';
wait for 100ns;

clk <= '0';
arst <= '0';
wait for 100ns;
clk <= '1';
arst <= '0';
wait for 100ns;

clk <= '0';
arst <= '0';
wait for 100ns;
clk <= '1';
arst <= '0';
wait for 100ns;

clk <= '0';
arst <= '0';
wait for 100ns;
clk <= '1';
arst <= '0';
wait for 100ns;
wait;

end process;
end test;
