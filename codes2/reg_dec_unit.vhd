--Reg/Dec unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity reg_dec_unit is
port(  instr  : in std_logic_vector(31 downto 0);
	   RegWr : in std_logic;
	   clk  : in std_logic;
	   arst : in std_logic;
	   data_in  : in std_logic_vector(31 downto 0);
	   Rw  : in std_logic_vector(4 downto 0);
	   pc_add4_in  : in std_logic_vector(31 downto 0);
	   pc_add4_out : out std_logic_vector(31 downto 0);
       imm  : out std_logic_vector(15 downto 0);
	   BusA  : out std_logic_vector(31 downto 0);
	   BusB  : out std_logic_vector(31 downto 0);
	   Rt  : out std_logic_vector(4 downto 0);
	   Rd  : out std_logic_vector(4 downto 0);
	   RegWrt   : out std_logic;
	  ALUsrc   : out std_logic;
      RegDst   : out std_logic;
      MemtoReg : out std_logic;
      MemWrt   : out std_logic;
      branch   : out std_logic;
      Extop    : out std_logic;
      ALUctr   : out std_logic_vector(3 downto 0);
      Op       : out std_logic_vector(1 downto 0);
      shift    : out std_logic_vector(4 downto 0)	  
);
end reg_dec_unit;

architecture structural of reg_dec_unit is
signal sig_RegWrt   : std_logic;
signal sig_ALUsrc   : std_logic;
signal sig_RegDst   : std_logic;
signal sig_MemtoReg : std_logic;
signal sig_MemWrt   : std_logic;
signal sig_branch   : std_logic;
signal sig_Extop    : std_logic;
signal sig_ALUctr   : std_logic_vector(3 downto 0);
signal sig_BusA  : std_logic_vector(31 downto 0);
signal sig_BusB  : std_logic_vector(31 downto 0);
signal sig_null1  : std_logic_vector(2 downto 0);
signal sig_null2  : std_logic;
signal clkn  : std_logic;

component register_basic_128 is
     port(
     clk: in std_logic;
	 arst: in std_logic;
     write_enable: in std_logic;
     data_in: in std_logic_vector(127 downto 0);
     data_out: out std_logic_vector(127 downto 0)
     );
end component;

component register_basic_16 is
     port(
     clk: in std_logic;
	 arst: in std_logic;
     write_enable: in std_logic;
     data_in: in std_logic_vector(15 downto 0);
     data_out: out std_logic_vector(15 downto 0)
     );
end component;

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

component not_gate
port (
    x   : in  std_logic;
    z   : out std_logic
  );
end component;


begin
clk_inv: not_gate port map(x => clk, z=> clkn);
control_map: control port map(op => instr(31 downto 26), func => instr(5 downto 0), 
               RegWrt => sig_RegWrt, ALUsrc => sig_ALUsrc, RegDst => sig_RegDst,
			   MemtoReg => sig_MemtoReg, MemWrt => sig_MemWrt, branch => sig_branch,
			   Extop => sig_Extop, ALUctr => sig_ALUctr);
register16_map: register_basic_16 port map(clk => clkn, arst => arst, write_enable => '1',
               data_in(15 downto 13) => sig_null1,
			   data_in(12 downto 11) => instr(27 downto 26),
               data_in(10) => sig_Extop, data_in(9) => sig_ALUsrc, 
			   data_in(8 downto 5) => sig_ALUctr, data_in(4) => sig_RegDst, 
			   data_in(3) => sig_MemWrt, data_in(2) => sig_branch, 
			   data_in(1) => sig_MemtoReg, data_in(0) => sig_RegWrt,
			   data_out(15 downto 13) => sig_null1,
			   data_out(12 downto 11) => Op,
			   data_out(10) => Extop, data_out(9) => ALUsrc, 
			   data_out(8 downto 5) => ALUctr, data_out(4) => RegDst, 
			   data_out(3) => MemWrt, data_out(2) => branch, 
			   data_out(1) => MemtoReg, data_out(0) => RegWrt);
register_file_map : register_file port map(clk => clk, arst => arst, write_enable => RegWr,
               Ra => instr(25 downto 21), Rb => instr(20 downto 16), Rw => Rw,
			   data_in => data_in, BusA => sig_BusA, BusB => sig_BusB);
			  
register128_map: register_basic_128 port map( clk => clkn, arst => arst, write_enable => '1',
               data_in(127 downto 96) => pc_add4_in, data_in(95 downto 64) => sig_BusA,
			   data_in(63 downto 32) => sig_BusB, data_in(31 downto 16) => instr(15 downto 0),
			   data_in(15 downto 11) => instr(20 downto 16), 
			   data_in(10 downto 6) => instr(15 downto 11),
			   data_in(5 downto 1) => instr(10 downto 6),
			   data_in(0) => sig_null2,
			   data_out(0) => sig_null2,
			   data_out(127 downto 96) => pc_add4_out, data_out(95 downto 64) => BusA,
			   data_out(63 downto 32) => BusB, data_out(31 downto 16) => imm,
			   data_out(15 downto 11) => Rt, data_out(10 downto 6) => Rd,
			   data_out(5 downto 1) => shift);
end structural;