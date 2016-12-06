library ieee;
use ieee.std_logic_1164.all;

entity ALU is
  port (
	ctrl   : in  std_logic_vector(2 downto 0);
	A  : in  std_logic_vector(31 downto 0);
	B  : in  std_logic_vector(31 downto 0);
	shamt: in  std_logic_vector(4 downto 0);
	cout : out std_logic; -- '1' for carry out
	ovf : out std_logic; -- '1' for overflow
	ze : out std_logic; -- '1' is zero
	R  : out  std_logic_vector(31 downto 0)
  );
end ALU;
architecture structural of ALU is
signal fa_z:std_logic_vector(31 downto 0);
signal fa_uz:std_logic_vector(31 downto 0);
signal fa_cout:std_logic;
signal fa_ucout:std_logic;
signal fa_ovf:std_logic;
signal fa_uovf:std_logic;
signal sub_z:std_logic_vector(31 downto 0);
signal sub_borrow:std_logic;
signal sub_ovf:std_logic;
signal and_z:std_logic_vector(31 downto 0);
signal or_z:std_logic_vector(31 downto 0);
signal temp:std_logic_vector(31 downto 0);
signal temp_cout:std_logic;
signal fa_ze:std_logic;
signal fa_uze:std_logic;
signal sub_ze:std_logic;
signal and_ze:std_logic;
signal or_ze:std_logic;
signal temp_ze:std_logic;
signal slt_R:std_logic_vector(31 downto 0);
signal slt_ovf:std_logic;
signal slt_ze:std_logic;
signal slt_signed_R:std_logic_vector(31 downto 0);
signal slt_signed_ovf:std_logic;
signal slt_signed_ze:std_logic;
signal sll_R:std_logic_vector(31 downto 0);
signal sll_ze:std_logic;
signal shiftL: std_logic_vector(31 downto 0);

	component full_adder_32bit is
		  port (
    			 x     : in std_logic_vector(31 downto 0);
  			 y     : in std_logic_vector(31 downto 0);
   			 cin   : in std_logic;
   			 z     : out std_logic_vector(31 downto 0);
   			 cout  : out std_logic;
			 ovf  : out std_logic
  			);
	end component;
	component SUB_32bit is
  		port (
    			x     : in std_logic_vector(31 downto 0);
   			y     : in std_logic_vector(31 downto 0);
    			cin   : in std_logic;
    			z     : out std_logic_vector(31 downto 0);
    			borrow  : out std_logic;
			ovf  : out std_logic
  			);
	end component;
	component or_32bit is
  		port (
   			 x   : in  std_logic_vector(31 downto 0);
    			 y   : in  std_logic_vector(31 downto 0);
   			 z   : out std_logic_vector(31 downto 0)
  			);
	end component;
	component and_32bit is
  		port (
   			 x   : in  std_logic_vector(31 downto 0);
    			 y   : in  std_logic_vector(31 downto 0);
   			 z   : out std_logic_vector(31 downto 0)
 		    );
	end component;
	component SLT is
  		port (
			A  : in  std_logic_vector(31 downto 0);
			B  : in  std_logic_vector(31 downto 0);
			ovf : out std_logic; -- '1' for overflow
			R  : out  std_logic_vector(31 downto 0)
 			 );
	end component;
	component SLT_signed is
  		port (
			A  : in  std_logic_vector(31 downto 0);
			B  : in  std_logic_vector(31 downto 0);
			ovf : out std_logic; -- '1' for overflow
			R  : out  std_logic_vector(31 downto 0)
 			 );
	end component;
	component sll_32bit is
  		port (
  			x     : in std_logic_vector(31 downto 0);
   			shift     : in std_logic_vector(31 downto 0);
     			z     : out std_logic_vector(31 downto 0)
			);
	end component;
	component mux8_1_32bit is
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

	end component mux8_1_32bit;
	component mux8_1_1bit is
  		port (
			sel   : in  std_logic_vector(2 downto 0);
			src_in0  : in  std_logic;
			src_in1  : in  std_logic;
			src_in2  : in  std_logic;
			src_in3  : in  std_logic;
			src_in4  : in  std_logic;
			src_in5  : in  std_logic;
			src_in6  : in  std_logic;
			src_in7  : in  std_logic;
			z	: out std_logic
  		);
	end component mux8_1_1bit;
	component nor_32bit is
  		port (
			or_in  : in  std_logic_vector(31 downto 0);
			nor_out	    : out std_logic
  		);
	end component nor_32bit;

begin
temp <= "00000000000000000000000000111010";
temp_ze <= '0';
temp_cout <= '0';
shiftL (4 downto 0) <=shamt;
shiftL (31 downto 5)<="000000000000000000000000000";
FA : full_adder_32bit port map (
					x => A, 
					y => B, 
					cin => '0', 
					z => fa_z,
					cout => fa_cout,
					ovf =>fa_ovf
					);
nor_map0 : nor_32bit port map (
					or_in => fa_z,
					nor_out =>fa_ze
				);
FA_u : full_adder_32bit port map (
					x => A, 
					y => B, 
					cin => '0', 
					z => fa_uz,
					cout => fa_ucout,
					ovf =>fa_uovf
					);
nor_umap0 : nor_32bit port map (
					or_in => fa_uz,
					nor_out =>fa_uze
				);
SUB : SUB_32bit port map (
					x => A, 
					y => B, 
					cin => '1', 
					z => sub_z,
					borrow => sub_borrow,
					ovf => sub_ovf
					);
nor_map1 : nor_32bit port map (
					or_in => sub_z,
					nor_out =>sub_ze
				);
and0 : and_32bit port map (
					x => A, 
					y => B, 
					z => and_z
					);
nor_map2 : nor_32bit port map (
					or_in => and_z,
					nor_out =>and_ze
				);
or0 : or_32bit port map (
					x => A, 
					y => B, 
					z => or_z
					);
nor_map3 : nor_32bit port map (
					or_in => or_z,
					nor_out =>or_ze
				);
slt_map : SLT port map (
					A => A,
					B =>B,
					ovf => slt_ovf,
					R => slt_R
				);
slt_signed_map : SLT_signed port map (
					A => A,
					B =>B,
					ovf => slt_signed_ovf,
					R => slt_signed_R
				);
sll_map : sll_32bit port map (
					x => A,
					shift =>shiftL,
					z => sll_R
				);
nor_map4 : nor_32bit port map (
					or_in => sll_R,
					nor_out =>sll_ze
				);
nor_map5 : nor_32bit port map (
					or_in => slt_R,
					nor_out =>slt_ze
				);
nor_map6 : nor_32bit port map (
					or_in => slt_signed_R,
					nor_out =>slt_signed_ze
				);

mux_map32 : mux8_1_32bit port map (
					sel => ctrl,
					src_in0 => and_z ,
					src_in1 => or_z ,
					src_in2 => fa_z ,
					src_in3 => slt_signed_R ,
					src_in4 => fa_uz ,
					src_in5 => sll_R ,
					src_in6 => sub_z ,
					src_in7 => slt_R ,
					z =>R
					);
mux_map_cout : mux8_1_1bit port map (
					sel => ctrl,
					src_in0 => '0' ,
					src_in1 => '0' ,
					src_in2 => fa_cout ,
					src_in3 => '0' ,
					src_in4 => fa_ucout ,
					src_in5 => '0' ,
					src_in6 => sub_borrow ,
					src_in7 => temp_cout ,
					z =>cout
					);
mux_map_ze : mux8_1_1bit port map (
					sel => ctrl,
					src_in0 => and_ze ,
					src_in1 => or_ze ,
					src_in2 => fa_ze ,
					src_in3 => slt_signed_ze ,
					src_in4 => fa_uze ,
					src_in5 => sll_ze ,
					src_in6 => sub_ze ,
					src_in7 => slt_ze ,
					z =>ze
					);
mux_map_ovf : mux8_1_1bit port map (
					sel => ctrl,
					src_in0 => '0' ,
					src_in1 => '0' ,
					src_in2 => fa_ovf ,
					src_in3 => slt_signed_ovf,
					src_in4 => fa_uovf ,
					src_in5 => '0',
					src_in6 => sub_ovf ,
					src_in7 => slt_ovf ,
					z =>ovf
					);
end architecture structural;
