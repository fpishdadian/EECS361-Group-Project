library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity Shift_32bit is
       port (
       sh_in0: in std_logic_vector(31 downto 0);
       sh_in1: in std_logic_vector(31 downto 0);
       op_code: in std_logic;
       sh_out: out std_logic_vector(31 downto 0)
       );
end Shift_32bit;

architecture structural of Shift_32bit is

component shift_right_32
     port (
       sh_in0: in std_logic_vector(31 downto 0);
       sh_in1: in std_logic_vector(31 downto 0);
       sh_out: out std_logic_vector(31 downto 0)
       );
end component shift_right_32;

component shift_left_32
     port (
       sh_in0: in std_logic_vector(31 downto 0);
       sh_in1: in std_logic_vector(31 downto 0);
       sh_out: out std_logic_vector(31 downto 0)
       );
end component shift_left_32;

component mux_32
    port (
      sel   : in  std_logic;
      src0  : in  std_logic_vector(31 downto 0);
      src1  : in  std_logic_vector(31 downto 0);
      z     : out std_logic_vector(31 downto 0)
    );
end component mux_32;

signal temp0,temp1: std_logic_vector(31 downto 0);

begin

u0: shift_right_32 port map(
    sh_in0 => sh_in0,
    sh_in1 => sh_in1,
    sh_out => temp0
    );

u1: shift_left_32 port map(
    sh_in0 => sh_in0,
    sh_in1 => sh_in1,
    sh_out => temp1
    );

u2: mux_32 port map(
    sel => op_code,
    src0 => temp0,
    src1 => temp1,
    z => sh_out
    );

end structural;
