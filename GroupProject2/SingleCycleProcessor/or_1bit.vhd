library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
entity or_1bit is
port (
x : in std_logic;
y : in std_logic;
z : out std_logic
);
end or_1bit;
architecture structural of or_1bit is
begin
	or0_map : or_gate port map (x => x, y => y, z => z);
end architecture structural;
