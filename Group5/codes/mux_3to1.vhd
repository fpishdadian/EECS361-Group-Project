library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity mux_3to1 is
     port (
     sel: in std_logic_vector(1 downto 0);
     src00: in std_logic;
     src01: in std_logic;
     src11: in std_logic;
     z: out std_logic     );
end mux_3to1;

architecture structral of mux_3to1 is
signal src_sel : std_logic;

component mux
  port (
	sel	  : in	std_logic;
	src0  :	in	std_logic;
	src1  :	in	std_logic;
	z	  : out std_logic  );
end component mux;

begin
u0: mux port map (
    sel => sel(1),
    src0 => src01,
    src1 => src11,
    z => src_sel    );

u1: mux port map (
    sel => sel(0),
    src0 => src00,
    src1 => src_sel,
    z => z    );
  
end structral;



