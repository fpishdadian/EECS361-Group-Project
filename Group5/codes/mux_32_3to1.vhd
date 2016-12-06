library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity mux_32_3to1 is
     port (
     sel: in std_logic_vector(1 downto 0);
     src00: in std_logic_vector(31 downto 0);
     src01: in std_logic_vector(31 downto 0);
     src10: in std_logic_vector(31 downto 0);
     z: out std_logic_vector(31 downto 0)
     );
end mux_32_3to1;

architecture structral of mux_32_3to1 is
    
component mux_32
    port (
	sel: in  std_logic;
	src0: in  std_logic_vector(31 downto 0);
	src1: in  std_logic_vector(31 downto 0);
	z: out std_logic_vector(31 downto 0)
        );
end component mux_32;

signal temp0, temp1: std_logic_vector(31 downto 0);

begin
u0: mux_32 port map (
    sel => sel(0),
    src0 => src00,
    src1 => src01,
    z => temp0
    );

u1: mux_32 port map (
    sel => sel(1),
    src0 => temp0,
    src1 => src10,
    z => z
    );
  
end structral;



