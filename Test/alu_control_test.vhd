-- This script is a test bench for the ALU Control

library ieee;
use ieee.std_logic_1164.all;
use work.alu_control;

entity alu_control_test is
end alu_control_test;

architecture behavioral of alu_control_test is

component alu_control 
      port(
      ALUop: in std_logic_vector(2 downto 0);
      func: in std_logic_vector(5 downto 0);
      ALUctr: out std_logic_vector(3 downto 0)
      );
end component alu_control;

signal ALUop: std_logic_vector(2 downto 0);
signal func: std_logic_vector(5 downto 0);
signal ALUctr: std_logic_vector(3 downto 0);


begin
  test_comp : alu_control
      port map(
      ALUop => ALUop,
      func => func,
      ALUctr => ALUctr
      );

   testbench: process
   begin
   
   -- add signed
      ALUop <= "000";
      func <= "100000";
      wait for 5 ns;
      assert ALUctr = x"0" report "ALUctr = x0" severity error;
      wait for 5 ns;

   -- add unsigned
      ALUop <= "000";
      func <= "100001";
      wait for 5 ns;
      assert ALUctr = x"1" report "ALUctr = x1" severity error;
      wait for 5 ns;

   -- sub signed
      ALUop <= "001";
      func <= "100010";
      wait for 5 ns;
      assert ALUctr = x"2" report "ALUctr = x2" severity error;
      wait for 5 ns;
   
    -- sub unsigned
      ALUop <= "001";
      func <= "100011";
      wait for 5 ns;
      assert ALUctr = x"3" report "ALUctr = x3" severity error;
      wait for 5 ns;

    -- and
      ALUop <= "100";
      func <= "100100";
      wait for 5 ns;
      assert ALUctr = x"4" report "ALUctr = x4" severity error;
      wait for 5 ns;

    -- or
      ALUop <= "100";
      func <= "100101";
      wait for 5 ns;
      assert ALUctr = x"5" report "ALUctr = x5" severity error;
      wait for 5 ns;

     -- sll
      ALUop <= "100";
      func <= "000000";
      wait for 5 ns;
      assert ALUctr = x"6" report "ALUctr = x6" severity error;
      wait for 5 ns;

     -- slt
      ALUop <= "100";
      func <= "101010";
      wait for 5 ns;
      assert ALUctr = x"8" report "ALUctr = x8" severity error;
      wait for 5 ns;

     -- sltu
      ALUop <= "100";
      func <= "101011";
      wait for 5 ns;
      assert ALUctr = x"9" report "ALUctr = x9" severity error;
      wait for 5 ns;


  wait;
  end process;
end behavioral;




