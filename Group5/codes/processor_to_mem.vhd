--processor to memory

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity processor_to_mem is
port(  clk : in std_logic;
       arst : in std_logic
	   );
end processor_to_mem;

architecture structural of processor_to_mem is
signal sig_instr_addr: std_logic_vector(29 downto 0);
signal sig_instr  : std_logic_vector(31 downto 0);
signal sig_MemtoReg : std_logic;
signal sig_MemWrt  : std_logic;
signal sig_data_addr : std_logic_vector(31 downto 0);
signal sig_data_out  : std_logic_vector(31 downto 0);
signal sig_mux  : std_logic_vector(31 downto 0);
signal sig_data_in : std_logic_vector(31 downto 0);
--signal clk_n : std_logic;

component processor
port(  instr   : in std_logic_vector(31 downto 0);
       clk     : in std_logic;
	   arst    : in std_logic;
	   data_in : in std_logic_vector(31 downto 0);
	   instr_addr  : out std_logic_vector(29 downto 0);
	   data_addr   : out std_logic_vector(31 downto 0);
	   data_out    : out std_logic_vector(31 downto 0);
	   MemtoReg  : out std_logic;
	   MemWrt  : out std_logic
);
end component;

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

component mux_32
port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(31 downto 0);
	src1  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end component;

component not_gate is
  port (
    x   : in  std_logic;   
    z   : out std_logic
  );
end component;

begin
--inv_clock: not_gate port map(x => clk, z => clk_n);

instr_memory_map: instr_memory port map(addr => sig_instr_addr, instr => sig_instr);

mux_map1: mux_32 port map(sel => sig_MemtoReg, src0 => sig_data_addr, src1 => sig_data_out,
               z => sig_mux); 
processor_map: processor port map( instr => sig_instr, clk => clk, arst => arst,
                   data_in => sig_mux,  instr_addr => sig_instr_addr,
				   data_addr => sig_data_addr, data_out => sig_data_in,
				   MemtoReg => sig_MemtoReg, MemWrt => sig_MemWrt);
data_memory_map: data_memory port map(data_in => sig_data_in, clk => clk,
                   addr => sig_data_addr, we => sig_MemWrt, 
				   data_out => sig_data_out);
				   
end structural;