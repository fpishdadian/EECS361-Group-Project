library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity set_lt_sgn is
       port (
       slt_in0: in std_logic_vector(31 downto 0);
       slt_in1: in std_logic_vector(31 downto 0);
       slt_out: out std_logic_vector(31 downto 0)
       );
end set_lt_sgn;

architecture structural of set_lt_sgn is

component not_gate
     port (
    x: in  std_logic;
    z: out std_logic
    );
end component not_gate;

component and_gate
    port (
      x : in std_logic;
      y : in std_logic;
      z : out std_logic
    );
end component and_gate;

component or_gate
    port (
      x : in std_logic;
      y : in std_logic;
      z : out std_logic
    );
end component or_gate;

component arithmetic_sgn
        port(
       arith_in0: in std_logic_vector(31 downto 0);
       arith_in1: in std_logic_vector(31 downto 0);
       op_code: in std_logic; 
       arith_out: out std_logic_vector(31 downto 0);
       c_out: out std_logic;
       ovf: out std_logic;
       zero_out: out std_logic
       );
end component arithmetic_sgn;

signal A_msb, B_msb,Cout,notB,notC: std_logic;
signal temp0, temp1, temp2,temp3,temp4: std_logic;
signal tempA, tempB,temp5: std_logic_vector(31 downto 0);

begin

A_msb <= slt_in0(31);
B_msb <= slt_in1(31);

tempA <= "0" & slt_in0(30 downto 0);
tempB <= "0" & slt_in1(30 downto 0);

u0:arithmetic_sgn port map (
    arith_in0 => tempA,
    arith_in1 => tempB,
    op_code => '1',
    c_out => Cout
    );
   
u1: not_gate port map (
    x => B_msb,
    z => notB
    );

u2: not_gate port map (
    x => Cout,
    z => notC
    ); 

u3: and_gate port map (
    x => A_msb,
    y => notB,
    z => temp0
    );

u4: and_gate port map (
    x => A_msb,
    y => Cout,
    z => temp1
    );

u5: or_gate port map (
    x => temp0,
    y => temp1,
    z => temp2
    );

u6: and_gate port map (
    x => notB,
    y => notC,
    z => temp3
    );

u7: or_gate port map (
    x => temp2,
    y => temp3,
    z => temp4
    );

temp5 <= (0 => temp4, others=> '0');
slt_out <= temp5;

end structural;

