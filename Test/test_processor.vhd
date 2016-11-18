--processor testbench

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity test_processor is
end test_processor;

architecture test of test_processor is
signal    instr      :  std_logic_vector(31 downto 0);	  
signal	  data_in    :  std_logic_vector(31 downto 0);
signal	  clk        :  std_logic;
signal    arst       :  std_logic;	  
signal	  instr_addr :  std_logic_vector(29 downto 0);
signal	  data_out   :  std_logic_vector(31 downto 0);
signal	  busb_out   :  std_logic_vector(31 downto 0);  