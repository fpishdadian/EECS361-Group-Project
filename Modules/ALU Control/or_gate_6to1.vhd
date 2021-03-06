-- This code implements a 6 to 1 OR gate

library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.and_gate;

entity or_gate_6to1 is
     port (
         or_in: in std_logic_vector(5 downto 0);
         or_out: out std_logic
         );
end or_gate_6to1;

architecture structural of or_gate_6to1 is

component or_gate
    port (
      x : in std_logic;
      y : in std_logic;
      z : out std_logic
    );
end component or_gate;

signal temp1,temp2,temp3,temp4: std_logic;

begin
u1: or_gate port map (
    x => or_in(5),
    y => or_in(4),
    z => temp1
    );

u2: or_gate port map (
    x => or_in(3),
    y => or_in(2),
    z => temp2
    );

u3: or_gate port map (
    x => or_in(1),
    y => or_in(0),
    z => temp3
    );

u4: or_gate port map (
    x => temp1,
    y => temp2,
    z => temp4
    );

u5: or_gate port map (
    x => temp3,
    y => temp4,
    z => or_out
    );
 
end structural;