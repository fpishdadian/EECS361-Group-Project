--Instruction Fetch Unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity instruction_fetch is
  port(         
        clk    : in std_logic;
        branch : in std_logic;
		zero   : in std_logic;
		arst   : in std_logic;	
		instr_32  : in std_logic_vector(31 downto 0);
		addr_out: out std_logic_vector(29 downto 0)
  );
end instruction_fetch;

architecture structural of instruction_fetch is
signal addr      : std_logic_vector(29 downto 0);
signal clk_n     : std_logic;
signal imm_ext   : std_logic_vector(31 downto 0);
signal imm_ext30 : std_logic_vector(29 downto 0);
signal addr_30   : std_logic_vector(29 downto 0);
signal addr_32   : std_logic_vector(31 downto 0);
--signal addr_30n  : std_logic_vector(29 downto 0);
signal add_1     : std_logic_vector(29 downto 0);
signal add_2     : std_logic_vector(29 downto 0);
signal ctrl_1    : std_logic;
--signal mux_1     : std_logic_vector(29 downto 0);


component pc_32
  port(  clk: in std_logic;
	 arst: in std_logic;
     write_enable: in std_logic;
     data_in: in std_logic_vector(31 downto 0);
     data_out: out std_logic_vector(31 downto 0)
  );
end component;

component instr_memory

  port(addr  : in std_logic_vector(29 downto 0);
       instr : out std_logic_vector(31 downto 0)
  );
end component;

component full_adder30
  port(    A        : in std_logic_vector(29 downto 0);
           B        : in std_logic_vector(29 downto 0);
		   ctrlsig  : in std_logic;
		   sum      : out std_logic_vector(29 downto 0)
  );
end component;

component extender
  port(  imm     : in std_logic_vector(15 downto 0);
         ExtOp   : in std_logic;
		 result  : out std_logic_vector(31 downto 0)
		 );
end component;

component mux_30
  port (sel   : in  std_logic;
	src0  : in  std_logic_vector(29 downto 0);
	src1  : in  std_logic_vector(29 downto 0);
	z	    : out std_logic_vector(29 downto 0)
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

begin
clock_inv: not_gate port map(x => clk, z => clk_n);

pc_start: pc_32 port map(clk => clk_n, arst => arst, 
             write_enable => '1', data_in(31 downto 2) => addr, 
             data_in(1 downto 0) => "00",data_out => addr_32);

addr_30(29 downto 0) <= addr_32(31 downto 2);
addr_out <= addr_30;
			 
signext: extender port map(imm(15 downto 0) => instr_32(15 downto 0),
         ExtOp => '1', result(31 downto 0) => imm_ext(31 downto 0));
imm_ext30(29 downto 0) <= imm_ext(29 downto 0);

add1: full_adder30 port map (A => addr_30, B => "000000000000000000000000000001",
         ctrlsig => '0', sum => add_1);
add2: full_adder30 port map(A => add_1, B => imm_ext30, 
         ctrlsig => '0', sum => add_2);
		 
mux1_1: and_gate port map(x => branch, y => zero, z => ctrl_1);
mux1_2: mux_30 port map(sel => ctrl_1, src0 => add_1, src1 => add_2, z => addr);

end structural;
