library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.and_gate_9to1;
use work.or_gate_4to1;

entity control_test is
end control_test;

architecture behave of control_test is
component control is
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
end component;

signal op       : std_logic_vector(5 downto 0);
signal func     : std_logic_vector(5 downto 0);
signal RegWrt   : std_logic;
signal ALUsrc   : std_logic;
signal RegDst   : std_logic;
signal MemtoReg : std_logic;
signal MemWrt   : std_logic;
signal branch   : std_logic;
signal Extop    : std_logic;
signal ALUctr   : std_logic_vector(3 downto 0);

begin
map0: control port map(op=>op, func=>func, RegWrt=>RegWrt, ALUsrc=>ALUsrc, 
             RegDst=>RegDst, MemtoReg=>MemtoReg, MemWrt=>MemWrt, 
branch=>branch, Extop=>Extop, ALUctr=>ALUctr);

process
begin
--R-type test
--add
op<="000000";
func<="100000";
wait for 5 ns;
--addu
op<="000000";
func<="100001";
wait for 5 ns;
--and
op<="000000";
func<="100100";
wait for 5 ns;
--or
op<="000000";
func<="100101";
wait for 5 ns;
--sll
op<="000000";
func<="000000";
wait for 5 ns;
--sub
op<="000000";
func<="100010";
wait for 5 ns;
--subu
op<="000000";
func<="100011";
wait for 5 ns;
--slt
op<="000000";
func<="101010";
wait for 5 ns;
--sltu
op<="000000";
func<="101011";
wait for 5 ns;

--lw
op<="100011";
func<="000000";
wait for 5 ns;

--sw
op<="101011";
func<="000000";
wait for 5 ns;

--beq
op<="000100";
func<="000000";
wait for 5 ns;

--bne
op<="000101";
func<="000000";
wait for 5 ns;

--bgtz
op<="000111";
func<="000000";
wait for 5 ns;

--addi
op<="001000";
func<="000000";
wait for 5 ns;

end process;
end behave;
