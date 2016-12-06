library ieee;
use ieee.std_logic_1164.all;
use work.dffr_a;

entity register_basic_144 is
     port(
     clk: in std_logic;
	 arst: in std_logic;
     write_enable: in std_logic;
     data_in: in std_logic_vector(143 downto 0);
     data_out: out std_logic_vector(143 downto 0)
     );
end register_basic_144;

architecture structural of register_basic_144 is

component dffr_a
   port (
    clk    : in  std_logic;
    arst   : in  std_logic;
    aload  : in  std_logic;
    adata  : in  std_logic;
	d  : in  std_logic;
    enable : in  std_logic;
	q  : out std_logic
  );
end component dffr_a;

begin
Reg144: for I in 0 to 143 generate
  r_I: dffr_a port map(
       clk => clk,
       arst => arst,
       aload => '0',
       adata => '0',
       d => data_in(I),
       enable => write_enable,
       q => data_out(I)
       );
end generate Reg144;

end structural;