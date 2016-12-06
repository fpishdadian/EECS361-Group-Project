library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use ieee.numeric_std.all; 
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
entity sll_1bit is
port (
  	x     : in std_logic_vector(31 downto 0);
   	y     : in std_logic_vector(31 downto 0);
   	cin   : in std_logic;
     	z     : out std_logic_vector(31 downto 0);
    	cout  : out std_logic
);
end sll_1bit;
architecture structural of sll_1bit is
signal xin : std_logic_vector(31 downto 0);
signal int0 : integer range 0 to 31:=0;
signal t : std_logic_vector(31 downto 0);
	component full_adder_1bit is
		port (
			x : in std_logic;
			y : in std_logic;
			c : in std_logic;
			z : out std_logic;
			cout : out std_logic
		     );
        end component;
begin
int0 <= CONV_INTEGER(y);  
xin <= "00000000000000000000000000000000";
GEN_REG_1: For I in 0 to 3 generate 
	G3: IF ( I = 0 ) generate
	FA0 : full_adder_1bit port map (
					x => xin(0), 
					y => xin(0), 
					c => '0', 
					z=>z(I),
					cout=>cout
					);
	end generate G3;
	G4: IF ( I /= 0 ) generate
	FA0 : full_adder_1bit port map (
					x => xin(0), 
					y => xin(0), 
					c => '0', 
					z=>z(I),
					cout=>cout
					);
	end generate G4;
end generate GEN_REG_1;
GEN_REG_2: For I in 4 to 31 generate 
	FA1 : full_adder_1bit port map (
					x => x(I-4), 
					y => xin(0), 
					c => '0', 
					z=>z(I),
					cout=>cout
					);
end generate GEN_REG_2;
end architecture structural;
