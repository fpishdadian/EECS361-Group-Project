--test instruction fetch

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity test_instruction_fetch is
end test_instruction_fetch;

architecture test of test_instruction_fetch is 
signal clk    : std_logic;
signal branch : std_logic;
signal zero   : std_logic;
signal arst   : std_logic;
signal instr_32  : std_logic_vector(31 downto 0);
signal addr_out  : std_logic_vector(29 downto 0);

component instruction_fetch
port(         
        clk    : in std_logic;
        branch : in std_logic;
		zero   : in std_logic;
		arst   : in std_logic;	
		instr_32  : in std_logic_vector(31 downto 0);
		addr_out: out std_logic_vector(29 downto 0)
  );
end component;

begin

test: instruction_fetch
 port map(
        clk => clk,
		branch => branch,
		zero => zero,
		arst => arst,
        instr_32 => instr_32,
		addr_out => addr_out
		);
		
process
begin
clk <= '0';
branch <= '0';
zero <= '0';
arst <= '1';
instr_32 <= x"00000000";
wait for 5ns;

clk <= '1';
branch <= '0';
zero <= '0';
arst <= '0';
instr_32 <= x"00000000";
wait for 5ns;

clk <= '0';
branch <= '0';
zero <= '0';
arst <= '0';
instr_32 <= x"00000001";
wait for 5ns;

clk <= '1';
branch <= '0';
zero <= '0';
arst <= '0';
instr_32 <= x"00000001";
wait for 5ns;

clk <= '0';
branch <= '1';
zero <= '1';
arst <= '0';
instr_32 <= x"00000001";
wait for 5ns;

clk <= '1';
branch <= '1';
zero <= '1';
arst <= '0';
instr_32 <= x"00000001";
wait for 5ns;


wait;

end process;
end test;
