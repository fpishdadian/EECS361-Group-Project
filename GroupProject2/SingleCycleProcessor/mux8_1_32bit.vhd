library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.mux_n;

entity mux8_1_32bit is
  port (
	sel   : in  std_logic_vector(2 downto 0);
	src_in0  : in  std_logic_vector(31 downto 0);
	src_in1  : in  std_logic_vector(31 downto 0);
	src_in2  : in  std_logic_vector(31 downto 0);
	src_in3  : in  std_logic_vector(31 downto 0);
	src_in4  : in  std_logic_vector(31 downto 0);
	src_in5  : in  std_logic_vector(31 downto 0);
	src_in6  : in  std_logic_vector(31 downto 0);
	src_in7  : in  std_logic_vector(31 downto 0);
	z	: out std_logic_vector(31 downto 0)
  );
end mux8_1_32bit;

architecture structural of mux8_1_32bit is
signal s0:std_logic_vector(31 downto 0);
signal s1:std_logic_vector(31 downto 0);
signal s2:std_logic_vector(31 downto 0);
signal s3:std_logic_vector(31 downto 0);
signal s4:std_logic_vector(31 downto 0);
signal s5:std_logic_vector(31 downto 0);
	component mux_32 is
		 port (
			sel   : in  std_logic;
			src0  : in  std_logic_vector(31 downto 0);
			src1  : in  std_logic_vector(31 downto 0);
			z	    : out std_logic_vector(31 downto 0)
  			);
	end component;
begin
 	 mux_map0: mux_32 port map (
	 		 	sel => sel(0),
	  			src0 => src_in0,
				src1 => src_in1,
	  			z => s0
				);
 	 mux_map1: mux_32 port map (
	 		 	sel => sel(0),
	  			src0 => src_in2,
				src1 => src_in3,
	  			z => s1
				);
 	 mux_map2: mux_32 port map (
	 		 	sel => sel(0),
	  			src0 => src_in4,
				src1 => src_in5,
	  			z => s2
				);
 	 mux_map3: mux_32 port map (
	 		 	sel => sel(0),
	  			src0 => src_in6,
				src1 => src_in7,
	  			z => s3
				);
 	 mux_map4: mux_32 port map (
	 		 	sel => sel(1),
	  			src0 => s0,
				src1 => s1,
	  			z => s4
				);
 	 mux_map5: mux_32 port map (
	 		 	sel => sel(1),
	  			src0 => s2,
				src1 => s3,
	  			z => s5
				);
 	 mux_map6: mux_32 port map (
	 		 	sel => sel(2),
	  			src0 => s4,
				src1 => s5,
	  			z => z
				);
 end architecture structural;
