--connect instruction memory/data memory to processor

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity Memtoprocessor is
port( 
      arst   : in std_logic;
	  clk    : in std_logic
      
);
end Memtoprocessor;

architecture structural of Memtoprocessor is
signal sig_instr       : std_logic_vector(31 downto 0);
signal sig_instr_addr  : std_logic_vector(29 downto 0);
signal sig_processor   : std_logic_vector(31 downto 0);
signal sig_memory      : std_logic_vector(31 downto 0);
signal sig_din         : std_logic_vector(31 downto 0);
signal sig_busb_out    : std_logic_vector(31 downto 0);
signal sig_Mem_wrt     : std_logic;
signal sig_Mem_to_Reg  : std_logic;

component instr_memory
port(addr  : in std_logic_vector(29 downto 0);
       instr : out std_logic_vector(31 downto 0)
  );
end component;

component data_memory
port(
      data_in   : in std_logic_vector(31 downto 0);
	  clk       : in std_logic;
	  addr      : in std_logic_vector(31 downto 0);
	  we        : in std_logic;
	  data_out  : out std_logic_vector(31 downto 0)
      
);
end component;

component singlecycle_processor
port(
      instr      : in std_logic_vector(31 downto 0);	  
	  data_in    : in std_logic_vector(31 downto 0);
	  clk        : in std_logic;
      arst       : in std_logic;	  
	  instr_addr : out std_logic_vector(29 downto 0);	 
	  data_out   : out std_logic_vector(31 downto 0);
	  busb_out   : out std_logic_vector(31 downto 0);
	  Mem_wrt    : out std_logic;
	  Mem_to_Reg : out std_logic
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

begin
instr_mem_map: instr_memory port map(addr => sig_instr_addr, instr => sig_instr);

processor_map: singlecycle_processor port map(instr => sig_instr, instr_addr => sig_instr_addr,
                 arst => arst, clk => clk, data_out => sig_processor, data_in => sig_din,
				 busb_out => sig_busb_out, Mem_wrt => sig_Mem_wrt, Mem_to_Reg => sig_Mem_to_Reg);
				 
data_memory_map: data_memory port map(data_in => sig_busb_out, clk => clk, 
                 addr => sig_processor, we => sig_Mem_wrt, data_out => sig_memory);

mux_map: mux_32 port map(sel => sig_Mem_to_Reg, src0 => sig_processor, 
                 src1 => sig_memory, z => sig_din);
				 

end structural;

