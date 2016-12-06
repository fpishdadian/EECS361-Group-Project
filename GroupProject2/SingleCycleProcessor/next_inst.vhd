library ieee;
use ieee.std_logic_1164.all;

entity next_inst is
port (
		clk, branch, zero, rst : in std_logic;
		imm16_in: in std_logic_vector(15 downto 0);
		opcode, func: out std_logic_vector(5 downto 0);
		Rs, Rt, Rd: out std_logic_vector(4 downto 0);
		imm16_out: out std_logic_vector(15 downto 0)
		);
end next_inst;

architecture struct of next_inst is

component next_address_logic is
port (
		clk, branch, zero, rst : in std_logic; 
		instruction : in std_logic_vector(15 downto 0);
		addr : out std_logic_vector(31 downto 0)
		);
end component;

component inst_mem is
port (
		Adr: in std_logic_vector(31 downto 0); 
		opcode, func: out std_logic_vector(5 downto 0);
		Rs, Rt, Rd: out std_logic_vector(4 downto 0);
		imm16: out std_logic_vector(15 downto 0)
		);
end component;

signal addr_inst: std_logic_vector(31 downto 0);
signal imm_addr: std_logic_vector(31 downto 0);
begin 
next_logic: next_address_logic port map(clk=>clk, branch=>branch, zero=>zero, rst=>rst, instruction=>imm16_in, addr=>addr_inst);
--imm_addr(31 downto 2)<=addr_inst;
--imm_addr(1 downto 0)<="00";
--imm_addr <= X"00400020";
--next_inst: inst_mem port map(Adr(31 downto 2)=>addr_inst, Adr(1 downto 0)=>"00", opcode=>opcode, func=>func, Rs=>Rs, Rt=>Rt, Rd=>Rd, imm16=>imm16_out);
next_inst: inst_mem port map(addr_inst, opcode, func, Rs, Rt, Rd, imm16_out);
--next_inst: inst_mem port map(Adr=>imm_addr, opcode=>opcode, func=>func, Rs=>Rs, Rt=>Rt, Rd=>Rd, imm16=>imm16_out);
end architecture struct;
