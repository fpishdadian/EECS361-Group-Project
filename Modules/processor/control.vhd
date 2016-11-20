--control

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity control is
port( op  :  in std_logic_vector(5 downto 0);
      func  : in std_logic_vector(5 downto 0);
	  RegWrt :out std_logic;
 ALUsrc :out std_logic;
 RegDst :out std_logic;
MemtoReg : out std_logic;
 MemWrt :out std_logic;
 branch :out std_logic;
  Extop :out std_logic;
  ALUctr : out std_logic_vector(3 downto 0)
	  );
end control;

architecture structural of control is
signal sig_ALUop  : std_logic_vector(2 downto 0);

component alu_control
port(
      ALUop: in std_logic_vector(2 downto 0);
      func: in std_logic_vector(5 downto 0);
      ALUctr: out std_logic_vector(3 downto 0)
      );
end component;

component main_control
port(op : in std_logic_vector(5 downto 0);
 RegWrt :out std_logic;
 ALUsrc :out std_logic;
 RegDst :out std_logic;
MemtoReg : out std_logic;
 MemWrt :out std_logic;
 branch :out std_logic;
  Extop :out std_logic;
  ALUop :out std_logic_vector(2 downto 0));
end component;

begin
main_control_map: main_control port map( op => op, RegWrt => RegWrt, ALUsrc => ALUsrc,
                     RegDst => RegDst, MemtoReg => MemtoReg, MemWrt => MemWrt,
					 branch => branch, Extop => Extop, ALUop => sig_ALUop);
					 
alu_control_map: alu_control port map(ALUop => sig_ALUop, func => func, ALUctr => ALUctr);
end structural;