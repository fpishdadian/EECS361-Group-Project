--This is the test for a single 32-bit register (basic building block of the register file)

library ieee;
use ieee.std_logic_1164.all;
use work.dffr_a;

entity register_basic_32_test is
end register_basic_32_test;

architecture behave of register_basic_32_test is
component register_basic_32 is
     port(
     clk: in std_logic;
	 arst: in std_logic;
     write_enable: in std_logic;
     data_in: in std_logic_vector(31 downto 0);
     data_out: out std_logic_vector(31 downto 0)
     );
end component;

signal clk : std_logic;
signal arst : std_logic;
signal write_enable : std_logic;
signal data_in : std_logic_vector(31 downto 0);
signal data_out : std_logic_vector(31 downto 0);

begin
u1: register_basic_32 port map(clk=>clk,arst=>arst,write_enable=>write_enable,data_in=>data_in,data_out=>data_out);
process
begin
clk<='0';
arst<='1';
write_enable<='0';
data_in<=x"11111111";
wait for 5 ns;

clk<='1';
arst<='0';
write_enable<='1';
data_in<=x"11111111";
wait for 5 ns;

clk<='0';
arst<='0';
write_enable<='0';
data_in<=x"11110000";
wait for 5 ns;

clk<='1';
arst<='0';
write_enable<='1';
data_in<=x"11110000";
wait for 5 ns;

end  process;
end behave;