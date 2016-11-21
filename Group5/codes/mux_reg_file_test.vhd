--This is the testbench for mux_reg_file.
library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use ieee.std_logic_arith.all;
use work.data_type.all;

entity mux_reg_file_test is
end mux_reg_file_test;

architecture behave of mux_reg_file_test is

component mux_reg_file is
port(sel : in std_logic_vector(4 downto 0);
     src : in src_type(31 downto 0);-- 32 32-bit register input
       z : out std_logic_vector(31 downto 0));
end component;

signal sel : std_logic_vector(4 downto 0);
signal src : src_type(31 downto 0);
signal z   : std_logic_vector(31 downto 0);

begin
u1: mux_reg_file port map(sel=>sel,src=>src,z=>z);

process
begin
sel<="00000";
for I in 0 to 31 loop
src(I)<=CONV_STD_LOGIC_VECTOR(I,32);
end loop;
wait for 5 ns;

sel<="00001";
for I in 0 to 31 loop
src(I)<=CONV_STD_LOGIC_VECTOR(I,32);
end loop;
wait for 5 ns;

sel<="00010";
for I in 0 to 31 loop
src(I)<=CONV_STD_LOGIC_VECTOR(I,32);
end loop;
wait for 5 ns;

sel<="00100";
for I in 0 to 31 loop
src(I)<=CONV_STD_LOGIC_VECTOR(I,32);
end loop;
wait for 5 ns;

sel<="01000";
for I in 0 to 31 loop
src(I)<=CONV_STD_LOGIC_VECTOR(I,32);
end loop;
wait for 5 ns;

sel<="11011";
for I in 0 to 31 loop
src(I)<=CONV_STD_LOGIC_VECTOR(I,32);
end loop;
wait for 5 ns;
end process;
end behave;

