library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.mux_n;

entity mux_32to1 is
  port (
	sel   : in  std_logic_vector(4 downto 0);
	src  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic
  );
end mux_32to1;

architecture structural of mux_32to1 is
signal B:std_logic_vector(15 downto 0);
signal s1:std_logic_vector(15 downto 0);
signal s2:std_logic_vector(7 downto 0);
signal s3:std_logic_vector(7 downto 0);
signal s4:std_logic_vector(3 downto 0);
signal s5:std_logic_vector(3 downto 0);
signal s6:std_logic_vector(1 downto 0);
signal s7:std_logic_vector(1 downto 0);
	component mux is
		port (
			sel	  : in	std_logic;
			src0  :	in	std_logic;
			src1  :	in	std_logic;
			z	  : out std_logic
		     );
	end component;
begin
B (15 downto 0) <= src(31 downto 16);
G1: For I in 0 to 15 generate
	 mux_map0: mux port map (
	 		 	sel => sel(4),
	  			src0 => src(I),
				src1 => B(I),
	  			z => s1(I)
				);
end generate G1;
s2 (7 downto 0) <= s1(15 downto 8);
G2: For I in 0 to 7 generate
	 mux_map1: mux port map (
	 		 	sel => sel(3),
	  			src0 => s1(I),
				src1 => s2(I),
	  			z => s3(I)
				);
end generate G2;
s4 (3 downto 0) <= s3(7 downto 4);
G3: For I in 0 to 3 generate
	 mux_map2: mux port map (
	 		 	sel => sel(2),
	  			src0 => s3(I),
				src1 => s4(I),
	  			z => s5(I)
				);
end generate G3;
s6 (1 downto 0) <= s5(3 downto 2);
G4: For I in 0 to 1 generate
	 mux_map3: mux port map (
	 		 	sel => sel(1),
	  			src0 => s5(I),
				src1 => s6(I),
	  			z => s7(I)
				);
end generate G4;
	 mux_map4: mux port map (
	 		 	sel => sel(0),
	  			src0 => s7(0),
				src1 => s7(1),
	  			z => z
				);
	
end architecture structural;
