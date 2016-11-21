library ieee;
use ieee.std_logic_1164.all;
use work.add_1bit;

entity add_8bit is
    port(
    add8_in0: in std_logic_vector(7 downto 0);
    add8_in1: in std_logic_vector(7 downto 0);
    c_in: in std_logic;
    add8_out: out std_logic_vector(7 downto 0);
    c7_out: out std_logic;
    c8_out: out std_logic
    );
end add_8bit;

architecture structural of add_8bit is

component add_1bit
   port (
   add_in0, add_in1, c_in: in std_logic;
   add_out, c_in_out, c_out: out std_logic
   );
end component add_1bit;

signal temp: std_logic_vector(6 downto 0);

begin
u0: add_1bit port map (
             add_in0 => add8_in0(0),
             add_in1 => add8_in1(0),
             c_in => c_in,
             add_out => add8_out(0),
             c_out => temp(0)
             );

u1: add_1bit port map (
             add_in0 => add8_in0(1),
             add_in1 => add8_in1(1),
             c_in => temp(0),
             add_out => add8_out(1),
             c_out => temp(1)
             );

u2: add_1bit port map (
             add_in0 => add8_in0(2),
             add_in1 => add8_in1(2),
             c_in => temp(1),
             add_out => add8_out(2),
             c_out => temp(2)
             );

u3: add_1bit port map (
             add_in0 => add8_in0(3),
             add_in1 => add8_in1(3),
             c_in => temp(2),
             add_out => add8_out(3),
             c_out => temp(3)
             );

u4: add_1bit port map (
             add_in0 => add8_in0(4),
             add_in1 => add8_in1(4),
             c_in => temp(3),
             add_out => add8_out(4),
             c_out => temp(4)
             );

u5: add_1bit port map (
             add_in0 => add8_in0(5),
             add_in1 => add8_in1(5),
             c_in => temp(4),
             add_out => add8_out(5),
             c_out => temp(5)
             );

u6: add_1bit port map (
             add_in0 => add8_in0(6),
             add_in1 => add8_in1(6),
             c_in => temp(5),
             add_out => add8_out(6),
             c_out => temp(6)
             );

u7: add_1bit port map (
             add_in0 => add8_in0(7),
             add_in1 => add8_in1(7),
             c_in => temp(6),
             add_out => add8_out(7),
             c_in_out => c7_out,
             c_out => c8_out
             );

end structural;

          






