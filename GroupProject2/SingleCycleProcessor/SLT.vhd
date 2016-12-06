library ieee;
use ieee.std_logic_1164.all;

entity SLT is
  port (
	A  : in  std_logic_vector(31 downto 0);
	B  : in  std_logic_vector(31 downto 0);
	ovf : out std_logic; -- '1' for overflow
	R  : out  std_logic_vector(31 downto 0)
  );
end SLT;
architecture structural of SLT is
signal sub_z:std_logic_vector(31 downto 0);
signal sub_borrow:std_logic;
signal sub_ovf:std_logic;
signal temp:std_logic_vector(31 downto 0);

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

begin
temp <= "00000000000000000000000000000000";
R(31 downto 1) <= temp (30 downto 0);

SUB : SUB_32bit port map (
				x => A, 
				y => B, 
				cin => '1', 
				z => sub_z,
				borrow => sub_borrow,
				ovf => ovf
			);
R(0) <= sub_borrow;

end architecture structural;
