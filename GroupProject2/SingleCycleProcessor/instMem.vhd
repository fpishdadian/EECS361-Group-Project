library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity inst_mem is 
port(
Adr: in std_logic_vector(31 downto 0); 
opcode, func: out std_logic_vector(5 downto 0);
Rs, Rt, Rd, shamt: out std_logic_vector(4 downto 0);
imm16: out std_logic_vector(15 downto 0));
end inst_mem;

architecture structural of inst_mem is 
signal zero, inst: std_logic_vector(31 downto 0);
signal output_en, write_en: std_logic;
component sram is
  generic (
	mem_file : string
  );
  port (
	cs	  : in	std_logic;
	oe	  :	in	std_logic;
	we	  :	in	std_logic;
	addr  : in	std_logic_vector(31 downto 0);
	din	  :	in	std_logic_vector(31 downto 0);
	dout  :	out std_logic_vector(31 downto 0)
  );
end component;

begin
	zero <= X"00000000";
	output_en <= '1';
	write_en <= '0';
	--inst_mem: sram generic map("bills_branch.dat") port map('1', output_en, write_en, Adr, zero, inst);
	inst_mem: sram generic map("sort_corrected_branch.dat") port map('1', output_en, write_en, Adr, zero, inst);
	--inst_mem: sram generic map("unsigned_sum.dat") port map('1', output_en, write_en, Adr, zero, inst);

	opcode <= inst(31 downto 26);
	func <= inst(5 downto 0);
	Rs <= inst(25 downto 21);
	Rt <= inst(20 downto 16);
	Rd <= inst(15 downto 11);
	shamt <= inst(10 downto 6);
	imm16 <= inst(15 downto 0);	

end structural;