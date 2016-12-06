library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
entity SUB_1bit is
	port (
	x : in std_logic;
	y : in std_logic;
	z : out std_logic;
	borrow : out std_logic
	);
end SUB_1bit;
architecture structural of SUB_1bit is
signal noty : std_logic;
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
	xor31_map : xor_gate port map (
					x => '1', 
					y => y, 
					z => noty
					);
	FA_S : full_adder_1bit port map (
					x => x, 
					y => noty, 
					c => '1', 
					z => z,
					cout => borrow
					);
end architecture structural;
