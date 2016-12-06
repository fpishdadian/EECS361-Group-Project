Library ieee;
USE ieee.std_logic_1164.all;

entity pc is 
port (
		clk : in std_logic; 
		rst : in std_logic;
		input : in std_logic_vector(31 downto 0); 
		output : out std_logic_vector(31 downto 0)
		);
end pc;

architecture struct of pc is 

component dffr_32bit_PC is
  port (
	clk	   : in  std_logic;
    	arst   : in  std_logic;
   	 aload  : in  std_logic;
   	 adata  : in  std_logic_vector(31 downto 0);
	d	   : in  std_logic_vector(31 downto 0);
   	 enable : in  std_logic;
	q	   : out std_logic_vector(31 downto 0)
  );
end component;
signal zero : std_logic_vector(31 downto 0);
begin
zero <= X"00400020";
p_c: dffr_32bit_PC port map(clk=>clk, 
		     d=>input, 
		     q=>output, 
		     arst=>rst, 
		     aload=>'0', 
		    adata=>zero,
		   enable=>clk);
--counter: for i in 0 to 29 generate begin
	--p_c: dffr_a port map(clk=>clk, d=>input(i), q=>output(i), arst=>rst, aload=>'0', adata=>'0',enable=>clk);
--end generate counter;
end architecture struct;
