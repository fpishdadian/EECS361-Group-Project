Library ieee;
USE ieee.std_logic_1164.all;

entity sign_ext_tb is
end entity sign_ext_tb;

architecture struct of sign_ext_tb is

component sign_ext is
port (
		imm16 : in std_logic_vector(15 downto 0);
		output : out std_logic_vector(29 downto 0)
		);
end component;

signal imm16_tb : std_logic_vector(15 downto 0);
signal output_tb : std_logic_vector(29 downto 0);

begin
dut: sign_ext
port map(imm16=>imm16_tb, output=>output_tb);

stim_pc: process
begin
imm16_tb <= "0001000100010001";
wait for 10 ns;

imm16_tb <= "1000100010001000";
wait;
end process;

end architecture struct;
