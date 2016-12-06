library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity SUB_32bit is
  port (
    x     : in std_logic_vector(31 downto 0);
    y     : in std_logic_vector(31 downto 0);
    cin   : in std_logic;
    z     : out std_logic_vector(31 downto 0);
    borrow  : out std_logic;
    ovf  : out std_logic
  );
end SUB_32bit;
architecture structural of SUB_32bit is
signal noty:std_logic_vector(31 downto 0);
signal t:std_logic_vector(31 downto 0);
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
xor0_map : xor_gate port map (
				x => '1', 
				y => y(0), 
				z => noty(0)
				);	
SUB0 : full_adder_1bit port map (
				x => x(0), 
				y => noty(0), 
				c => '1', 
				z=>z(0),
				cout=>t(0)
				);
G1: For I in 1 to 31 generate
	xor0_map : xor_gate port map (
					x => '1', 
					y => y(I), 
					z => noty(I)
					);	
	SUB0 : full_adder_1bit port map (
					x => x(I), 
					y => noty(I), 
					c => t(I-1), 
					z=>z(I),
					cout=>t(I)
					);
end generate G1;
	xor32_map : xor_gate port map (
					x => '1', 
					y => t(31), 
					z => borrow
					);
	xor33_map : xor_gate port map (
					x => t(31), 
					y => t(30), 
					z => ovf
					);
end architecture structural;
