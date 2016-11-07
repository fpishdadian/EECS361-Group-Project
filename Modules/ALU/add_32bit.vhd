library ieee;
use ieee.std_logic_1164.all;
use work.add_8bit;

entity add_32bit is
       port(
       add32_in0: in std_logic_vector(31 downto 0);
       add32_in1: in std_logic_vector(31 downto 0);
       c_in: in std_logic;
       add32_out: out std_logic_vector(31 downto 0);
       c31_out: out std_logic;
       c32_out: out std_logic
       );
end add_32bit;

architecture structural of add_32bit is

component add_8bit 
     port (
     add8_in0: in std_logic_vector(7 downto 0);
     add8_in1: in std_logic_vector(7 downto 0);
     c_in: in std_logic;
     add8_out: out std_logic_vector(7 downto 0);
     c7_out: out std_logic;
     c8_out: out std_logic
     );
end component add_8bit;

signal temp: std_logic_vector(2 downto 0);

begin
u0: add_8bit port map (
        add8_in0 => add32_in0(7 downto 0),
        add8_in1 => add32_in1(7 downto 0),
        c_in => c_in,
        add8_out => add32_out(7 downto 0),
        c8_out => temp(0)
        );

u1: add_8bit port map (
        add8_in0 => add32_in0(15 downto 8),
        add8_in1 => add32_in1(15 downto 8),
        c_in => temp(0),
        add8_out => add32_out(15 downto 8),
        c8_out => temp(1)
        );

u2: add_8bit port map (
        add8_in0 => add32_in0(23 downto 16),
        add8_in1 => add32_in1(23 downto 16),
        c_in => temp(1),
        add8_out => add32_out(23 downto 16),
        c8_out => temp(2)
        );

u3: add_8bit port map (
        add8_in0 => add32_in0(31 downto 24),
        add8_in1 => add32_in1(31 downto 24),
        c_in => temp(2),
        add8_out => add32_out(31 downto 24),
        c7_out => c31_out,
        c8_out => c32_out
        );

end structural;  




    
