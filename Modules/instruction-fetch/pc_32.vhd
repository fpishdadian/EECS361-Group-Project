-- This code implements a single 32-bit register (basic building block of the register file)
--Use for program counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity pc_32 is
     port(
     clk: in std_logic;
	 arst: in std_logic;
     write_enable: in std_logic;
     data_in: in std_logic_vector(31 downto 0);
     data_out: out std_logic_vector(31 downto 0)
     );
end pc_32;

architecture structural of pc_32 is

component dffr_32
   port (
    clk	   : in  std_logic;
    arst   : in  std_logic;
    aload  : in  std_logic;
    adata  : in  std_logic_vector(31 downto 0);
	d	   : in  std_logic_vector(31 downto 0);
    enable : in  std_logic;
	q	   : out std_logic_vector(31 downto 0)
  );
end component dffr_32;

begin
--Reg32: for I in 0 to 31 generate
r_I: dffr_32 port map(
       clk => clk,
       arst => arst,
       aload => '0',
       adata => x"00000000",
       d => data_in,
       enable => write_enable,
       q => data_out
       );
--end generate Reg32;

end structural;



