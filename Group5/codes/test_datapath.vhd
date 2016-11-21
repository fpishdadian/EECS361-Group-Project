--datapath testbench

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity test_datapath is
end test_datapath;

architecture test of test_datapath is
signal instr : std_logic_vector(31 downto 0);
signal clk   : std_logic;
signal arst  : std_logic;
signal data_in : std_logic_vector(31 downto 0);
signal RegWrt : std_logic;
signal ALUsrc : std_logic;
signal RegDst : std_logic;
signal branch : std_logic;
signal Extop : std_logic;
signal ALUctr : std_logic_vector(3 downto 0);
signal instr_addr : std_logic_vector(29 downto 0);
signal data_addr : std_logic_vector(31 downto 0);
signal data_out : std_logic_vector(31 downto 0);


component datapath 
port(  instr   : in std_logic_vector(31 downto 0);
       clk     : in std_logic;
	   arst    : in std_logic;
	   data_in : in std_logic_vector(31 downto 0);
	   --control
	   RegWrt : in std_logic;
       ALUsrc :in std_logic;
       RegDst :in std_logic;
       --MemtoReg : in std_logic;
       --MemWrt : in std_logic;
       branch : in std_logic;
       Extop : in std_logic;
       ALUctr : in std_logic_vector(3 downto 0);
	   
	   instr_addr  : out std_logic_vector(29 downto 0);
	   data_addr   : out std_logic_vector(31 downto 0);
	   data_out    : out std_logic_vector(31 downto 0)
);
end component;

begin
test: datapath port map(
      instr => instr,
	  clk => clk,
	  arst => arst,
	  data_in => data_in,
	  RegWrt => RegWrt,
	  ALUsrc => ALUsrc,
	  RegDst => RegDst,
	  branch => branch,
	  Extop => Extop,
	  ALUctr => ALUctr,
	  instr_addr => instr_addr,
	  data_addr => data_addr,
	  data_out => data_out);
	  
process
begin
--reset
instr <= x"00000020";
clk <= '0';
arst <= '1';
data_in <= x"00000001";
RegWrt <= '1';
ALUsrc <= '0';
RegDst <= '1';
branch <= '0';
Extop <= '0';
ALUctr <= "0000";
wait for 50ns;
instr <= x"00000020";
clk <= '1';
arst <= '0';
data_in <= x"00000001";
RegWrt <= '1';
ALUsrc <= '0';
RegDst <= '1';
branch <= '0';
Extop <= '0';
ALUctr <= "0000";
wait for 50ns;

--add r0<=r0+r0
instr <= x"00000020";
clk <= '0';
arst <= '0';
data_in <= x"00000001";
RegWrt <= '1';
ALUsrc <= '0';
RegDst <= '1';
branch <= '0';
Extop <= '0';
ALUctr <= "0000";
wait for 50ns;
instr <= x"00000020";
clk <= '1';
arst <= '0';
data_in <= x"00000001";
RegWrt <= '1';
ALUsrc <= '0';
RegDst <= '1';
branch <= '0';
Extop <= '0';
ALUctr <= "0000";
wait for 50ns;

--addi
instr <= x"00000008";
clk <= '0';
arst <= '0';
data_in <= x"00000001";
RegWrt <= '1';
ALUsrc <= '1';
RegDst <= '1';
branch <= '0';
Extop <= '0';
ALUctr <= "0000";
wait for 50ns;
instr <= x"00000008";
clk <= '1';
arst <= '0';
data_in <= x"00000001";
RegWrt <= '1';
ALUsrc <= '1';
RegDst <= '1';
branch <= '0';
Extop <= '0';
ALUctr <= "0000";
wait for 50ns;
wait;

end process;
end test;

