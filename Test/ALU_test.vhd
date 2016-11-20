-- This script is a test bench for the ALU

library ieee;
use ieee.std_logic_1164.all;
use work.ALU;

entity ALU_test is
end ALU_test;

architecture behavioral of ALU_test is

component ALU
     port (
     A: in std_logic_vector(31 downto 0);
     B: in std_logic_vector(31 downto 0);
     m: in std_logic_vector(3 downto 0);
     Result: out std_logic_vector(31 downto 0);
     c_out: out std_logic;
     ovf: out std_logic;
     zero_out: out std_logic
     );
end component ALU;

signal A: std_logic_vector(31 downto 0);
signal B: std_logic_vector(31 downto 0);
signal m: std_logic_vector(3 downto 0);
signal Result: std_logic_vector(31 downto 0);
signal c_out: std_logic;
signal ovf: std_logic;
signal zero_out: std_logic;

begin
  test_comp : ALU
       port map (
       A => A,
       B => B,
       m => m,
       Result => Result,
       c_out => c_out,
       ovf => ovf,
       zero_out => zero_out
       );
  testbench : process  
  begin
     -- add signed
     -- add-1) (+4)+(+5)=(+9)
     A <= x"00000004";
     B <= x"00000005";
     m <= x"0";
     wait for 5 ns;
     assert Result = x"00000009" report "Result = x00000009" severity error;
     wait for 5 ns;

     --add-2) (-4)+(-5)=(-9)
     A <= x"fffffffc";
     B <= x"fffffffb";
     m <= x"0";
     wait for 5 ns;
     assert Result = x"fffffff7" report "Result = xfffffff7" severity error;
     wait for 5 ns;

    --add-3) (2^31-1)+1 --> should raise ovf
     A <= x"7fffffff";
     B <= x"00000001";
     m <= x"0";
     wait for 5 ns;
     assert Result = x"80000000" report "Result = x80000000" severity error;
     wait for 5 ns;

     -- add unsigned
     -- addu-1) 10+6=16
     A <= x"0000000a";
     B <= x"00000006";
     m <= x"1";
     wait for 5 ns;
     assert Result = x"00000010" report "Result = x00000010" severity error;
     wait for 5 ns;

     -- addu-2) (2^32-1)+1 --> should raise ovf
     A <= x"ffffffff";
     B <= x"00000001";
     m <= x"1";
     wait for 5 ns;
     assert Result = x"00000000" report "Result = x00000000" severity error;
     wait for 5 ns;
    
     -- sub signed
     -- sub-1) (+4)-(+5) =(-1)
     A <= x"00000004";
     B <= x"00000005";
     m <= x"2";
     wait for 5 ns;
     assert Result = x"ffffffff" report "Result = xffffffff" severity error;
     wait for 5 ns;

     -- sub-2) (+5)-(+4) =(+1)
     A <= x"00000005";
     B <= x"00000004";
     m <= x"2";
     wait for 5 ns;
     assert Result = x"00000001" report "Result = x00000001" severity error;
     wait for 5 ns;
    
     -- sub-3) (-2^31)-(+1) --> should raise overflow
     A <= x"80000000";
     B <= x"00000001";
     m <= x"2";
     wait for 5 ns;
     assert Result = x"7fffffff" report "Result = x7fffffff" severity error;
     wait for 5 ns;
     

     -- sub unsigned
     -- subu-1) 10-6=4
     A <= x"0000000a";
     B <= x"00000006";
     m <= x"3";
     wait for 5 ns;
     assert Result = x"00000004" report "Result = x00000007" severity error;
     wait for 5 ns;

     -- subu-2) 10-20 --> should raise ovf (negative number is out of range)
     A <= x"0000000a";
     B <= x"00000014";
     m <= x"3";
     wait for 5 ns;
     assert Result = x"fffffff6" report "Result = xfffffff6" severity error;
     wait for 5 ns;

     -- and 
     A <= x"00000004";
     B <= x"00000005";
     m <= x"4";
     wait for 5 ns;
     assert Result = x"00000004" report "Result = x00000004" severity error;
     wait for 5 ns;
      
     -- or
     A <= x"00000004";
     B <= x"00000005";
     m <= x"5";
     wait for 5 ns;
     assert Result = x"00000005" report "Result = x00000005" severity error;
     wait for 5 ns;

     -- shift left logical
     A <= x"ffffffff";
     B <= x"00000003";
     m <= x"6";
     wait for 5 ns;
     assert Result = x"fffffff8" report "Result = xfffffff8" severity error;
     wait for 5 ns;

     -- set less than signed
     A <= x"00000004";
     B <= x"80000006";
     m <= x"8";
     wait for 5 ns;
     assert Result = x"00000000" report "Result = x00000000" severity error;
     wait for 5 ns;
 
    -- set less than unsigned
     A <= x"00000004";
     B <= x"00000006";
     m <= x"9";
     wait for 5 ns;
     assert Result = x"00000001" report "Result = x00000001" severity error;
     wait for 5 ns;

    -- add immediate
    A <= x"00000007";
    B <= x"00000005";
    m <= x"a";
    wait for 5 ns;
    assert Result = x"0000000c" report "Result = x0000000c" severity error;
    wait for 5 ns;

   -- sub immediate
    A <= x"00000007";
    B <= x"00000005";
    m <= x"b";
    wait for 5 ns;
    assert Result = x"00000002" report "Result = x00000002" severity error;
    wait for 5 ns;

    

  
     wait;
  end process;
end behavioral;

      
