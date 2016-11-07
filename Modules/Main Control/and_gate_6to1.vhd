library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity and_gate_6to1 is
port(x : in std_logic_vector(5 downto 0);
     z :out std_logic);
end and_gate_6to1;

architecture dataflows of and_gate_6to1 is
component and_gate is
port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

signal level1 : std_logic_vector(2 downto 0);
signal level2 : std_logic;
 
begin

and_gate_map0: and_gate port map(x=>x(0), y=>x(1), z=>level1(0));
and_gate_map1: and_gate port map(x=>x(2), y=>x(3), z=>level1(1));
and_gate_map2: and_gate port map(x=>x(4), y=>x(5), z=>level1(2));
and_gate_map3: and_gate port map(x=>level1(0), y=>level1(1), z=>level2);
and_gate_map4: and_gate port map(x=>level1(2), y=>level2, z=>z);

end dataflows;

