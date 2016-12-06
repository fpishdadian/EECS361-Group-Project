--execution unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity ex_unit is
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
end ex_unit;

architecture structural of ex_unit is
signal sig_ext : std_logic_vector(31 downto 0);
signal sig_mux32_out : std_logic_vector(31 downto 0);
--signal sig_result : std_logic_vector(31 downto 0);
--signal sig_zero : std_logic;
--signal sig_mux5_out : std_logic_vector(4 downto 0);
--signal sig_null1  : std_logic_vector(2 downto 0);
--signal sig_null2  : std_logic_vector(25 downto 0);
signal sig_adder  : std_logic_vector(31 downto 0);
signal ALUctr3_n  : std_logic;
signal ALUctr0_n  : std_logic;
signal ALUctr1   : std_logic;
signal ALUctr2   : std_logic;
signal sig_shiftop : std_logic;
signal sig_immshift : std_logic_vector(15 downto 0);
signal sig_shift : std_logic_vector(31 downto 0);
signal sig_R  : std_logic_vector(31 downto 0);
signal clkn  : std_logic;

component extender is
  port ( imm     : in std_logic_vector(15 downto 0);
         ExtOp   : in std_logic;
		 result  : out std_logic_vector(31 downto 0)
		 );
end component;

component mux_5 is
  generic (
	n	: integer :=5
  );
  port (
	sel	  : in	std_logic;
	src0  :	in	std_logic_vector(n-1 downto 0);
	src1  :	in	std_logic_vector(n-1 downto 0);
	z	  : out std_logic_vector(n-1 downto 0)
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

component ALU is
     port (
     A: in std_logic_vector(31 downto 0);
     B: in std_logic_vector(31 downto 0);
     m: in std_logic_vector(3 downto 0);
     Result: out std_logic_vector(31 downto 0);
     c_out: out std_logic;
     ovf: out std_logic;
     zero_out: out std_logic
     );
end component;

component full_adder_32 is
  port (   A        : in std_logic_vector(31 downto 0);
           B        : in std_logic_vector(31 downto 0);
		   ctrlsig  : in std_logic_vector(1 downto 0);
		   cout     : out std_logic_vector(0 downto 0);
		   sum      : out std_logic_vector(31 downto 0);
		   overflow : out std_logic_vector(0 downto 0)
      );
end component;

component and_gate
port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

component not_gate
port (
    x   : in  std_logic;
    z   : out std_logic
  );
end component;
	
begin 
clk_inv: not_gate port map(x => clk, z=> clkn);
adder_map: full_adder_32 port map(A => pc_add4, B(31 downto 2) => sig_ext(29 downto 0),
              B(1 downto 0) => "00", ctrlsig => "00",sum => sig_adder);
			  
shiftop_gen1: not_gate port map(x => ALUctr(3), z => ALUctr3_n);
shiftop_gen2: not_gate port map(x => ALUctr(0), z => ALUctr0_n);
shiftop_gen3: and_gate port map(x => ALUctr0_n, y => ALUctr(1), z => ALUctr1);
shiftop_gen4: and_gate port map(x => ALUctr(2), y => ALUctr3_n, z =>ALUctr2);
shiftop_gen5: and_gate port map(x => ALUctr1, y => ALUctr2, z => sig_shiftop);
 sig_immshift(15 downto 5) <= "00000000000";
 sig_immshift(4 downto 0) <= shift(4 downto 0);
extend_map1: extender port map(imm => sig_immshift, ExtOp => '0', result => sig_shift);
mux_map1: mux_32 port map(sel => sig_shiftop, src0 => BusB_in, src1 => sig_shift,
                      z => sig_R);
extender_map2: extender port map(imm => imm, ExtOp => ExtOp, result => sig_ext);
mux_32_map: mux_32 port map(sel => AlUsrc, src0 => sig_R, src1 =>sig_ext, z => sig_mux32_out);
ALU_map: ALU port map(A => BusA, B => sig_mux32_out, m => ALUctr, Result => result,
             zero_out => zero);
mux_5_map: mux_5 port map(sel => RegDst, src0 => Rt, src1 => Rd, z => Rw);

BusB_out <= BusB_in;
pc_add4imm_out <= pc_add4;

-- register128_map: register_basic_128 port map(clk => clkn, arst => arst, write_enable => '1',
             -- data_in(26) => sig_zero, data_in(31 downto 27) => sig_mux5_out, 
			 -- data_in(63 downto 32) => BusB_in, data_in(95 downto 64) => sig_result,
			 -- data_in(127 downto 96) => sig_adder,
			 -- data_in(25 downto 0) => sig_null2,
			 -- data_out(26) => zero, data_out(31 downto 27) => Rw, 
			 -- data_out(63 downto 32) => BusB_out, data_out(95 downto 64) => result,
			 -- data_out(127 downto 96) => pc_add4imm_out,
			 -- data_out(25 downto 0) => sig_null2);
-- control_register: register_basic_16 port map(clk => clkn, arst => arst, write_enable => '1',
             -- data_in(0) => RegWrt, data_in(1) => MemtoReg, data_in(2) => branch,
			 -- data_in(3) => MemWrt, data_in(4) => RegDst, data_in(8 downto 5) => ALUctr,
             -- data_in(9) => ALUsrc, data_in(10) => ExtOp, data_in(12 downto 11) => Op,
			 -- data_in(15 downto 13) => sig_null1,
			 -- data_out(0) => RegWrt_out, data_out(1) => MemtoReg_out, data_out(2) => branch_out,
			 -- data_out(3) => MemWrt_out, data_out(4) => RegDst_out, data_out(8 downto 5) => ALUctr_out,
             -- data_out(9) => ALUsrc_out, data_out(10) => ExtOp_out, data_out(12 downto 11) => Op_out,
			 -- data_out(15 downto 13) => sig_null1);
end structural;