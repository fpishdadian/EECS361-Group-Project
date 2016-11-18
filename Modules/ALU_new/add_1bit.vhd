library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.mux;

entity add_1bit is
    port(
    add_in0: in std_logic;
    add_in1: in std_logic;
    c_in: in std_logic;
    add_out: out std_logic;
    c_in_out: out std_logic;
    c_out: out std_logic
    );
end add_1bit;

architecture structural of add_1bit is

component and_gate
    port(
    x: in  std_logic;
    y: in  std_logic;
    z: out std_logic
    );
end component and_gate;

component or_gate
    port(
    x: in  std_logic;
    y: in  std_logic;
    z: out std_logic
    );
end component or_gate;

component xor_gate
    port(
    x: in  std_logic;
    y: in  std_logic;
    z: out std_logic
    );
end component xor_gate;

signal temp0,temp1,temp2,temp3,temp4: std_logic;

begin

u0: xor_gate port map(
    x => add_in0,
    y => add_in1,
    z => temp0
    );

u1: xor_gate port map(
    x => temp0,
    y => c_in,
    z => add_out
    );

u2: and_gate port map(
    x => add_in0,
    y => add_in1,
    z => temp1
    );

u3: and_gate port map(
    x => add_in0,
    y => c_in,
    z => temp2
    );

u4: and_gate port map(
    x => add_in1,
    y => c_in,
    z => temp3
    );

u5: or_gate port map(
    x => temp1,
    y => temp2,
    z => temp4
    );

u6: or_gate port map(
    x => temp3,
    y => temp4,
    z => c_out
    );
    
c_in_out <= c_in;

end structural;


