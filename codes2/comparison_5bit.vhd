library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity comparison_5bit is
port(  x  : in std_logic_vector(4 downto 0);
       y  : in std_logic_vector(4 downto 0);
	   z  : out std_logic);
end comparison_5bit;

architecture structural of comparison_5bit is
signal  sig_xnor : std_logic_vector(4 downto 0);
signal  sig_1  : std_logic;
signal  sig_2  : std_logic;
signal  sig_3  : std_logic;
signal  sig_4  : std_logic;

component xnor_gate is
  port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

component and_gate is
  port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

begin
G1: for I in 4 downto 0 generate
xnor_map: xnor_gate port map(x => x(I), y => y(I), z =>sig_xnor(I));
end generate G1;

and_map1: and_gate port map(x => sig_xnor(0), y => sig_xnor(1), z => sig_1);
and_map2: and_gate port map(x => sig_xnor(2), y => sig_xnor(3), z => sig_2);
and_map3: and_gate port map(x => sig_1, y => sig_2, z => sig_3);
and_map4: and_gate port map(x => sig_3, y => sig_xnor(4), z => z);
end structural;