-- This file is generated by automatic tools.
library ieee;
use ieee.std_logic_1164.all;

entity or_gate_16 is
  port (
    x   : in  std_logic_vector(15 downto 0);
    y   : in  std_logic_vector(15 downto 0);
    z   : out std_logic_vector(15 downto 0)
  );
end or_gate_16;

architecture structural of or_gate_16 is
begin
  z <= x or y;
end structural;
