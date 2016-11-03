-- This code implements a 6 to 1 AND gate

library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.and_gate;

entity and_gate_6to1 is
     port (
         and_in: in std_logic_vector(5 downto 0);
         and_out: out std_logic
         );
end and_gate_6to1;

architecture structural of and_gate_6to1 is

component and_gate
    port (
      x : in std_logic;
      y : in std_logic;
      z : out std_logic
    );
end component and_gate;

signal temp1,temp2,temp3,temp4: std_logic;

begin
u1: and_gate port map (
    x => and_in(5),
    y => and_in(4),
    z => temp1
    );

u2: and_gate port map (
    x => and_in(3),
    y => and_in(2),
    z => temp2
    );

u3: and_gate port map (
    x => temp1,
    y => temp2,
    z => temp3
    );

u4: and_gate port map (
    x => and_in(1),
    y => and_in(0),
    z => temp4
    );

u5: and_gate port map (
    x => temp3,
    y => temp4,
    z => and_out
    );

end structural;






