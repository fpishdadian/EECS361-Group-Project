--singlecycle_processor3.0

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity datapath is
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
end datapath;

architecture structural of datapath is
signal sig_zero  : std_logic;
signal sig_Rw    : std_logic_vector(4 downto 0);
signal sig_BusA  : std_logic_vector(31 downto 0);
signal sig_BusB  : std_logic_vector(31 downto 0);
signal sig_ext   : std_logic_vector(31 downto 0);
signal sig_mux   : std_logic_vector(31 downto 0);
--signal sig_ALU   : std_logic_vector(31 downto 0);

component instruction_fetch
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
	 BusB: out std_logic_vector(31 downto 0)
	 );
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

begin

instr_fetch_map: instruction_fetch port map(clk => clk, branch => branch, zero => sig_zero,
                     arst => arst, instr_32 => instr, addr_out => instr_addr);

register_file_map1: mux_5 port map(sel => RegDst, src0 => instr(25 downto 21),
                      src1 => instr(15 downto 11),z => sig_Rw);
register_file_map2: register_file port map(clk => clk, arst => arst, write_enable => RegWrt,
                     Ra => instr(25 downto 21), Rb => instr(20 downto 16),
					 Rw => sig_Rw, data_in => data_in, BusA => sig_BusA,
					 BusB => sig_BusB);
data_out <= sig_BusB;

extend_map: extender port map(imm => instr(15 downto 0), ExtOp => Extop,
                     result => sig_ext);
					 
mux_map: mux_32 port map(sel => ALUsrc, src0 => sig_BusB, src1 => sig_ext, 
                     z => sig_mux);		
					 
ALU_map: ALU port map(A => sig_BusA, B => sig_mux, m => ALUctr, Result => data_addr,
                      zero_out => sig_zero);
					  
end structural;
