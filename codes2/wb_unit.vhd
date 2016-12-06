library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity wb_unit is
port(  data_in  : in std_logic_vector(31 downto 0);
       result_in  : in std_logic_vector(31 downto 0);
	   MemtoReg  : in std_logic;
	   Rw_in  : in std_logic_vector(4 downto 0);
	   Rw_out  : out std_logic_vector(4 downto 0);
	   data_out  : out std_logic_vector(31 downto 0)
	   );
end wb_unit;

architecture structural of wb_unit is
component mux_32 is
  port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(31 downto 0);
	src1  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end component;

begin
mux_map: mux_32 port map(sel => MemtoReg, src0 => result_in,
             src1 => data_in, z => data_out);
Rw_out <= Rw_in;

end structural;