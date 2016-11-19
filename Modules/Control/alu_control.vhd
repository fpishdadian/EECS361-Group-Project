-- This script implements the ALU Control unit

library ieee;
use ieee.std_logic_1164.all;
use work.and_gate_9to1;
use work.or_gate_4to1;

entity alu_control is
      port(
      ALUop: in std_logic_vector(2 downto 0);
      func: in std_logic_vector(5 downto 0);
      ALUctr: out std_logic_vector(3 downto 0)
      );
end alu_control;

architecture structural of alu_control is

component not_gate
port (
    x   : in  std_logic;
    z   : out std_logic
  );
end component not_gate;

component and_gate_9to1
     port (
         and_in: in std_logic_vector(8 downto 0);
         and_out: out std_logic
         );
end component and_gate_9to1;

component or_gate_4to1
     port (
         or_in: in std_logic_vector(3 downto 0);
         or_out: out std_logic
         );
end component or_gate_4to1;

signal add_temp,addu_temp,sub_temp,subu_temp: std_logic;
signal and_temp,or_temp,sll_temp,slt_temp,sltu_temp: std_logic;
signal not_aluop: std_logic_vector(2 downto 0);
signal not_func: std_logic_vector(5 downto 0);

begin

not1: for I in 0 to 2 generate
not_gate_map: not_gate port map(x=>ALUop(I),z=>not_aluop(I));
end generate not1;

not2: for I in 0 to 5 generate
not_gate_map: not_gate port map(x=>func(I), z=> not_func(I));
end generate not2;

-- add operation
u1: and_gate_9to1 port map(
    and_in(8 downto 6)=>not_aluop(2 downto 0),
    and_in(5) => func(5),
    and_in(4 downto 0) => not_func(4 downto 0),
    and_out => add_temp
    );

-- addu operation
u2: and_gate_9to1 port map(
    and_in(8 downto 6)=>not_aluop(2 downto 0),
    and_in(5) => func(5),
    and_in(4 downto 1) => not_func(4 downto 1),
    and_in(0)=>func(0),
    and_out => addu_temp
    );

-- sub operation
u3: and_gate_9to1 port map(
    and_in(8 downto 7)=>not_aluop(2 downto 1),
    and_in(6)=> ALUop(0),
    and_in(5) => func(5),
    and_in(4 downto 2) => not_func(4 downto 2),
    and_in(1) => func(1),
    and_in(0) => not_func(0),
    and_out => sub_temp
    );

-- subu operation
u4: and_gate_9to1 port map(
    and_in(8 downto 7)=>not_aluop(2 downto 1),
    and_in(6)=> ALUop(0),
    and_in(5) => func(5),
    and_in(4 downto 2) => not_func(4 downto 2),
    and_in(1 downto 0) => func(1 downto 0),
    and_out => subu_temp
    );

-- and operation
u5: and_gate_9to1 port map(
    and_in(8)=>ALUop(2),
    and_in(7 downto 6)=>not_aluop(1 downto 0),
    and_in(5) => func(5),
    and_in(4 downto 3) => not_func(4 downto 3),
    and_in(2) => func(2),
    and_in(1 downto 0) => not_func(1 downto 0),
    and_out => and_temp
    );

-- or operation
u6: and_gate_9to1 port map(
    and_in(8)=>ALUop(2),
    and_in(7 downto 6)=>not_aluop(1 downto 0),
    and_in(5) => func(5),
    and_in(4 downto 3) => not_func(4 downto 3),
    and_in(2) => func(2),
    and_in(1) => not_func(1),
    and_in(0) => func(0),
    and_out => or_temp
    );

-- sll operation
u7: and_gate_9to1 port map(
    and_in(8)=>ALUop(2),
    and_in(7 downto 6)=>not_aluop(1 downto 0),
    and_in(5 downto 0) => not_func(5 downto 0),
    and_out => sll_temp
    );

-- slt operation
u8: and_gate_9to1 port map(
    and_in(8)=>ALUop(2),
    and_in(7 downto 6)=>not_aluop(1 downto 0),
    and_in(5) => func(5),
    and_in(4) => not_func(4),
    and_in(3) => func(3),
    and_in(2) => not_func(2),
    and_in(1) => func(1),
    and_in(0) => not_func(0),
    and_out => slt_temp
    );

-- sltu operation
u9: and_gate_9to1 port map(
    and_in(8)=>ALUop(2),
    and_in(7 downto 6)=>not_aluop(1 downto 0),
    and_in(5) => func(5),
    and_in(4) => not_func(4),
    and_in(3) => func(3),
    and_in(2) => not_func(2),
    and_in(1 downto 0) => func(1 downto 0),
    and_out => sltu_temp
    );

-- ALUctr(3)
u10: or_gate_4to1 port map(
     or_in(3)=> slt_temp,
     or_in(2)=> sltu_temp,
     or_in(1 downto 0) => "00",
     or_out => ALUctr(3)
     ); 

--ALUctr(2)
u11: or_gate_4to1 port map(
     or_in(3)=> and_temp,
     or_in(2)=> or_temp,
     or_in(1)=> sll_temp,
     or_in(0) => '0',
     or_out => ALUctr(2)
     ); 

-- ALU(1)
u12: or_gate_4to1 port map(
     or_in(3)=> sub_temp,
     or_in(2)=> subu_temp,
     or_in(1)=> sll_temp,
     or_in(0) => '0',
     or_out => ALUctr(1)
     ); 

-- ALU(0)
u13: or_gate_4to1 port map(
     or_in(3)=> addu_temp,
     or_in(2)=> subu_temp,
     or_in(1)=> or_temp,
     or_in(0) => sltu_temp,
     or_out => ALUctr(0)
     ); 

end structural;


