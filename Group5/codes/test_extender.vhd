--extender testbench

library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity test_extender is
end test_extender;

architecture test of test_extender is
signal imm_t    : std_logic_vector(15 downto 0);
signal ExtOp_t  : std_logic;
signal result_t : std_logic_vector(31 downto 0);

component extender
port ( imm     : in std_logic_vector(15 downto 0);
         ExtOp   : in std_logic;
		 result  : out std_logic_vector(31 downto 0)
		 );
end component extender;

begin
DUT: extender port map (imm => imm_t, ExtOp => ExtOp_t, result => result_t);

STIM: process
begin
--zero extention
  imm_t <= x"1010";
  ExtOp_t <= '0';
  wait for 10ns;
  
--sign extension
  imm_t <= x"0101";
  ExtOp_t <= '1';
  wait for 10ns;
  
  imm_t <= x"F010";
  ExtOp_t <= '1';
  wait;
  
end process STIM;
end test;
  