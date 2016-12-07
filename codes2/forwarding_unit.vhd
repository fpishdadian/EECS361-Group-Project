library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity forwarding_unit is
port(  Rd_EX_MEM  : in std_logic_vector(4 downto 0);
       Rd_MEM_WB  : in std_logic_vector(4 downto 0);
	   Rt_ID_EX   : in std_logic_vector(4 downto 0);
	   Rs_ID_EX   : in std_logic_vector(4 downto 0);
	   RegWrt_EX_MEM  : in std_logic;
	   RegWrt_MEM_WB  : in std_logic;
	   sel_A  : out std_logic_vector(1 downto 0);
	   sel_B  : out std_logic_vector(1 downto 0)
	   );
end forwarding_unit;

architecture structural of forwarding_unit is
signal sig_1n  : std_logic;
signal sig_1   : std_logic;
signal sig_2   : std_logic;
signal sig_and1 : std_logic;
signal sig_3n  : std_logic;
signal sig_3   : std_logic;
signal sig_4   : std_logic;
signal sig_and2 : std_logic;
signal sig_5n  : std_logic;
signal sig_5   : std_logic;
signal sig_6n  : std_logic;
signal sig_6   : std_logic;
signal sig_7   : std_logic;
signal sig_and3 : std_logic;
signal sig_and4 : std_logic;
signal sig_8n  : std_logic;
signal sig_8   : std_logic;
signal sig_9n  : std_logic;
signal sig_9   : std_logic;
signal sig_10  : std_logic;
signal sig_and5 : std_logic;
signal sig_and6 : std_logic;

component comparison_5bit is
port(  x  : in std_logic_vector(4 downto 0);
       y  : in std_logic_vector(4 downto 0);
	   z  : out std_logic);
end component;

component and_gate is
  port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

component not_gate is
  port (
    x   : in  std_logic;
    z   : out std_logic
  );
end component;

begin
compar_map1: comparison_5bit port map(x => Rd_EX_MEM, y => "00000", z => sig_1n);
not_map1: not_gate port map(x => sig_1n, z => sig_1);
compar_map2: comparison_5bit port map(x => Rd_EX_MEM, y => Rs_ID_EX, z => sig_2);
and_map1: and_gate port map(x => sig_1, y => sig_2, z => sig_and1);
and_map2: and_gate port map(x => sig_and1, y => RegWrt_EX_MEM, z => sel_A(1));

compar_map3: comparison_5bit port map(x => Rd_EX_MEM, y => "00000", z => sig_3n);
not_map2: not_gate port map(x => sig_3n, z => sig_3);
compar_map4: comparison_5bit port map(x => Rd_EX_MEM, y => Rt_ID_EX, z => sig_4);
and_map3: and_gate port map(x => sig_3, y => sig_4, z => sig_and2);
and_map4: and_gate port map(x => sig_and2, y => RegWrt_EX_MEM, z => sel_B(1));

compar_map5: comparison_5bit port map(x => Rd_MEM_WB, y => "00000", z => sig_5n);
not_map3: not_gate port map(x => sig_5n, z => sig_5);
compar_map6: comparison_5bit port map(x => Rd_EX_MEM, y => Rs_ID_EX, z => sig_6n);
not_map4: not_gate port map(x => sig_6n, z => sig_6);
compar_map7: comparison_5bit port map(x => Rd_MEM_WB, y => Rs_ID_EX, z=> sig_7);
and_map5: and_gate port map(x => sig_5, y => sig_6, z => sig_and3);
and_map6: and_gate port map(x => RegWrt_MEM_WB, y => sig_7, z => sig_and4);
and_map7: and_gate port map(x => sig_and3, y => sig_and4, z => sel_A(0));

compar_map8: comparison_5bit port map(x => Rd_MEM_WB, y => "00000", z => sig_8n);
not_map5: not_gate port map(x => sig_8n, z => sig_8);
compar_map9: comparison_5bit port map(x => Rd_EX_MEM, y => Rt_ID_EX, z => sig_9n);
not_map6: not_gate port map(x => sig_9n, z => sig_9);
compar_map10: comparison_5bit port map(x => Rd_MEM_WB, y => Rt_ID_EX, z => sig_10);
and_map8: and_gate port map(x => sig_8, y => sig_9, z => sig_and5);
and_map9: and_gate port map(x => RegWrt_MEM_WB, y => sig_10, z => sig_and6);
and_map10: and_gate port map(x => sig_and5, y => sig_and6, z => sel_B(0));

end structural;