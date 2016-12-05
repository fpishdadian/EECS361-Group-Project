library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity pipeline is
port(  clk  : in std_logic;
       arst : in std_logic);
end pipeline;

architecture structural of pipeline is
--signal sig_branch_1  : std_logic;
--signal sig_pc_add4imm_1  : std_logic_vector(31 downto 0);
signal sig_instr_1  : std_logic_vector(31 downto 0);
signal sig_pc_add4_1  : std_logic_vector(31 downto 0);
--signal sig_RegWr_2 : std_logic;
signal sig_mux_5  : std_logic_vector(31 downto 0);
--signal Rw_4  : std_logic_vector(4 downto 0);
--signal sig_pc_add4_2  : std_logic_vector(31 downto 0);
signal sig_pc_add4_out_2  : std_logic_vector(31 downto 0);
signal sig_imm_2 : std_logic_vector(15 downto 0);
signal sig_BusA_2 : std_logic_vector(31 downto 0);
signal sig_BusB_2 : std_logic_vector(31 downto 0);
signal       Rt_2  :  std_logic_vector(4 downto 0);
signal	   Rd_2 :  std_logic_vector(4 downto 0);
signal    RegWrt_2   :  std_logic;
signal	  ALUsrc_2   :  std_logic;
signal      RegDst_2   :  std_logic;
signal      MemtoReg_2 :  std_logic;
signal      MemWrt_2  :  std_logic;
signal      branch_2   :  std_logic;
signal      Extop_2    :  std_logic;
signal     ALUctr_2   : std_logic_vector(3 downto 0);
signal     Op_2       : std_logic_vector(1 downto 0);

signal sig_BusB_3 : std_logic_vector(31 downto 0);
signal sig_result_3  : std_logic_vector(31 downto 0);
signal sig_zero_3  : std_logic;
signal sig_pc_add4imm_3  : std_logic_vector(31 downto 0);
signal	   Rw_3 :  std_logic_vector(4 downto 0);
signal    RegWrt_3   :  std_logic;
signal	  ALUsrc_3   :  std_logic;
signal      RegDst_3   :  std_logic;
signal      MemtoReg_3 :  std_logic;
signal      MemWrt_3  :  std_logic;
signal      branch_3   :  std_logic;
signal      Extop_3    :  std_logic;
signal     ALUctr_3   : std_logic_vector(3 downto 0);
signal     Op_3       : std_logic_vector(1 downto 0);

signal sig_data_out_4 : std_logic_vector(31 downto 0);
signal sig_result_out_4 : std_logic_vector(31 downto 0);
signal	   Rw_4 :  std_logic_vector(4 downto 0);
signal    RegWrt_4   :  std_logic;
signal	  ALUsrc_4   :  std_logic;
signal      RegDst_4   :  std_logic;
signal      MemtoReg_4 :  std_logic;
signal      MemWrt_4 :  std_logic;
signal      branch_4   :  std_logic;
signal      Extop_4    :  std_logic;
signal     ALUctr_4   : std_logic_vector(3 downto 0);
signal     Op_4       : std_logic_vector(1 downto 0);

signal  sig_shift  : std_logic_vector(4 downto 0);

component instr_fetch_unit is
port(    clk : in std_logic;
         arst : in std_logic;
         branch : in std_logic;
		 pc_add4_addimm : in std_logic_vector(31 downto 0);
		 instr  : out std_logic_vector(31 downto 0);
		 pc_add4 : out std_logic_vector(31 downto 0)
		 );
end component;

component reg_dec_unit is
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
end component;

component ex_unit is
port(  BusA  : in std_logic_vector(31 downto 0);
       BusB_in  : in std_logic_vector(31 downto 0);
	   imm   : in std_logic_vector(15 downto 0);
	   pc_add4  : in std_logic_vector(31 downto 0);
	   Rt  : in std_logic_vector(4 downto 0);
	   Rd  : in std_logic_vector(4 downto 0);
	   RegWrt   : in std_logic;
	   ALUsrc   : in std_logic;
       RegDst   : in std_logic;
       MemtoReg : in std_logic;
       MemWrt   : in std_logic;
       branch   : in std_logic;
       Extop    : in std_logic;
       ALUctr   : in std_logic_vector(3 downto 0);
	   Op       : in std_logic_vector(1 downto 0);
	   arst  : in std_logic;
	   clk  : in std_logic;
	   shift : in std_logic_vector(4 downto 0);
	   
	   BusB_out  : out std_logic_vector(31 downto 0);
	   result  : out std_logic_vector(31 downto 0);
	   zero  : out std_logic;
	   pc_add4imm_out  : out std_logic_vector(31 downto 0);
	   Rw  : out std_logic_vector(4 downto 0);
	   RegWrt_out   : out std_logic;
	   ALUsrc_out   : out std_logic;
       RegDst_out   : out std_logic;
       MemtoReg_out : out std_logic;
       MemWrt_out   : out std_logic;
       branch_out   : out std_logic;
       Extop_out    : out std_logic;
       ALUctr_out   : out std_logic_vector(3 downto 0);
       Op_out       : out std_logic_vector(1 downto 0)	  
	   
);
end component;

component mem_unit is
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
end component;

component mux_32 is
  port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(31 downto 0);
	src1  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end component;


begin
instr_fetch_unit_map: instr_fetch_unit port map(clk => clk, arst => arst,
           branch => branch_4, pc_add4_addimm => sig_pc_add4imm_3,
		   instr => sig_instr_1, pc_add4 => sig_pc_add4_1);
reg_dec_map: reg_dec_unit port map(instr => sig_instr_1, RegWr => RegWrt_4, 
           clk => clk, arst => arst, data_in => sig_mux_5, Rw => Rw_4,
		   pc_add4_in => sig_pc_add4_1, pc_add4_out => sig_pc_add4_out_2,
		   imm => sig_imm_2, BusA =>sig_BusA_2, BusB => sig_BusB_2,
		   Rt => Rt_2, Rd => Rd_2, RegWrt => RegWrt_2, ALUsrc => ALUsrc_2,
		   RegDst => RegDst_2, MemtoReg => MemtoReg_2, MemWrt => MemWrt_2,
		   branch => branch_2, Extop => Extop_2, ALUctr => ALUctr_2, Op => Op_2,
		   shift => sig_shift);
ex_unit_map: ex_unit port map(BusA =>sig_BusA_2, BusB_in => sig_BusB_2,
           imm => sig_imm_2, pc_add4 => sig_pc_add4_out_2, Rt => Rd_2, Rd => Rd_2,
		   RegWrt => RegWrt_2, ALUsrc => ALUsrc_2,
		   RegDst => RegDst_2, MemtoReg => MemtoReg_2, MemWrt => MemWrt_2,
		   branch => branch_2, Extop => Extop_2, ALUctr => ALUctr_2, Op => Op_2 ,
		   arst => arst, clk => clk, shift => sig_shift,
		   BusB_out => sig_BusB_3, result => sig_result_3, zero => sig_zero_3,
		   pc_add4imm_out => sig_pc_add4imm_3, Rw => Rw_3, RegWrt_out => RegWrt_3,
		   ALUsrc_out => ALUsrc_3, RegDst_out => RegDst_3, MemtoReg_out => MemtoReg_3,
		   MemWrt_out => MemWrt_3, branch_out => branch_3, Extop_out => Extop_3,
		   ALUctr_out => ALUctr_3, Op_out => Op_3);
mem_unit_map: mem_unit port map( zero => sig_zero_3, result_in => sig_result_3,
           BusB => sig_BusB_3, Rw_in => Rw_3, clk => clk, arst => arst,
		   RegWrt => RegWrt_3, ALUsrc => ALUsrc_3,
		   RegDst => RegDst_3, MemtoReg => MemtoReg_3, MemWrt => MemWrt_3,
		   branch => branch_3, Extop => Extop_3, ALUctr => ALUctr_3, Op => Op_3,
		   data_out => sig_data_out_4, result_out => sig_result_out_4,
		   Rw_out => Rw_4, RegWrt_out => RegWrt_4,
		   ALUsrc_out => ALUsrc_4, RegDst_out => RegDst_4, MemtoReg_out => MemtoReg_4,
		   MemWrt_out => MemWrt_4, branch_pc => branch_4, Extop_out => Extop_4,
		   ALUctr_out => ALUctr_4, Op_out => Op_4);
mux_map: mux_32 port map(sel => MemtoReg_4, src0 => sig_result_out_4,
           src1 => sig_data_out_4, z => sig_mux_5);
end structural;
