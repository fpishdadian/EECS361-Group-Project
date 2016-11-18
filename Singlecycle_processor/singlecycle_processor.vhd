--singlecycle processor

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity singlecycle_processor is
port(
      instr      : in std_logic_vector(31 downto 0);	  
	  data_in    : in std_logic_vector(31 downto 0);
	  clk        : in std_logic;
      arst       : in std_logic;	  
	  instr_addr : out std_logic_vector(29 downto 0);	 
	  data_out   : out std_logic_vector(31 downto 0);
	  busb_out   : out std_logic_vector(31 downto 0);
	  Mem_wrt    : out std_logic;
	  Mem_to_Reg   : out std_logic
);
end singlecycle_processor;

architecture structural of singlecycle_processor is
signal sig_busa  :  std_logic_vector(31 downto 0);
signal sig_busb  : std_logic_vector(31 downto 0);
signal sig_RegDst: std_logic_vector(4 downto 0);
signal sig_ext   : std_logic_vector(31 downto 0);
signal sig_mux   : std_logic_vector(31 downto 0);
--control signals
signal RegWrt   :  std_logic;
signal ALUsrc   :  std_logic;
signal RegDst   :  std_logic;
signal MemtoReg :  std_logic;
signal MemWrt   :  std_logic;
signal Branch   :  std_logic;
signal Extop    :  std_logic;
signal ALUop    :  std_logic_vector(2 downto 0);
signal zero     :  std_logic;

signal ALUctr   : std_logic_vector(3 downto 0);

component instructon_fetch
port(         
        clk    : in std_logic;
        branch : in std_logic;
		zero   : in std_logic;
		arst   : in std_logic;	
		instr_32  : in std_logic_vector(31 downto 0);
		addr_out: out std_logic_vector(29 downto 0)
  );
end component;


component register_file
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

component ALU
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

component mux_32
port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(31 downto 0);
	src1  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end component;

component extender
port ( imm     : in std_logic_vector(15 downto 0);
         ExtOp   : in std_logic;
		 result  : out std_logic_vector(31 downto 0)
		 );
end component;

component mux_5
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

component alu_control
port(
      ALUop: in std_logic_vector(2 downto 0);
      func: in std_logic_vector(5 downto 0);
      ALUctr: out std_logic_vector(3 downto 0)
      );
end component;

begin
controlsig_map1: main_control port map(op => instr(31 downto 26), RegWrt => RegWrt,
                  ALUsrc => ALUsrc, RegDst => RegDst, MemtoReg => MemtoReg,
				  MemWrt => MemWrt, branch => Branch, Extop => Extop, ALUop => ALUop);
controlsig_map2: alu_control port map(ALUop => ALUop, func => instr(5 downto 0), 
                  ALUctr => ALUctr);
Mem_wrt <= MemWrt;
Mem_to_Reg <= MemtoReg;

instr_fetch: instructon_fetch port map(arst => arst, instr_32 => instr, clk => clk, 
               branch => branch, zero => zero, addr_out => instr_addr);

reg_file1: mux_5 port map(sel => RegDst, src0 =>instr(25 downto 21),
              src1 => instr(15 downto 11), z => sig_RegDst);			   
reg_file2: register_file port map(arst => arst, clk => clk, write_enable => RegWrt,
             data_in => data_in, Ra => instr(20 downto 16), Rb => instr(25 downto 21),
			 Rw => sig_RegDst, BusA => sig_busa, BusB => sig_busb);
busb_out <= sig_busb;

extender_map: extender port map(imm => instr(15 downto 0), ExtOp => Extop, 
             result => sig_ext);
			
mux_map1: mux_32 port map(sel => ALUsrc, src0 => sig_busb, src1 => sig_ext, z => sig_mux);
ALU_map : ALU port map(A => sig_busa, B => sig_mux, m => ALUctr, Result => data_out,
            zero_out => zero);
			
end structural;
			

			
