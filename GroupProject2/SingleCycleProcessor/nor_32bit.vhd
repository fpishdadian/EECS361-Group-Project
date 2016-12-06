library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity nor_32bit is
  port (
	or_in  : in  std_logic_vector(31 downto 0);
	nor_out	    : out std_logic
  );
end nor_32bit;

architecture structural of nor_32bit is
signal s:std_logic_vector(31 downto 0);
	component or_1bit is
		port (
			x : in std_logic;
			y : in std_logic;
			z : out std_logic
			);
	end component;
begin
	or0_map : or_gate port map (x => or_in(0), y => or_in(1), z => s(0));
	or1_map : or_gate port map (x => or_in(2), y => or_in(3), z => s(1));
	or2_map : or_gate port map (x => or_in(4), y => or_in(5), z => s(2));
	or3_map : or_gate port map (x => or_in(6), y => or_in(7), z => s(3));
	or4_map : or_gate port map (x => or_in(8), y => or_in(9), z => s(4));
	or5_map : or_gate port map (x => or_in(10), y => or_in(11), z => s(5));
	or6_map : or_gate port map (x => or_in(12), y => or_in(13), z => s(6));
	or7_map : or_gate port map (x => or_in(14), y => or_in(15), z => s(7));
	or8_map : or_gate port map (x => or_in(16), y => or_in(17), z => s(8));
	or9_map : or_gate port map (x => or_in(18), y => or_in(19), z => s(9));
	or10_map : or_gate port map (x => or_in(20), y => or_in(21), z => s(10));
	or11_map : or_gate port map (x => or_in(22), y => or_in(23), z => s(11));
	or12_map : or_gate port map (x => or_in(24), y => or_in(25), z => s(12));
	or13_map : or_gate port map (x => or_in(26), y => or_in(27), z => s(13));
	or14_map : or_gate port map (x => or_in(28), y => or_in(29), z => s(14));
	or15_map : or_gate port map (x => or_in(30), y => or_in(31), z => s(15));
	or16_map : or_gate port map (x => s(0), y => s(1), z => s(16));
	or17_map : or_gate port map (x => s(2), y => s(3), z => s(17));
	or18_map : or_gate port map (x => s(4), y => s(5), z => s(18));
	or19_map : or_gate port map (x => s(6), y => s(7), z => s(19));
	or20_map : or_gate port map (x => s(8), y => s(9), z => s(20));
	or21_map : or_gate port map (x => s(10), y => s(11), z => s(21));
	or22_map : or_gate port map (x => s(12), y => s(13), z => s(22));
	or23_map : or_gate port map (x => s(14), y => s(15), z => s(23));
	or24_map : or_gate port map (x => s(16), y => s(17), z => s(24));
	or25_map : or_gate port map (x => s(18), y => s(19), z => s(25));
	or26_map : or_gate port map (x => s(20), y => s(21), z => s(26));
	or27_map : or_gate port map (x => s(22), y => s(23), z => s(27));
	or28_map : or_gate port map (x => s(24), y => s(25), z => s(28));
	or29_map : or_gate port map (x => s(26), y => s(27), z => s(29));
	or30_map : or_gate port map (x => s(28), y => s(29), z => s(30));
	xor0_map : xor_gate port map (x => s(30), y => '1', z => nor_out);
end architecture structural;
