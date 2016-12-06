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
	   --shiftop : in std_logic;
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
signal ALUctr3_n  : std_logic;
signal ALUctr0_n  : std_logic;
signal ALUctr1   : std_logic;
signal ALUctr2   : std_logic;
signal sig_shiftop : std_logic;
signal sig_immshift : std_logic_vector(15 downto 0);
signal sig_shift : std_logic_vector(31 downto 0);
signal sig_R  : std_logic_vector(31 downto 0);
signal sig_beq: std_logic;
signal sig_zero_n : std_logic;
signal sig_bne : std_logic;
signal sig_bgtz : std_logic;
signal sig_data_addr : std_logic_vector(31 downto 0);
signal sig_msb_n : std_logic;
signal sig_and1 : std_logic;
signal sig_or1 : std_logic;
signal sig_zero_b: std_logic;

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

component or_gate
port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

component mux_3to1
port (
     sel: in std_logic_vector(1 downto 0);
     src00: in std_logic;
     src01: in std_logic;
     src11: in std_logic;
     z: out std_logic     );
end component;

begin
shiftop_gen1: not_gate port map(x => ALUctr(3), z => ALUctr3_n);
shiftop_gen2: not_gate port map(x => ALUctr(0), z => ALUctr0_n);
shiftop_gen3: and_gate port map(x => ALUctr0_n, y => ALUctr(1), z => ALUctr1);
shiftop_gen4: and_gate port map(x => ALUctr(2), y => ALUctr3_n, z =>ALUctr2);
shiftop_gen5: and_gate port map(x => ALUctr1, y => ALUctr2, z => sig_shiftop);
 sig_immshift(15 downto 5) <= "00000000000";
 sig_immshift(4 downto 0) <= instr(10 downto 6);
extend_map1: extender port map(imm => sig_immshift, ExtOp => '0', result => sig_shift);

instr_fetch_map: instruction_fetch port map(clk => clk, branch => branch, zero => sig_zero_b,
                     arst => arst, instr_32 => instr, addr_out => instr_addr);

register_file_map1: mux_5 port map(sel => RegDst, src0 => instr(20 downto 16),
                      src1 => instr(15 downto 11),z => sig_Rw);
register_file_map2: register_file port map(clk => clk, arst => arst, write_enable => RegWrt,
                     Ra => instr(25 downto 21), Rb => instr(20 downto 16),
					 Rw => sig_Rw, data_in => data_in, BusA => sig_BusA,
					 BusB => sig_BusB);
data_out <= sig_BusB;

mux_map1: mux_32 port map(sel => sig_shiftop, src0 => sig_BusB, src1 => sig_shift,
                      z => sig_R);

extend_map2: extender port map(imm => instr(15 downto 0), ExtOp => Extop,
                     result => sig_ext);
					 
mux_map2: mux_32 port map(sel => ALUsrc, src0 => sig_R, src1 => sig_ext, 
                     z => sig_mux);		
					 
ALU_map: ALU port map(A => sig_BusA, B => sig_mux, m => ALUctr, Result => sig_data_addr,
                      zero_out => sig_zero);
data_addr <= sig_data_addr;

zero_map1: and_gate port map(x => branch, y => sig_zero, z => sig_beq);	
zero_map2: not_gate port map(x => sig_zero, z => sig_zero_n);	
zero_map3: and_gate port map(x => branch, y => sig_zero_n, z=> sig_bne);
zero_map4: not_gate port map(x => sig_data_addr(31), z => sig_msb_n);	
zero_map5: and_gate port map(x => branch, y => sig_msb_n, z => sig_and1);		  
zero_map6: and_gate port map(x => sig_and1, y => sig_zero_n, z => sig_bgtz);
--zero_map7: or_gate port map(x => sig_beq, y => sig_bne, z => sig_or1);
--zero_map8: or_gate port map(x => sig_or1, y => sig_bgtz, z => sig_zero_b);
zero_map7: mux_3to1 port map(sel => instr(27 downto 26), src00 => sig_beq,
                src01 => sig_bne,  src11 => sig_bgtz, z => sig_zero_b);
					  
end structural;
