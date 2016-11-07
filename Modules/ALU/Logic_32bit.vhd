library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;
use work.mux_32_4to1;

entity Logic_32bit is
    port(
    log_in0: in std_logic_vector(31 downto 0);
    log_in1: in std_logic_vector(31 downto 0);
    op_code: in std_logic_vector(1 downto 0);
    log_out: out std_logic_vector(31 downto 0)
    );
end Logic_32bit;

architecture structural of Logic_32bit is

component and_gate_32
    port (
      x : in std_logic_vector(31 downto 0);
      y : in std_logic_vector(31 downto 0);
      z : out std_logic_vector(31 downto 0)
    );
end component and_gate_32;

component or_gate_32
    port (
      x : in std_logic_vector(31 downto 0);
      y : in std_logic_vector(31 downto 0);
      z : out std_logic_vector(31 downto 0)
    );
end component or_gate_32;

component xor_gate_32
    port (
      x : in std_logic_vector(31 downto 0);
      y : in std_logic_vector(31 downto 0);
      z : out std_logic_vector(31 downto 0)
    );
end component xor_gate_32;

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
u0: and_gate_32 port map (
    x => log_in0,
    y => log_in1,
    z => temp0
    );

u1: or_gate_32 port map (
    x => log_in0,
    y => log_in1,
    z => temp1
    );

u2: xor_gate_32 port map (
    x => log_in0,
    y => log_in1,
    z => temp2
    );

u3: mux_32_3to1 port map (
    sel => op_code,
    src00 => temp0,
    src01 => temp1,
    src10 => temp2,
    z => log_out
    );

end structural;






























