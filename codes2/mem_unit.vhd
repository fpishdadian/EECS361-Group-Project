--Mem unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity mem_unit is
port( zero  : in std_logic;
      result_in  : in std_logic_vector(31 downto 0);	  
      BusB  : in std_logic_vector(31 downto 0);
	  Rw_in  : in std_logic_vector(4 downto 0);
	  clk : in std_logic;
	  arst : in std_logic;
	  RegWrt   : in std_logic;
	  ALUsrc   : in std_logic;
      RegDst   : in std_logic;
      MemtoReg : in std_logic;
      MemWrt   : in std_logic;
      branch   : in std_logic;
      Extop    : in std_logic;
      ALUctr   : in std_logic_vector(3 downto 0);
	  Op       : in std_logic_vector(1 downto 0);
	  
	  data_out   : out std_logic_vector(31 downto 0);
	  result_out : out std_logic_vector(31 downto 0);
	  Rw_out     : out std_logic_vector(4 downto 0);
	  RegWrt_out   : out std_logic;
	  ALUsrc_out   : out std_logic;
      RegDst_out   : out std_logic;
      MemtoReg_out : out std_logic;
      MemWrt_out   : out std_logic;
      branch_pc    : out std_logic;
      Extop_out    : out std_logic;
      ALUctr_out   : out std_logic_vector(3 downto 0);
      Op_out       : out std_logic_vector(1 downto 0)	 
	  );
end mem_unit;

architecture structural of mem_unit is
signal sig_beq  : std_logic;
signal sig_bne  : std_logic;
signal sig_bgtz : std_logic;
signal sig_zeron : std_logic;
signal sig_data_out : std_logic_vector(31 downto 0);
signal sig_null1  : std_logic_vector(2 downto 0);
signal sig_null2 : std_logic_vector(58 downto 0);

component register_basic_16 is
     port(
     clk: in std_logic;
	 arst: in std_logic;
     write_enable: in std_logic;
     data_in: in std_logic_vector(15 downto 0);
     data_out: out std_logic_vector(15 downto 0)
     );
end component;

component mux_3to1 is
     port (
     sel: in std_logic_vector(1 downto 0);
     src00: in std_logic;
     src01: in std_logic;
     src11: in std_logic;
     z: out std_logic     );
end component;

component data_memory is
port(
      data_in   : in std_logic_vector(31 downto 0);
	  clk       : in std_logic;
	  addr      : in std_logic_vector(31 downto 0);
	  we        : in std_logic;
	  data_out  : out std_logic_vector(31 downto 0)
      
);
end component;

component and_gate is
  port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

component not_gate is
  port (
    x   : in  std_logic;
    z   : out std_logic
  );
end component;

component register_basic_128 is
     port(
     clk: in std_logic;
	 arst: in std_logic;
     write_enable: in std_logic;
     data_in: in std_logic_vector(127 downto 0);
     data_out: out std_logic_vector(127 downto 0)
     );
end component;

begin
controlregister: register_basic_16 port map(clk => clk, arst => arst, write_enable => '1',
             data_in(0) => RegWrt, data_in(1) => MemtoReg, data_in(2) => branch,
			 data_in(3) => MemWrt, data_in(4) => RegDst, data_in(8 downto 5) => ALUctr,
             data_in(9) => ALUsrc, data_in(10) => ExtOp, data_in(12 downto 11) => Op,
			 data_in(15 downto 13) => sig_null1,
			 data_out(0) => RegWrt_out, data_out(1) => MemtoReg_out, data_out(2) => branch_pc,
			 data_out(3) => MemWrt_out, data_out(4) => RegDst_out, data_out(8 downto 5) => ALUctr_out,
             data_out(9) => ALUsrc_out, data_out(10) => ExtOp_out, data_out(12 downto 11) => Op_out,
			 data_out(15 downto 13) => sig_null1);
not1: not_gate port map(x => zero, z => sig_zeron);
and1: and_gate port map(x => zero, y => branch, z => sig_beq);
and2: and_gate port map(x => sig_zeron, y => branch, z => sig_bne);
and3: and_gate port map(x => sig_bne, y => result_in(31), z => sig_bgtz );
mux_3to1map: mux_3to1 port map(sel => Op, src00 => sig_beq, src01 => sig_bne, 
              src11 => sig_bgtz, z => branch_pc);
datamem_map: data_memory port map(data_in => BusB, clk => clk, addr => result_in,
             we => MemWrt, data_out => sig_data_out);
register128: register_basic_128 port map(clk => clk, arst => arst, write_enable => '1',
             data_in(31 downto 0) => sig_data_out, data_in(63 downto 32) => result_in,
             data_in(68 downto 64) => Rw_in,
			 data_in(127 downto 69) => sig_null2,
			 data_out(31 downto 0) => data_out, data_out(63 downto 32) => result_out,
             data_out(68 downto 64) => Rw_out,
			 data_out(127 downto 69) => sig_null2);
end structural;