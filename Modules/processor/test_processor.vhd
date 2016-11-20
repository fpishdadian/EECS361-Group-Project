--processor testbench

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity test_processor is
end test_processor;

architecture test of test_processor is
signal instr : std_logic_vector(31 downto 0);
signal clk  : std_logic;
signal arst : std_logic;
signal data_in  : std_logic_vector(31 downto 0);
signal instr_addr : std_logic_vector(29 downto 0);
signal data_addr  : std_logic_vector(31 downto 0);
signal data_out  : std_logic_vector(31 downto 0);


component processor
port(  instr   : in std_logic_vector(31 downto 0);
       clk     : in std_logic;
	   arst    : in std_logic;
	   data_in : in std_logic_vector(31 downto 0);
	   instr_addr  : out std_logic_vector(29 downto 0);
	   data_addr   : out std_logic_vector(31 downto 0);
	   data_out    : out std_logic_vector(31 downto 0)
);
end component;

begin
test: processor port map(
     instr => instr,
	 clk => clk,
	 arst => arst,
	 data_in => data_in,
	 instr_addr => instr_addr,
	 data_addr => data_addr,
	 data_out => data_out
	 );
process
begin
--reset
clk <= '0';
arst <= '1';
data_in <= x"00000001";
instr <= x"00000020";
wait for 50ns;
clk <= '1';
arst <= '1';
data_in <= x"00000001";
instr <= x"00000020";
wait for 50ns;

--add
clk <= '0';
arst <= '0';
data_in <= x"00000001";
instr <= x"00000020";
wait for 50ns;
clk <= '1';
arst <= '0';
data_in <= x"00000001";
instr <= x"00000020";
wait for 50ns;

--addi
clk <= '0';
arst <= '0';
data_in <= x"00000001";
instr <= x"20000008";
wait for 50ns;
clk <= '1';
arst <= '0';
data_in <= x"00000001";
instr <= x"20000008";
wait for 50ns;
wait;

end process;
end test;

