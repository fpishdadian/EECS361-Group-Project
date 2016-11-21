--This is a register file which can store 32 32-bit data.
library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.data_type.all;
use work.dffr_a;

entity register_file is
     port(
	 clk: in std_logic;
	 arst: in std_logic;
	 write_enable: in std_logic;
	 Ra : in std_logic_vector(4 downto 0);
	 Rb : in std_logic_vector(4 downto 0);
	 Rw : in std_logic_vector(4 downto 0);
     data_in: in std_logic_vector(31 downto 0);
     BusA: out std_logic_vector(31 downto 0);
	 BusB: out std_logic_vector(31 downto 0));
end register_file;

architecture structural of register_file is

component register_basic_32 is
     port(
     clk: in std_logic;
	 arst: in std_logic;
     write_enable: in std_logic;
     data_in: in std_logic_vector(31 downto 0);
     data_out: out std_logic_vector(31 downto 0)
     );
end component;

component mux_reg_file is
     port(
	 sel : in std_logic_vector(4 downto 0);
     src : in src_type(31 downto 0);-- 32 32-bit register input
       z : out std_logic_vector(31 downto 0));
end component;

component and_gate is
  port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

component not_gate is
port(x : in std_logic;
     z :out std_logic);
end component;

component dec_n is
generic (
    n	: integer :=5
  );
port (
    src	: in std_logic_vector(n-1 downto 0);
    z	: out std_logic_vector((2**n)-1 downto 0)
  );
end component;

signal sig_dec : std_logic_vector(31 downto 0);
signal sig_enable : std_logic_vector(31 downto 0);
signal sig_data_out : src_type(31 downto 0);
signal sig_clk : std_logic;

begin
dec_map: dec_n port map(src=>Rw,z=>sig_dec);--generate sig_dec which will go through and_gate later(another input of and_gate is write_enable)

not_gate_map: not_gate port map(x=>clk, z=>sig_clk);--inverse the clk to wait for the write_enable signal being ready

G1: for I in 31 downto 0 generate
and_gate_map: and_gate port map(x=>sig_dec(I),y=>write_enable,z=>sig_enable(I));
register_map: register_basic_32 port map(clk=>sig_clk,arst=>arst,data_in=>data_in,write_enable=>sig_enable(I),data_out=>sig_data_out(I));
end generate G1;

mux_map2: mux_reg_file port map(sel=>Ra, src=>sig_data_out,z=>BusA);
mux_map3: mux_reg_file port map(sel=>Rb, src=>sig_data_out,z=>BusB);

end structural;