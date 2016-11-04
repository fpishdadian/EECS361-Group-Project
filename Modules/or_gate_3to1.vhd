library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity or_gate_3to1 is
port(x : in std_logic_vector(2 downto 0);
     z :out std_logic);
end or_gate_3to1;

architecture dataflows of or_gate_3to1 is
component or_gate is
port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

signal sig : std_logic;

begin

or_gate_map0: or_gate port map(x=>x(0), y=>x(1), z=>sig);
or_gate_map1: or_gate port map(x=>x(2), y=>sig, z=>z);

end dataflows;
