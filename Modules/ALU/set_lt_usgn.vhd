library ieee;
use ieee.std_logic_1164.all;

entity set_lt_usgn is
       port (
       sltu_in0: in std_logic_vector(31 downto 0);
       sltu_in1: in std_logic_vector(31 downto 0);
       sltu_out: out std_logic_vector(31 downto 0)
       );
end set_lt_usgn;

architecture structural of set_lt_usgn is

component Arithmetic_32bit
        port(
       arith_in0: in std_logic_vector(31 downto 0);
       arith_in1: in std_logic_vector(31 downto 0);
       op_code: in std_logic; 
       arith_out: out std_logic_vector(31 downto 0);
       c_out: out std_logic;
       ovf: out std_logic;
       zero_out: out std_logic
       );
end component Arithmetic_32bit;

component not_gate
         port (
         x: in  std_logic;
         z : out std_logic
         );
end component not_gate;

signal temp0,temp1: std_logic;
signal temp2: std_logic_vector(31 downto 0);

begin
u0: Arithmetic_32bit port map (
    arith_in0 => sltu_in0,
    arith_in1 => sltu_in1,
    op_code => '1',
    c_out => temp0
    );

u1: not_gate port map (
    x => temp0,
    z => temp1
    );

temp2 <= (0 => temp1, others=> '0');
sltu_out <= temp2;

end structural;


