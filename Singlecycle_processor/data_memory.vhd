--data memory

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;
use work.syncram;

entity data_memory is
port(
      data_in   : in std_logic_vector(31 downto 0);
	  clk       : in std_logic;
	  addr      : in std_logic_vector(31 downto 0);
	  we        : in std_logic;
	  data_out  : out std_logic_vector(31 downto 0)
      
);
end data_memory;

architecture structural of data_memory is

component syncram
generic (
	mem_file : string
  );
  port (
    clk   : in  std_logic; --clock
	cs	  : in	std_logic; --chip inactive when set to 0 
	oe	  :	in	std_logic; --output enable
	we	  :	in	std_logic; --write enable
	addr  : in	std_logic_vector(31 downto 0);
	din	  :	in	std_logic_vector(31 downto 0);
	dout  :	out std_logic_vector(31 downto 0)
  );
end component;

begin

syncram_map: syncram 
generic map(mem_file => "C:\Users\Shuyue\Desktop\Fall 2016\EECS 361\eecs361lib_cpu\eecs361\data\bills_branch.dat"
    )
port map(
          clk => clk,
		  cs => '1',
		  oe => '1',
		  we => we,
		  addr => addr,
		  din => data_in,
		  dout => data_out);
		  
end structural;
		  