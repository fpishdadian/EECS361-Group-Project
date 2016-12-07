library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity hazard_unit is
port(  Rt_ID_EX  : in std_logic_vector(4 downto 0);
       Rs_IF_ID  : in std_logic_vector(4 downto 0);
	   Rt_IF_ID  : in std_logic_vector(4 downto 0);
	   Memread_ID_EX  : in std_logic;
	   --PCsrc_MEM_WB : in std_logic;
	   --op  : in std_logic_vector(5 downto 0);
	   ctr_sel  : out std_logic;
	   PC_wrt  : out std_logic;
	   RegWrt_IF_ID  : out std_logic);
end hazard_unit;

architecture structural of hazard_unit is
-- signal op_inverse : std_logic_vector(5 downto 0);
-- signal sig_beq  : std_logic;
-- signal sig_bne  : std_logic;
-- signal sig_bgtz : std_logic;
-- signal sig_or1  : std_logic;
-- signal sig_or2  : std_logic;
-- signal sig_or3  : std_logic;
-- signal sig_branch  : std_logic;

signal sig_or  : std_logic;
signal sig_not : std_logic;
signal sig_1  : std_logic;
signal sig_2  : std_logic;
signal sig_and : std_logic;

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

component or_gate is
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

component and_gate_6to1 is
port(x : in std_logic_vector(5 downto 0);
     z :out std_logic);
end component;


begin
compar_map1: comparison_5bit port map(x => Rt_ID_EX, y => Rs_IF_ID, z =>sig_1);
compar_map2: comparison_5bit port map(x => Rt_ID_EX, y => Rt_IF_ID, z =>sig_2);
or_map: or_gate port map(x => sig_1, y => sig_2, z => sig_or);
and_map: and_gate port map(x => sig_or, y => Memread_ID_EX, z => sig_and);

-- G1: for I in 0 to 5 generate
-- not_gate_map: not_gate port map(x=>op(I),z=>op_inverse(I));
-- end generate G1;
--beq op
-- and_gate_map3: and_gate_6to1 port map(x(0)=>op_inverse(0),x(1)=>op_inverse(1),
  -- x(2)=>op(2),x(3)=>op_inverse(3),x(4)=>op_inverse(4),x(5)=>op_inverse(5),z=>sig_beq);
--bne op
-- and_gate_map4: and_gate_6to1 port map(x(0)=>op(0),x(1)=>op_inverse(1),x(2)=>op(2),
  -- x(3)=>op_inverse(3),x(4)=>op_inverse(4),x(5)=>op_inverse(5),z=>sig_bne);
--bgtz op
-- and_gate_map5: and_gate_6to1 port map(x(0)=>op(0),x(1)=>op(1),x(2)=>op(2),
  -- x(3)=>op_inverse(3),x(4)=>op_inverse(4),x(5)=>op_inverse(5),z=>sig_bgtz);
-- or_map1: or_gate port map(x => sig_bne, y => sig_beq, z => sig_or1);
-- or_map2: or_gate port map(x => sig_or1, y => sig_bgtz, z => sig_or2);
-- and_gate_map6: and_gate port map(x => sig_or2, y => PCsrc_MEM_WB, z => sig_branch);
-- or_map3: or_gate port map(x => sig_and, y => sig_branch, z => sig_or3);

not_map: not_gate port map(x => sig_and, z => sig_not);
ctr_sel <= sig_and;
PC_wrt <= sig_not;
RegWrt_IF_ID <= sig_not;
end structural;