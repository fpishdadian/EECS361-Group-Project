library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity load_unit is
port(  Op  : in std_logic_vector(5 downto 0);
       Memread  : out std_logic);
end load_unit;

architecture structural of load_unit is
signal Op_inverse  : std_logic_vector(5 downto 0);

component and_gate_6to1 is
port(x : in std_logic_vector(5 downto 0);
     z :out std_logic);
end component;

component not_gate
port (
    x   : in  std_logic;
    z   : out std_logic
  );
end component;

begin
G1: for I in 0 to 5 generate
not_gate_map: not_gate port map(x=>Op(I),z=>Op_inverse(I));
end generate G1;
and_gate_map1: and_gate_6to1 port map(x(0)=>Op(0),x(1)=>Op(1),
     x(2)=>Op_inverse(2),x(3)=>Op_inverse(3),x(4)=>Op_inverse(4),
	 x(5)=>Op(5),z=>Memread);
end structural;