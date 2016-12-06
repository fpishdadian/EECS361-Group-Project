library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity full_adder_32bit is
  port (
    x     : in std_logic_vector(31 downto 0);
    y     : in std_logic_vector(31 downto 0);
    cin   : in std_logic;
    z     : out std_logic_vector(31 downto 0);
    cout  : out std_logic;
    ovf  : out std_logic
  );
end full_adder_32bit;
architecture structural of full_adder_32bit is
signal t:std_logic_vector(31 downto 1);--:= (others =>'0');
signal t_out: std_logic;
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
	FA0 : full_adder_1bit port map (
					x => x(0), 
					y => y(0), 
					c => cin, 
					z=>z(0),
					cout=>t(1)
					);
	FA1 : full_adder_1bit port map (
					x => x(1),
				        y => y(1),
					c => t(1), 
					z=>z(1),
					cout=>t(2)
					);
	FA2 : full_adder_1bit port map (
					x => x(2), 
					y => y(2), 
					c => t(2), 
					z=>z(2),
					cout=>t(3)
					);
	FA3 : full_adder_1bit port map (
					x => x(3), 
					y => y(3), 
					c => t(3), 
					z=>z(3),
					cout=>t(4)
					);
	FA4 : full_adder_1bit port map (
					x => x(4), 
					y => y(4), 
					c => t(4),
					z=>z(4),
					cout=>t(5)
					);
	FA5 : full_adder_1bit port map (
					x => x(5),
					y => y(5), 
					c => t(5), 
					z=>z(5),
					cout=>t(6)
					);
	S6 : full_adder_1bit port map (
					x => x(6), 
					y => y(6), 
					c => t(6), 
					z=>z(6),
					cout=>t(7)
					);
	FA7 : full_adder_1bit port map (
					x => x(7), 
					y => y(7), 
					c => t(7), 
					z=>z(7),
					cout=>t(8)
					);
	FA8 : full_adder_1bit port map (
					x => x(8), 
					y => y(8), 
					c => t(8), 
					z=>z(8),
					cout=>t(9)
					);
	FA9 : full_adder_1bit port map (
					x => x(9), 
					y => y(9), 
					c => t(9), 
					z=>z(9),
					cout=>t(10)
					);
	FA10 : full_adder_1bit port map (
					x => x(10), 
					y => y(10), 
					c => t(10), 
					z=>z(10),
					cout=>t(11)
					);
	FA11 : full_adder_1bit port map (
					x => x(11), 
					y => y(11),
					c => t(11),
					z=>z(11),
					cout=>t(12)
					);
	FA12 : full_adder_1bit port map (
					x => x(12), 
					y => y(12), 
					c => t(12), 
					z=>z(12),
					cout=>t(13)
					);
	FA13 : full_adder_1bit port map (
					x => x(13), 
					y => y(13), 
					c => t(13), 
					z=>z(13),
					cout=>t(14)
					);
	FA14 : full_adder_1bit port map (
					x => x(14), 
					y => y(14), 
					c => t(14), 
					z=>z(14),
					cout=>t(15)
					);
	FA15 : full_adder_1bit port map (
					x => x(15),
					y => y(15), 
					c => t(15), 
					z=>z(15),
					cout=>t(16)
					);
	FA16 : full_adder_1bit port map (
					x => x(16),
					y => y(16), 
					c => t(16), 
					z=>z(16),
					cout=>t(17)
					);
	FA17 : full_adder_1bit port map (
					x => x(17), 
					y => y(17), 
					c => t(17), 
					z=>z(17),
					cout=>t(18)
					);
	FA18 : full_adder_1bit port map (
					x => x(18),
					y => y(18),
					c => t(18), 
					z=>z(18),
					cout=>t(19)
					);
	FA19 : full_adder_1bit port map (
					x => x(19), 
					y => y(19), 
					c => t(19), 
					z=>z(19),
					cout=>t(20)
					);
	FA20 : full_adder_1bit port map (
					x => x(20), 
					y => y(20), 
					c => t(20), 
					z=>z(20),
					cout=>t(21)
					);
	FA21 : full_adder_1bit port map (
					x => x(21), 
					y => y(21), 
					c => t(21), 
					z=>z(21),
					cout=>t(22)
					);
	FA22 : full_adder_1bit port map (
					x => x(22), 
					y => y(22), 
					c => t(22), 
					z=>z(22),
					cout=>t(23)
					);
	FA23 : full_adder_1bit port map (
					x => x(23), 
					y => y(23), 
					c => t(23), 
					z=>z(23),
					cout=>t(24)
					);
	FA24 : full_adder_1bit port map (
					x => x(24), 
					y => y(24),
					c => t(24), 
					z=>z(24),
					cout=>t(25)
					);
	FA25 : full_adder_1bit port map (
					x => x(25), 
					y => y(25), 
					c => t(25), 
					z=>z(25),
					cout=>t(26)
					);
	FA26 : full_adder_1bit port map (
					x => x(26), 
					y => y(26), 
					c => t(26), 
					z=>z(26),
					cout=>t(27)
					);
	FA27 : full_adder_1bit port map (
					x => x(27), 
					y => y(27), 
					c => t(27), 
					z=>z(27),
					cout=>t(28)
					);
	FA28 : full_adder_1bit port map (
					x => x(28), 
					y => y(28), 
					c => t(28), 
					z=>z(28),
					cout=>t(29)
					);
	FA29 : full_adder_1bit port map (
					x => x(29), 
					y => y(29), 
					c => t(29), 
					z=>z(29),
					cout=>t(30)
					);
	FA30 : full_adder_1bit port map (
					x => x(30), 
					y => y(30), 
					c => t(30), 
					z=>z(30),
					cout=>t(31)
					);
	FA31 : full_adder_1bit port map (
					x => x(31), 
					y => y(31), 
					c => t(31), 
					z=>z(31),
					cout=>t_out
					);
	xor32_map : xor_gate port map (
					x => t(31), 
					y => t_out, 
					z => ovf
					);
cout <= t_out;
end architecture structural;
