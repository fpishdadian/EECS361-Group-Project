-- This gate receives 32 bits and nor's them

library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity nor_32_to_1 is
       port (
       main_in: in std_logic_vector(31 downto 0);
       main_out: out std_logic
       );
end nor_32_to_1;


architecture structural of nor_32_to_1 is

component or_gate_16
       port (
       x   : in  std_logic_vector(15 downto 0);
       y   : in  std_logic_vector(15 downto 0);
       z   : out std_logic_vector(15 downto 0)
       );
end component or_gate_16;

component or_gate_8
       port (
       x   : in  std_logic_vector(7 downto 0);
       y   : in  std_logic_vector(7 downto 0);
       z   : out std_logic_vector(7 downto 0)
       );
end component or_gate_8;

component or_gate_4
       port (
       x   : in  std_logic_vector(3 downto 0);
       y   : in  std_logic_vector(3 downto 0);
       z   : out std_logic_vector(3 downto 0)
       );
end component or_gate_4;

component or_gate_2
       port (
       x   : in  std_logic_vector(1 downto 0);
       y   : in  std_logic_vector(1 downto 0);
       z   : out std_logic_vector(1 downto 0)
       );
end component or_gate_2;

component nor_gate
    port (
      x : in std_logic;
      y : in std_logic;
      z : out std_logic
    );
end component nor_gate;

signal temp0: std_logic_vector(15 downto 0);
signal temp1: std_logic_vector(7 downto 0);
signal temp2: std_logic_vector(3 downto 0);
signal temp3: std_logic_vector(1 downto 0);

begin
u1: or_gate_16 port map(
    x => main_in(15 downto 0),
    y => main_in(31 downto 16),
    z => temp0
    );

u2: or_gate_8 port map(
    x => temp0(7 downto 0),
    y => temp0(15 downto 8),
    z => temp1
    );

u3: or_gate_4 port map(
    x => temp1(3 downto 0),
    y => temp1(7 downto 4),
    z => temp2
    );

u4: or_gate_2 port map(
    x => temp2(1 downto 0),
    y => temp2(3 downto 2),
    z => temp3
    );

u5: nor_gate port map(
    x => temp3(0),
    y => temp3(1),
    z => main_out
    );


end structural;
