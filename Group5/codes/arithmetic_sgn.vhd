-- This script implements a signed arithmetic unit
-- Operations: add, sub


library ieee;
use ieee.std_logic_1164.all;
use work.add_32bit;
use work.eecs361_gates.all;
use work.eecs361.mux;

entity arithmetic_sgn is
       port(
       arith_in0: in std_logic_vector(31 downto 0);
       arith_in1: in std_logic_vector(31 downto 0);
       op_code: in std_logic; 
       arith_out: out std_logic_vector(31 downto 0);
       c_out: out std_logic;
       ovf: out std_logic;
       zero_out: out std_logic
       );
end arithmetic_sgn;

architecture structural of arithmetic_sgn is

component not_gate_32
     port (
    x: in  std_logic_vector(31 downto 0);
    z: out std_logic_vector(31 downto 0)
    );
end component not_gate_32;

component xor_gate
    port (
      x : in std_logic;
      y : in std_logic;
      z : out std_logic
    );
end component xor_gate;

component nor_32_to_1
    port (
     main_in: in std_logic_vector(31 downto 0);
     main_out: out std_logic
     );
end component nor_32_to_1;

component mux_32
    port (
	sel: in  std_logic;
	src0: in  std_logic_vector(31 downto 0);
	src1: in  std_logic_vector(31 downto 0);
	z: out std_logic_vector(31 downto 0)
        );
end component mux_32;

component add_32bit
      port(
       add32_in0: in std_logic_vector(31 downto 0);
       add32_in1: in std_logic_vector(31 downto 0);
       c_in: in std_logic;
       add32_out: out std_logic_vector(31 downto 0);
       c31_out: out std_logic;
       c32_out: out std_logic
       );
end component add_32bit;

signal temp0,temp1,temp2: std_logic_vector(31 downto 0);
signal cout0,cout1: std_logic;


begin
u0: not_gate_32 port map (
    x => arith_in1,
    z => temp0
    );

u1: mux_32 port map (
    sel => op_code,
    src0 => arith_in1,
    src1 => temp0,
    z => temp1
    );

u2: add_32bit port map (
    add32_in0 => arith_in0,
    add32_in1 => temp1,
    c_in => op_code,
    add32_out => arith_out,
    c31_out => cout0,
    c32_out => c_out
    );

u3: add_32bit port map (
    add32_in0 => arith_in0,
    add32_in1 => temp1,
    c_in => op_code,
    add32_out => temp2,
    c31_out => cout0,
    c32_out => cout1
    );

u4: xor_gate port map (
    x => cout0,
    y => cout1,
    z => ovf
   );

u5: nor_32_to_1 port map (
    main_in => temp2,
    main_out => zero_out
    );


end structural;
