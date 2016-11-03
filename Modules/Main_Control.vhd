--- This code implemets the Main Control module of the single cycle processor

library ieee;
use ieee.std_logic_1164.all;
use work.and_gate_6to1;
use work.or_gate_3to1;

entity Main_Control is
       port (
       op: in std_logic_vector(5 downto 0);
       RegWrite: out std_logic;
       ALUSrc: out std_logic;
       RegDst: out std_logic;
       MemtoReg: out std_logic;
       MemWrite: out std_logic;
       Branch: out std_logic;
       Jump_out: out std_logic;
       ExtOp: out std_logic;
       ALUop: out std_logic_vector(2 downto 0)
       );
end Main_Control;

architecture structural of Main_Control is

component not_gate
    port (
      x : in std_logic;
      z : out std_logic
    );
end component not_gate;

component or_gate
    port (
      x : in std_logic;
      y : in std_logic;
      z : out std_logic
    );
end component or_gate;

component or_gate_3to1
    port (
      or_in: in std_logic_vector(2 downto 0);
      or_out: out std_logic
       );
end component or_gate_3to1;

component and_gate_6to1
    port (
      and_in: in std_logic_vector(5 downto 0);
      and_out: out std_logic
       );
end component and_gate_6to1;

signal opNot: std_logic_vector(5 downto 0);
signal R_type, ori, lw, sw, beq, jump_sig: std_logic;

begin

Not5: not_gate port map (
     x => op(5),
     z => opNot(5)
     );

Not4: not_gate port map (
     x => op(4),
     z => opNot(4)
     );

Not3: not_gate port map (
     x => op(3),
     z => opNot(3)
     );

Not2: not_gate port map (
     x => op(2),
     z => opNot(2)
     );

Not1: not_gate port map (
     x => op(1),
     z => opNot(1)
     );

Not0: not_gate port map (
     x => op(0),
     z => opNot(0)
     );

And1: and_gate_6to1 port map (
      and_in(5) => opNot(5),
      and_in(4) => opNot(4),
      and_in(3) => opNot(3),
      and_in(2) => opNot(2),
      and_in(1) => opNot(1),
      and_in(0) => opNot(0),      
      and_out => R_type
      );

And2: and_gate_6to1 port map (
      and_in(5) => opNot(5),
      and_in(4) => opNot(4),
      and_in(3) => op(3),
      and_in(2) => op(2),
      and_in(1) => opNot(1),
      and_in(0) => op(0),      
      and_out => ori
      );

And3: and_gate_6to1 port map (
      and_in(5) => op(5),
      and_in(4) => opNot(4),
      and_in(3) => opNot(3),
      and_in(2) => opNot(2),
      and_in(1) => op(1),
      and_in(0) => op(0),      
      and_out => lw
      );

And4: and_gate_6to1 port map (
      and_in(5) => op(5),
      and_in(4) => opNot(4),
      and_in(3) => op(3),
      and_in(2) => opNot(2),
      and_in(1) => op(1),
      and_in(0) => op(0),      
      and_out => sw
      );

And5: and_gate_6to1 port map (
      and_in(5) => opNot(5),
      and_in(4) => opNot(4),
      and_in(3) => opNot(3),
      and_in(2) => op(2),
      and_in(1) => opNot(1),
      and_in(0) => opNot(0),      
      and_out => beq
      );

And6: and_gate_6to1 port map (
      and_in(5) => opNot(5),
      and_in(4) => opNot(4),
      and_in(3) => opNot(3),
      and_in(2) => opNot(2),
      and_in(1) => op(1),
      and_in(0) => opNot(0),      
      and_out => jump_sig
      );

Or1: or_gate_3to1 port map (
     or_in(2) => R_type,
     or_in(1) => ori,
     or_in(0) => lw,
     or_out => RegWrite
     );

Or2: or_gate_3to1 port map (
     or_in(2) => ori,
     or_in(1) => lw,
     or_in(0) => sw,
     or_out => ALUSrc
     );

RegDst <= R_type;
MemtoReg <= lw;
MemWrite <= sw;
Branch <= beq;
Jump_out <= jump_sig;

Or3: or_gate port map (
     x => lw,
     y => sw,
     z => ExtOp
     );

ALUop(2) <= R_type;
ALUop(1) <= ori;
ALUop(0) <= beq;


end structural;







