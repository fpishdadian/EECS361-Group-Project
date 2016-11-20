-- This script implements the conditional and I-type operation unit of the ALU
-- Operations: slt, sltu, I-type add/sub

library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity Cond_Imm_Unit is
       port (
       cond_imm_in0: in std_logic_vector(31 downto 0);
       cond_imm_in1: in std_logic_vector(31 downto 0);
       op_code: in std_logic_vector(1 downto 0);
       cond_imm_out: out std_logic_vector(31 downto 0)
       );
end Cond_Imm_Unit;

architecture structural of Cond_Imm_Unit is

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

component mux_32_4to1
     port (
     sel: in std_logic_vector(1 downto 0);
     src00: in std_logic_vector(31 downto 0);
     src01: in std_logic_vector(31 downto 0);
     src10: in std_logic_vector(31 downto 0);
     src11: in std_logic_vector(31 downto 0);
     z: out std_logic_vector(31 downto 0)
     );
end component mux_32_4to1;

signal temp0,temp1,temp2,temp3: std_logic_vector(31 downto 0);

begin
u0: set_lt_sgn port map (
    slt_in0 => cond_imm_in0,
    slt_in1 => cond_imm_in1,
    slt_out => temp0
    );

u1: set_lt_usgn port map (
    sltu_in0 => cond_imm_in0,
    sltu_in1 => cond_imm_in1,
    sltu_out => temp1
    );

u2: arithmetic_sgn port map(
    arith_in0 => cond_imm_in0,
    arith_in1 => cond_imm_in1,
    op_code => '0',
    arith_out =>  temp2
    );

u3: arithmetic_sgn port map(
    arith_in0 => cond_imm_in0,
    arith_in1 => cond_imm_in1,
    op_code => '1',
    arith_out =>  temp3
    );


u4: mux_32_4to1 port map (
    sel => op_code,
    src00 => temp0,
    src01 => temp1,
    src10 => temp2,
    src11 => temp3,
    z => cond_imm_out
    );


end structural;
