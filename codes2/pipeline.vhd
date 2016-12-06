library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity pipeline is
port(  clk  : in std_logic;
       arst : in std_logic
	  
	   );
end pipeline;

architecture structural of pipeline is
signal sig_instr  : std_logic_vector(31 downto 0);
signal sig_pc_add4  : std_logic_vector(31 downto 0);
signal clkn  : std_logic;
signal sig_instr_1 : std_logic_vector(31 downto 0);
signal sig_pc_add4_1  : std_logic_vector(31 downto 0);

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
signal shift_2  : std_logic_vector(4 downto 0);
signal sig_null1 : std_logic_vector(3 downto 0);

signal sig_pc_add4_out_3 :  std_logic_vector(31 downto 0);
signal       sig_imm_3  :  std_logic_vector(15 downto 0);
signal	   sig_BusA_3  :  std_logic_vector(31 downto 0);
signal	   sig_BusB_3  :  std_logic_vector(31 downto 0);
signal	   Rt_3  :  std_logic_vector(4 downto 0);
signal	   Rd_3  :  std_logic_vector(4 downto 0);
signal	   RegWrt_3   :  std_logic;
signal	  ALUsrc_3   :  std_logic;
signal      RegDst_3   :  std_logic;
signal      MemtoReg_3 :  std_logic;
signal      MemWrt_3   :  std_logic;
 signal     branch_3   :  std_logic;
 signal     Extop_3    :  std_logic;
 signal     ALUctr_3   :  std_logic_vector(3 downto 0);
 signal     Op_3       :  std_logic_vector(1 downto 0);
 signal     shift_3    :  std_logic_vector(4 downto 0);
 
 signal sig_BusB_4 : std_logic_vector(31 downto 0);
signal sig_result_4  : std_logic_vector(31 downto 0);
signal sig_zero_4  : std_logic;
signal sig_pc_add4imm_4  : std_logic_vector(31 downto 0);
signal	   Rw_4 :  std_logic_vector(4 downto 0);
signal RegWrt_4  : std_logic;
signal  sig_null2  : std_logic_vector(35 downto 0);

signal sig_BusB_5 : std_logic_vector(31 downto 0);
signal sig_result_5  : std_logic_vector(31 downto 0);
signal sig_zero_5  : std_logic;
signal sig_pc_add4imm_5  : std_logic_vector(31 downto 0);
signal	   Rw_5 :  std_logic_vector(4 downto 0);
signal      MemtoReg_5 :  std_logic;
signal      MemWrt_5 :  std_logic;
signal      branch_5   :  std_logic;
signal     Op_5       : std_logic_vector(1 downto 0);

signal sig_data_out_6 : std_logic_vector(31 downto 0);
signal sig_result_out_6 : std_logic_vector(31 downto 0);
signal	   Rw_6 :  std_logic_vector(4 downto 0);
signal      branch_6  :  std_logic;
signal RegWrt_5  : std_logic;
signal  sig_null3  : std_logic_vector(72 downto 0);

signal sig_data_out_7 : std_logic_vector(31 downto 0);
signal sig_result_out_7 : std_logic_vector(31 downto 0);
signal	   Rw_7 :  std_logic_vector(4 downto 0);
signal      MemtoReg_7 :  std_logic;

signal	   sig_Rw_8 :  std_logic_vector(4 downto 0);
signal sig_data_out_8 : std_logic_vector(31 downto 0);


component register_basic_64 is
     port(
     clk: in std_logic;
	 arst: in std_logic;
     write_enable: in std_logic;
     data_in: in std_logic_vector(63 downto 0);
     data_out: out std_logic_vector(63 downto 0)
     );
end component;

component instr_fetch_unit is
port(    clk : in std_logic;
         arst : in std_logic;
         branch : in std_logic;
		 pc_add4_addimm : in std_logic_vector(31 downto 0);
		 instr  : out std_logic_vector(31 downto 0);
		 pc_add4 : out std_logic_vector(31 downto 0)
		 );
end component;

component not_gate
port (
    x   : in  std_logic;
    z   : out std_logic
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

component register_basic_144 is
     port(
     clk: in std_logic;
	 arst: in std_logic;
     write_enable: in std_logic;
     data_in: in std_logic_vector(143 downto 0);
     data_out: out std_logic_vector(143 downto 0)
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

component ex_unit is
port(  BusA  : in std_logic_vector(31 downto 0);
       BusB_in  : in std_logic_vector(31 downto 0);
	   imm   : in std_logic_vector(15 downto 0);
	   pc_add4  : in std_logic_vector(31 downto 0);
	   Rt  : in std_logic_vector(4 downto 0);
	   Rd  : in std_logic_vector(4 downto 0);
	   --RegWrt   : in std_logic;
	   ALUsrc   : in std_logic;
       RegDst   : in std_logic;
       --MemtoReg : in std_logic;
       --MemWrt   : in std_logic;
       --branch   : in std_logic;
       Extop    : in std_logic;
       ALUctr   : in std_logic_vector(3 downto 0);
	   --Op       : in std_logic_vector(1 downto 0);
	   --arst  : in std_logic;
	   clk  : in std_logic;
	   shift : in std_logic_vector(4 downto 0);
	   
	   BusB_out  : out std_logic_vector(31 downto 0);
	   result  : out std_logic_vector(31 downto 0);
	   zero  : out std_logic;
	   pc_add4imm_out  : out std_logic_vector(31 downto 0);
	   Rw  : out std_logic_vector(4 downto 0)
	   --RegWrt_out   : out std_logic;
	   --ALUsrc_out   : out std_logic;
       --RegDst_out   : out std_logic;
       --MemtoReg_out : out std_logic;
       --MemWrt_out   : out std_logic;
       --branch_out   : out std_logic;
       --Extop_out    : out std_logic;
       --ALUctr_out   : out std_logic_vector(3 downto 0);
       --Op_out       : out std_logic_vector(1 downto 0)	  
	   
);
end component;

component mem_unit is
port( zero  : in std_logic;
      result_in  : in std_logic_vector(31 downto 0);	  
      BusB  : in std_logic_vector(31 downto 0);
	  Rw_in  : in std_logic_vector(4 downto 0);
	  clk : in std_logic;
	  --arst : in std_logic;
	  --RegWrt   : in std_logic;
	  --ALUsrc   : in std_logic;
      --RegDst   : in std_logic;
      --MemtoReg : in std_logic;
      MemWrt   : in std_logic;
      branch   : in std_logic;
      --Extop    : in std_logic;
      --ALUctr   : in std_logic_vector(3 downto 0);
	  Op       : in std_logic_vector(1 downto 0);
	  
	  data_out   : out std_logic_vector(31 downto 0);
	  result_out : out std_logic_vector(31 downto 0);
	  Rw_out     : out std_logic_vector(4 downto 0);
	  -- RegWrt_out   : out std_logic;
	  -- ALUsrc_out   : out std_logic;
      -- RegDst_out   : out std_logic;
      -- MemtoReg_out : out std_logic;
      -- MemWrt_out   : out std_logic;
      branch_pc    : out std_logic
      -- Extop_out    : out std_logic;
      -- ALUctr_out   : out std_logic_vector(3 downto 0);
      -- Op_out       : out std_logic_vector(1 downto 0)	 
	  );
end component;

component wb_unit is
port(  data_in  : in std_logic_vector(31 downto 0);
       result_in  : in std_logic_vector(31 downto 0);
	   MemtoReg  : in std_logic;
	   Rw_in  : in std_logic_vector(4 downto 0);
	   Rw_out  : out std_logic_vector(4 downto 0);
	   data_out  : out std_logic_vector(31 downto 0)
	   );
end component;

begin
clk_inv: not_gate port map(x => clk, z=> clkn);
instr_fetch_map: instr_fetch_unit port map(clk => clk, arst => arst, 
          branch => '0', pc_add4_addimm => x"00000000", instr => sig_instr,
		  pc_add4 => sig_pc_add4);
register_instr_map: register_basic_64 port map(clk => clk, arst => arst,
          write_enable => '1', data_in(31 downto 0) => sig_instr,
		  data_in(63 downto 32) => sig_pc_add4,
		  data_out(31 downto 0) => sig_instr_1,
		  data_out(63 downto 32) => sig_pc_add4_1);
		  
reg_dec_map: reg_dec_unit port map(instr => sig_instr_1, RegWr => RegWrt_5, 
           clk => clk, arst => arst, data_in => sig_data_out_8, Rw => sig_Rw_8,
		   pc_add4_in => sig_pc_add4_1, pc_add4_out => sig_pc_add4_out_2,
		   imm => sig_imm_2, BusA =>sig_BusA_2, BusB => sig_BusB_2,
		   Rt => Rt_2, Rd => Rd_2, RegWrt => RegWrt_2, ALUsrc => ALUsrc_2,
		   RegDst => RegDst_2, MemtoReg => MemtoReg_2, MemWrt => MemWrt_2,
		   branch => branch_2, Extop => Extop_2, ALUctr => ALUctr_2, Op => Op_2,
		   shift => shift_2);
register_dec_map: register_basic_144 port map(clk => clk, arst => arst, write_enable => '1',
           data_in(4 downto 0) => Rd_2, data_in(9 downto 5) => Rt_2, 
		   data_in(25 downto 10) => sig_imm_2, data_in(57 downto 26) => sig_BusB_2,
		   data_in(89 downto 58) => sig_BusA_2, data_in(121 downto 90) => sig_pc_add4_out_2,
		   data_in(122) => RegWrt_2, data_in(123) => ALUsrc_2, data_in(124) => RegDst_2,
		   data_in(125) => Extop_2, data_in(129 downto 126) => ALUctr_2,
           data_in(134 downto 130) => shift_2, data_in(135) => MemWrt_2,
           data_in(136) => branch_2, data_in(138 downto 137) => Op_2,
           data_in(139) => MemtoReg_2, data_in(143 downto 140) => sig_null1,		   
		   data_out(4 downto 0) => Rd_3, data_out(9 downto 5) => Rt_3, 
		   data_out(25 downto 10) => sig_imm_3, data_out(57 downto 26) => sig_BusB_3,
		   data_out(89 downto 58) => sig_BusA_3, data_out(121 downto 90) => sig_pc_add4_out_3,
		   data_out(122) => RegWrt_3, data_out(123) => ALUsrc_3, data_out(124) => RegDst_3,
		   data_out(125) => Extop_3, data_out(129 downto 126) => ALUctr_3,
           data_out(134 downto 130) => shift_3, data_out(135) => MemWrt_3,
           data_out(136) => branch_3, data_out(138 downto 137) => Op_3,
           data_out(139) => MemtoReg_3, data_out(143 downto 140) => sig_null1);
		   
		   	   
ex_map: ex_unit port map(BusA =>sig_BusA_3, BusB_in => sig_BusB_3,
           imm => sig_imm_3, pc_add4 => sig_pc_add4_out_3, Rt => Rt_3, Rd => Rd_3,
		   ALUsrc => ALUsrc_3, RegDst => RegDst_3, Extop => Extop_3,
		   ALUctr => ALUctr_3, clk => clk, shift => shift_3,
		   BusB_out => sig_BusB_4, result => sig_result_4, zero => sig_zero_4,
		   pc_add4imm_out => sig_pc_add4imm_4, Rw => Rw_4);
register_ex_map: register_basic_144 port map(clk => clk, arst => arst, write_enable => '1',
           data_in(0) => sig_zero_4, data_in(5 downto 1) => Rw_4, 
		   data_in(37 downto 6) => sig_BusB_4, data_in(69 downto 38) => sig_result_4,
		   data_in(101 downto 70) => sig_pc_add4imm_4, data_in(102) => MemWrt_3,
		   data_in(103) => branch_3, data_in(105 downto 104) => Op_3,
		   data_in(106) => MemtoReg_3, data_in(107) => RegWrt_3,
		   data_in(143 downto 108) => sig_null2,
		   data_out(0) => sig_zero_5, data_out(5 downto 1) => Rw_5, 
		   data_out(37 downto 6) => sig_BusB_5, data_out(69 downto 38) => sig_result_5,
		   data_out(101 downto 70) => sig_pc_add4imm_5, data_out(102) => MemWrt_5,
		   data_out(103) => branch_5, data_out(105 downto 104) => Op_5,
		   data_out(106) => MemtoReg_5, data_out(107) => RegWrt_4,
		   data_out(143 downto 108) => sig_null2);
		   
mem_map: mem_unit port map( zero => sig_zero_5, result_in => sig_result_5,
           BusB => sig_BusB_5, Rw_in => Rw_5, clk => clk, MemWrt => MemWrt_5,
		   branch => branch_5, Op => Op_5,
		   data_out => sig_data_out_6, result_out => sig_result_out_6,
		   Rw_out => Rw_6, branch_pc => branch_6);
reg_mem_map: register_basic_144 port map(clk => clk, arst => arst, write_enable => '1',
           data_in(31 downto 0) => sig_data_out_6, data_in(63 downto 32) => sig_result_out_6,
		   data_in(68 downto 64) => Rw_6, data_in(69) => MemtoReg_5,
		   data_in(70) => RegWrt_4, data_in(143 downto 71) => sig_null3,
		   data_out(31 downto 0) => sig_data_out_7, data_out(63 downto 32) => sig_result_out_7,
		   data_out(68 downto 64) => Rw_7, data_out(69) => MemtoReg_7,
		   data_out(70) => RegWrt_5, data_out(143 downto 71) => sig_null3);
		   
wb_map: wb_unit port map(data_in => sig_data_out_7, result_in => sig_result_out_7,
           MemtoReg => MemtoReg_7, Rw_in => Rw_7, Rw_out => sig_Rw_8, 
		   data_out => sig_data_out_8);
		  
		  
end structural;