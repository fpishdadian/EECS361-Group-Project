-- This script implements the arithmetic unit of the ALU
-- Operations: add, addu, sub, subu

library ieee;
use ieee.std_logic_1164.all;
use work.add_32bit;
use work.eecs361_gates.all;
use work.eecs361.mux;

entity Arithmetic_Unit is
       port(
       arith_in0: in std_logic_vector(31 downto 0);
       arith_in1: in std_logic_vector(31 downto 0);
       op_code: in std_logic_vector(1 downto 0); 
       arith_out: out std_logic_vector(31 downto 0);
       c_out: out std_logic;
       ovf: out std_logic;
       zero_out: out std_logic
       );
end Arithmetic_Unit;

architecture structural of Arithmetic_Unit is

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

component arithmetic_usgn
       port(
       arith_in0: in std_logic_vector(31 downto 0);
       arith_in1: in std_logic_vector(31 downto 0);
       op_code: in std_logic; 
       arith_out: out std_logic_vector(31 downto 0);
       c_out: out std_logic;
       ovf: out std_logic;
       zero_out: out std_logic
       );
end component arithmetic_usgn;

component mux is
  port (
	sel	  : in	std_logic;
	src0  :	in	std_logic;
	src1  :	in	std_logic;
	z	  : out std_logic
  );
end component mux;

component mux_32 is
  port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(31 downto 0);
	src1  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end component mux_32;

signal result_sgn, result_usgn: std_logic_vector(31 downto 0);
signal c_sgn,c_usgn, ovf_sgn,ovf_usgn,z_sgn,z_usgn: std_logic;


begin

u0: arithmetic_sgn port map(
    arith_in0 => arith_in0,
    arith_in1 => arith_in1,
    op_code => op_code(1),
    arith_out => result_sgn,
    c_out => c_sgn,
    ovf => ovf_sgn,
    zero_out => z_sgn
    );

u1: arithmetic_usgn port map(
    arith_in0 => arith_in0,
    arith_in1 => arith_in1,
    op_code => op_code(1),
    arith_out => result_usgn,
    c_out => c_usgn,
    ovf => ovf_usgn,
    zero_out => z_usgn
    );

-- select the computation result
u3: mux_32 port map(
    sel => op_code(0),
    src0 => result_sgn,
    src1 => result_usgn,
    z => arith_out
    );

-- select carry out
u4: mux port map(
    sel => op_code(0),
    src0 => c_sgn,
    src1 => c_usgn,
    z => c_out
    );

-- select overflow
u5: mux port map(
    sel => op_code(0),
    src0 => ovf_sgn,
    src1 => ovf_usgn,
    z => ovf
    );

-- select zero out
u6: mux port map(
    sel => op_code(0),
    src0 => z_sgn,
    src1 => z_usgn,
    z => zero_out
    );

end structural;
