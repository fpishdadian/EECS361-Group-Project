library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dec_n_test is
end dec_n_test;

architecture behave of dec_n_test is
component dec_n is
  generic (
    n	: integer :=5
  );
  port (
    src	: in std_logic_vector(n-1 downto 0);
    z	: out std_logic_vector((2**n)-1 downto 0)
  );
end component;

signal src : std_logic_vector(4 downto 0);
signal z   : std_logic_vector(31 downto 0);

begin
u1: dec_n port map(src=>src,z=>z);
process
begin
src<="00000";
wait for 5 ns;
src<="00001";
wait for 5 ns;
src<="00010";
wait for 5 ns;
src<="00011";
wait for 5 ns;
src<="00100";
wait for 5 ns;
end process;
end behave;