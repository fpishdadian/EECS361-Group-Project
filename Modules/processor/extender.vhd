--Extender

library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity extender is
  port ( imm     : in std_logic_vector(15 downto 0);
         ExtOp   : in std_logic;
		 result  : out std_logic_vector(31 downto 0)
		 );
end extender;

architecture structural of extender is
signal result_zero    : std_logic_vector(31 downto 0);
signal result_sign_p  : std_logic_vector(31 downto 0);
signal result_sign_n  : std_logic_vector(31 downto 0);
signal result_sign    : std_logic_vector(31 downto 0);

  
  component mux_32
  port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(31 downto 0);
	src1  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end component mux_32;
  
  begin
  zero_extend0 : result_zero(31 downto 16) <= "0000000000000000";
  zero_extend1 : result_zero(15 downto 0) <= imm(15 downto 0);
  
  sign_extend_n0 : result_sign_n(31 downto 16) <= "1111111111111111";
  sign_extend_n1 : result_sign_n(15 downto 0) <= imm(15 downto 0);
  
  sign_extend_p0 : result_sign_p(31 downto 16) <= "0000000000000000";
  sign_extend_p1 : result_sign_p(15 downto 0) <= imm(15 downto 0);
  
  sign_extend_sel : mux_32 port map(sel => imm(15), src0 => result_sign_p, 
              src1 => result_sign_n, z => result_sign);
  result_sel : mux_32 port map(sel => ExtOp, src0 => result_zero, 
              src1 => result_sign, z => result);
  
end structural;
			
  