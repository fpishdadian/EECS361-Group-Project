library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity and_6To1 is
port(x : in std_logic_vector(5 downto 0);
     z :out std_logic);
end and_6To1;

architecture structural of and_6To1 is
component and_gate is
port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

signal temp1 : std_logic_vector(2 downto 0);
signal temp2 : std_logic;
 
begin

and_gate_map0: and_gate port map(x=>x(0), y=>x(1), z=>temp1(0));
and_gate_map1: and_gate port map(x=>x(2), y=>x(3), z=>temp1(1));
and_gate_map2: and_gate port map(x=>x(4), y=>x(5), z=>temp1(2));
and_gate_map3: and_gate port map(x=>temp1(0), y=>temp1(1), z=>temp2);
and_gate_map4: and_gate port map(x=>temp1(2), y=>temp2, z=>z);

end structural;

