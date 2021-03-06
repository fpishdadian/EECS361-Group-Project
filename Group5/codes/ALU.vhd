-- This script implements the ALU
-- Operations: 
-- Arithmetic: add, addu, sub, subu
-- Logic: and, or, sll
-- Conditional: slt, sltu

library ieee;
use ieee.std_logic_1164.all;
use work.add_32bit;
use work.eecs361_gates.all;

entity ALU is
     port (
     A: in std_logic_vector(31 downto 0);
     B: in std_logic_vector(31 downto 0);
     m: in std_logic_vector(3 downto 0);
     Result: out std_logic_vector(31 downto 0);
     c_out: out std_logic;
     ovf: out std_logic;
     zero_out: out std_logic
     );
end ALU;

architecture structural of ALU is

component Arithmetic_Unit
     port(
       arith_in0: in std_logic_vector(31 downto 0);
       arith_in1: in std_logic_vector(31 downto 0);
       op_code: in std_logic_vector(1 downto 0); 
       arith_out: out std_logic_vector(31 downto 0);
       c_out: out std_logic;
       ovf: out std_logic;
       zero_out: out std_logic
       );
end component Arithmetic_Unit;

component Logic_Unit
     port(
    log_in0: in std_logic_vector(31 downto 0);
    log_in1: in std_logic_vector(31 downto 0);
    op_code: in std_logic_vector(1 downto 0);
    log_out: out std_logic_vector(31 downto 0)
    );
end component Logic_Unit;

component Cond_Imm_Unit
     port (
       cond_imm_in0: in std_logic_vector(31 downto 0);
       cond_imm_in1: in std_logic_vector(31 downto 0);
       op_code: in std_logic_vector(1 downto 0);
       cond_imm_out: out std_logic_vector(31 downto 0)
       );
end component Cond_Imm_Unit;

component mux_32_3to1
    port (
     sel: in std_logic_vector(1 downto 0);
     src00: in std_logic_vector(31 downto 0);
     src01: in std_logic_vector(31 downto 0);
     src10: in std_logic_vector(31 downto 0);
     z: out std_logic_vector(31 downto 0)
     );
end component mux_32_3to1;

signal temp0,temp1,temp2: std_logic_vector(31 downto 0);

begin

u0: Arithmetic_Unit port map(
      arith_in0 => A,
      arith_in1 => B,
      op_code => m(1 downto 0),
      arith_out => temp0,
      c_out => c_out,
      ovf => ovf,
      zero_out => zero_out
      );

u1: Logic_Unit port map(
      log_in0 => A,
      log_in1 => B,
      op_code => m(1 downto 0),
      log_out => temp1
      );

u2: Cond_Imm_Unit port map(
     cond_imm_in0 => A,
     cond_imm_in1 => B,
     op_code => m(1 downto 0),
     cond_imm_out => temp2
     );

u3: mux_32_3to1 port map(
     sel => m(3 downto 2),
     src00 => temp0,
     src01 => temp1,
     src10 => temp2,
     z => Result
     );

end structural;

