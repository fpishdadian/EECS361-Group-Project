-- This code implements a 3 to 1 OR gate

library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.or_gate;

entity or_gate_3to1 is
     port (
         or_in: in std_logic_vector(2 downto 0);
         or_out: out std_logic
         );
end or_gate_3to1;

architecture structural of or_gate_3to1 is

component or_gate
    port (
      x : in std_logic;
      y : in std_logic;
      z : out std_logic
    );
end component or_gate;

signal temp: std_logic;

begin
u1: or_gate port map (
    x => or_in(2),
    y => or_in(1),
    z => temp
    );

u2: or_gate port map (
    x => temp,
    y => or_in(0),
    z => or_out
    );

end structural;




