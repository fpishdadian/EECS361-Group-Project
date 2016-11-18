--Instruction memory

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use work.sram;

entity instr_memory is
  port(addr  : in std_logic_vector(29 downto 0);
       instr : out std_logic_vector(31 downto 0)
  );
end instr_memory;

architecture structural of instr_memory is
signal addr32  : std_logic_vector(31 downto 0);

component sram 
generic(mem_file : string);
  port (cs	  : in	std_logic;  -- set to 1 to be inactive
	oe	  :	in	std_logic;  -- output enable
	we	  :	in	std_logic;  -- write enable
	addr  : in	std_logic_vector(31 downto 0);
	din	  :	in	std_logic_vector(31 downto 0);
	dout  :	out std_logic_vector(31 downto 0)
	);
end component;
	
begin
addr32(31 downto 2) <= addr(29 downto 0);
addr32(1 downto 0) <= "00";
 
fetch: sram 
generic map(
      mem_file => "C:\Users\Shuyue\Desktop\Fall 2016\EECS 361\eecs361lib_cpu\eecs361\data\bills_branch.dat"
    )
port map (
         cs => '1',
		 oe => '1',
		 we => '0',
		 addr => addr32,
		 din => x"00000000",
		 dout => instr
		 );

end	structural;	 
