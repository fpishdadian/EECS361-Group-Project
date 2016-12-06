library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
entity and_1bit is
port (
x : in std_logic;
y : in std_logic;
z : out std_logic
);
end and_1bit;
architecture structural of and_1bit is
begin
	and0_map : and_gate port map (x => x, y => y, z => z);
end architecture structural;
