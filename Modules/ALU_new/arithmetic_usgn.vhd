-- This script implements an unsigned arithmetic unit
-- Operations: addu, subu


library ieee;
use ieee.std_logic_1164.all;
use work.add_32bit;
use work.eecs361_gates.all;
use work.eecs361.mux;

entity arithmetic_usgn is
       port(
       arith_in0: in std_logic_vector(31 downto 0);
       arith_in1: in std_logic_vector(31 downto 0);
       op_code: in std_logic; 
       arith_out: out std_logic_vector(31 downto 0);
       c_out: out std_logic;
       ovf: out std_logic;
       zero_out: out std_logic
       );
end arithmetic_usgn;

architecture structural of arithmetic_usgn is

component not_gate
  port (
    x   : in  std_logic;
    z   : out std_logic
  );
end component not_gate;

component not_gate_32
     port (
    x: in  std_logic_vector(31 downto 0);
    z: out std_logic_vector(31 downto 0)
    );
end component not_gate_32;

component or_gate
    port (
      x : in std_logic;
      y : in std_logic;
      z : out std_logic
    );
end component or_gate;

component and_gate
    port (
      x : in std_logic;
      y : in std_logic;
      z : out std_logic
    );
end component and_gate;

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
signal temp3, temp4, temp5: std_logic;
signal cout31,cout32: std_logic;
signal notOp,notC31,notC32: std_logic;


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
    c31_out => cout31,
    c32_out => c_out
    );

u3: add_32bit port map (
    add32_in0 => arith_in0,
    add32_in1 => temp1,
    c_in => op_code,
    add32_out => temp2,
    c31_out => cout31,
    c32_out => cout32
    );

-- raise overflow

u4: not_gate port map(
    x => op_code,
    z => notOp
    );

u5: not_gate port map(
    x => cout31,
    z => notC31
    );

u6: not_gate port map(
    x => cout32,
    z => notC32
    );

u7: and_gate port map(
    x => notOp,
    y => cout32,
    z => temp3
    );

u8: and_gate port map(
    x => op_code,
    y => notC32,
    z => temp4
    );

u9: and_gate port map(
    x => temp4,
    y => notC31,
    z => temp5
    );

u10: or_gate port map(
     x => temp3,
     y => temp5,
     z => ovf
     );

-- raise zero_out
u11: nor_32_to_1 port map (
    main_in => temp2,
    main_out => zero_out
    );


end structural;
