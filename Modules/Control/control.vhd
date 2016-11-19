library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.and_gate_9to1;
use work.or_gate_4to1;

entity control is
port (op       : in std_logic_vector(5 downto 0);
      func     : in std_logic_vector(5 downto 0);
	  RegWrt   : out std_logic;
	  ALUsrc   : out std_logic;
      RegDst   : out std_logic;
      MemtoReg : out std_logic;
      MemWrt   : out std_logic;
      branch   : out std_logic;
      Extop    : out std_logic;
      ALUctr   : out std_logic_vector(3 downto 0));
end control;

architecture structural of control is
component alu_control is
      port(
      ALUop: in std_logic_vector(2 downto 0);
      func: in std_logic_vector(5 downto 0);
      ALUctr: out std_logic_vector(3 downto 0)
      );
end component;

component main_control is
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

signal sig_ALUop : std_logic_vector(2 downto 0);

begin
map0: main_control port map(op=>op, RegWrt=>RegWrt, ALUsrc=>ALUsrc, RegDst=>RegDst, MemtoReg=>MemtoReg, MemWrt=>MemWrt, branch=>branch, Extop=>Extop, ALUop=>sig_ALUop);
map1: alu_control port map(ALUop=>sig_ALUop, func=>func, ALUctr=>ALUctr);
end structural;