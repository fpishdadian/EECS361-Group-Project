--Instruction fetch unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity instr_fetch_unit is
port(    clk : in std_logic;
         arst : in std_logic;
		 PC_wrt : in std_logic;
         branch : in std_logic;
		 pc_add4_addimm : in std_logic_vector(31 downto 0);
		 instr  : out std_logic_vector(31 downto 0);
		 pc_add4 : out std_logic_vector(31 downto 0)
		 );
end instr_fetch_unit;

architecture structural of instr_fetch_unit is
signal sig_pc : std_logic_vector(31 downto 0);
signal sig_pc_add4  : std_logic_vector(31 downto 0);
--signal sig_instr : std_logic_vector(31 downto 0);
signal sig_mux  : std_logic_vector(31 downto 0);


component mux_32 is
  port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(31 downto 0);
	src1  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
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

component instr_memory is
  port(addr  : in std_logic_vector(29 downto 0);
       instr : out std_logic_vector(31 downto 0)
  );
end component;

component register_basic_64 is
     port(
     clk: in std_logic;
	 arst: in std_logic;
     write_enable: in std_logic;
     data_in: in std_logic_vector(63 downto 0);
     data_out: out std_logic_vector(63 downto 0)
     );
end component;

component pc_32 is
     port(
     clk: in std_logic;
	 arst: in std_logic;
     write_enable: in std_logic;
     data_in: in std_logic_vector(31 downto 0);
     data_out: out std_logic_vector(31 downto 0)
     );
end component;

component not_gate
port (
    x   : in  std_logic;
    z   : out std_logic
  );
end component;

begin

pc_map: pc_32 port map(clk => clk, arst => arst, write_enable => PC_wrt,
                 data_in => sig_mux, data_out => sig_pc);
adder_map: full_adder_32 port map(A => sig_pc, B => x"00000004", 
                 ctrlsig => "00", sum => sig_pc_add4);
instr_memory_map : instr_memory port map(addr => sig_pc(31 downto 2), instr => instr);
-- register_map: register_basic_64 port map(clk => clkn, arst => arst, write_enable => '1',
                 -- data_in(31 downto 0) => sig_instr, data_in(63 downto 32) => sig_pc_add4,
				 -- data_out(31 downto 0) => instr, data_out(63 downto 32) => pc_add4);
mux_map: mux_32 port map(sel => branch, src0 => sig_pc_add4, src1 =>pc_add4_addimm,
                 z => sig_mux);
pc_add4 <= sig_pc_add4;

end structural;				 
