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

component Logic_32bit
     port(
    log_in0: in std_logic_vector(31 downto 0);
    log_in1: in std_logic_vector(31 downto 0);
    op_code: in std_logic_vector(1 downto 0);
    log_out: out std_logic_vector(31 downto 0)
    );
end component Logic_32bit;

component Shift_32bit
     port (
       sh_in0: in std_logic_vector(31 downto 0);
       sh_in1: in std_logic_vector(31 downto 0);
       op_code: in std_logic;
       sh_out: out std_logic_vector(31 downto 0)
       );
end component Shift_32bit;

component Conditional_32bit
     port (
       cond_in0: in std_logic_vector(31 downto 0);
       cond_in1: in std_logic_vector(31 downto 0);
       op_code: in std_logic;
       cond_out: out std_logic_vector(31 downto 0)
       );
end component Conditional_32bit;

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

u0: Arithmetic_32bit port map(
      arith_in0 => A,
      arith_in1 => B,
      op_code => m(0),
      arith_out => temp0,
      c_out => c_out,
      ovf => ovf,
      zero_out => zero_out
      );

u1: Logic_32bit port map(
      log_in0 => A,
      log_in1 => B,
      op_code => m(1 downto 0),
      log_out => temp1
      );

u2: Shift_32bit port map(
      sh_in0 => A,
      sh_in1 => B,
      op_code => m(0),
      sh_out => temp2
      );

u3: Conditional_32bit port map(
     cond_in0 => A,
     cond_in1 => B,
     op_code => m(0),
     cond_out => temp3
     );

u4: mux_32_4to1 port map(
     sel => m(3 downto 2),
     src00 => temp0,
     src01 => temp1,
     src10 => temp2,
     src11 => temp3,
     z => Result
     );

end structural;
     