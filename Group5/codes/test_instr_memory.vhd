--test instruction memory

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity test_instr_memory is
end test_instr_memory;

architecture test of test_instr_memory is
signal addr   : std_logic_vector(29 downto 0);
signal instr  : std_logic_vector(31 downto 0);

component instr_memory
port(addr  : in std_logic_vector(29 downto 0);
       instr : out std_logic_vector(31 downto 0)
);
end component;

begin

test: instr_memory port map(addr => addr, instr => instr);

process
begin
addr <= "000100000000000000000000000000";
wait for 10ns;

addr <= "000100000000000000000000000001";
wait for 10ns;

addr <= "000100000000000000000000000010";
wait for 10ns;

addr <= "000100000000000000000000000011";
wait for 10ns;

addr <= "000100000000000000000000000100";
wait for 10ns;

addr <= "000100000000000000000000000101";
wait for 10ns;

addr <= "000100000000000000000000000110";
wait for 10ns;

addr <= "000100000000000000000000000111";
wait for 10ns;

addr <= "000100000000000000000000001000";
wait for 10ns;

addr <= "000100000000000000000000001001";
wait for 10ns;
wait;

end process;
end test;