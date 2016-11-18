-- This script implements the conditional unit of the ALU
-- Operations: slt, sltu

library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity Conditional_Unit is
       port (
       cond_in0: in std_logic_vector(31 downto 0);
       cond_in1: in std_logic_vector(31 downto 0);
       op_code: in std_logic;
       cond_out: out std_logic_vector(31 downto 0)
       );
end Conditional_Unit;

architecture structural of Conditional_Unit is

component set_lt_sgn
      port (
       slt_in0: in std_logic_vector(31 downto 0);
       slt_in1: in std_logic_vector(31 downto 0);
       slt_out: out std_logic_vector(31 downto 0)
       );
end component set_lt_sgn;

component set_lt_usgn
     port (
       sltu_in0: in std_logic_vector(31 downto 0);
       sltu_in1: in std_logic_vector(31 downto 0);
       sltu_out: out std_logic_vector(31 downto 0)
       );
end component set_lt_usgn;

component mux_32
    port (
      sel   : in  std_logic;
      src0  : in  std_logic_vector(31 downto 0);
      src1  : in  std_logic_vector(31 downto 0);
      z     : out std_logic_vector(31 downto 0)
    );
end component mux_32;

signal temp0,temp1: std_logic_vector(31 downto 0);

begin
u0: set_lt_sgn port map (
    slt_in0 => cond_in0,
    slt_in1 => cond_in1,
    slt_out => temp0
    );

u1: set_lt_usgn port map (
    sltu_in0 => cond_in0,
    sltu_in1 => cond_in1,
    sltu_out => temp1
    );

u3: mux_32 port map (
    sel => op_code,
    src0 => temp0,
    src1 => temp1,
    z => cond_out
    );

end structural;

