--This is the testbench for register file which can store 32 32-bit data.

library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.data_type.all;
use work.dffr_a;

entity register_file_test is
end register_file_test;

architecture behave of register_file_test is
component register_file is
     port(
	 clk: in std_logic;
	 arst: in std_logic;
	 write_enable: in std_logic;
	 Ra : in std_logic_vector(4 downto 0);
	 Rb : in std_logic_vector(4 downto 0);
	 Rw : in std_logic_vector(4 downto 0);
     data_in: in std_logic_vector(31 downto 0);
     BusA: out std_logic_vector(31 downto 0);
	 BusB: out std_logic_vector(31 downto 0));
end component;

signal clk: std_logic;
signal arst: std_logic;
signal write_enable: std_logic;
signal Ra : std_logic_vector(4 downto 0);
signal Rb : std_logic_vector(4 downto 0);
signal Rw : std_logic_vector(4 downto 0);
signal data_in: std_logic_vector(31 downto 0);
signal BusA: std_logic_vector(31 downto 0);
signal BusB: std_logic_vector(31 downto 0);

begin
u1: register_file port map(clk=>clk,arst=>arst,write_enable=>write_enable,Ra=>Ra,Rb=>Rb,Rw=>Rw,data_in=>data_in,BusA=>BusA,BusB=>BusB);
process
begin
--reset register file to 0
clk<='0';
arst<='1';
write_enable<='0';
Ra<="00000";
Rb<="00000";
Rw<="00000";
data_in<=x"00000000";
wait for 5 ns;

--clk_1: read data from register(30) and register(31) to BusA and BusB respectively;
clk<='1';
arst<='0';
write_enable<='1';
Ra<="11110";
Rb<="11111";
Rw<="11111";
data_in<=x"00000000";
wait for 5 ns;

--still in clk_1: write x"00011111" to register(31);
clk<='0';
arst<='0';
write_enable<='1';
Ra<="11110";
Rb<="11111";
Rw<="11111";
data_in<=x"00011111";
wait for 5 ns;

--clk_2: read data from register(30) and register(31) to BusA and BusB respectively;
clk<='1';
arst<='0';
write_enable<='1';
Ra<="11110";
Rb<="11111";
Rw<="11110";
data_in<=x"00011110";
wait for 5 ns;

--still in clk_2, write x"00011110" to register(30);
clk<='0';
arst<='0';
write_enable<='1';
Ra<="11110";
Rb<="11111";
Rw<="11110";
data_in<=x"00011110";
wait for 5 ns;

--clk_3: read data from register(30) and register(31) to BusA and BusB respectively;
clk<='1';
arst<='0';
write_enable<='1';
Ra<="11110";
Rb<="11111";
Rw<="11101";
data_in<=x"00011101";
wait for 5 ns;

end process;
end behave;