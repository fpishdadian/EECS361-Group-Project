Library ieee;
USE ieee.std_logic_1164.all;
use work.eecs361_gates.all;
entity DataPath is 
end entity DataPath;
architecture struct of DataPath is
component inst_mem is 
port(
Adr: in std_logic_vector(31 downto 0); 
opcode, func: out std_logic_vector(5 downto 0);
Rs, Rt, Rd, shamt: out std_logic_vector(4 downto 0);
imm16: out std_logic_vector(15 downto 0));
end component;
component next_address_logic is
port (
		clk, branch, zero, rst : in std_logic; 
		instruction : in std_logic_vector(15 downto 0);
		addr : out std_logic_vector(31 downto 0)
		);
end component;
component ControlUnit is
    Port ( OPcode : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUOp : out  STD_LOGIC_VECTOR (2 downto 0);
           RegDst : out  STD_LOGIC;
           ALUSrc : out  STD_LOGIC;
           MemToReg : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           MemRead : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
	   BranchNE : out  STD_LOGIC;
           Branch : out  STD_LOGIC;
	   BranchTZ : out  STD_LOGIC;
	   ExtOP:out  STD_LOGIC 
);
end component;
component ALUCU is
    Port ( ALUOp : in  STD_LOGIC_VECTOR (2 downto 0);
           func : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUCtr : out  STD_LOGIC_VECTOR (2 downto 0));
end component;
component RegFile is
  port(
    clk, arst, aload, RegWr,RegDst : in  std_logic;
    busW       	: in  std_logic_vector(31 downto 0);
    Rs, Rt, Rd	: in  std_logic_vector(4 downto 0);
    busA        : out std_logic_vector(31 downto 0);
    busB        : out std_logic_vector(31 downto 0)
    );
end component;
component Extender is
port (
		imm16_in_ex : in std_logic_vector(15 downto 0);
		imm16_out_ex : out std_logic_vector(31 downto 0)
		);
end component;
component sign_ext is
port (
		imm16 : in std_logic_vector(15 downto 0);
		output : out std_logic_vector(31 downto 0)
		);
end component sign_ext;
component mux_32 is
  port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(31 downto 0);
	src1  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end component;
component ALU is
  port (
	ctrl   : in  std_logic_vector(2 downto 0);
	A  : in  std_logic_vector(31 downto 0);
	B  : in  std_logic_vector(31 downto 0);
	shamt: in  std_logic_vector(4 downto 0);
	cout : out std_logic; -- '1' for carry out
	ovf : out std_logic; -- '1' for overflow
	ze : out std_logic; -- '1' is zero
	R  : out  std_logic_vector(31 downto 0)
  );
end component;
component data_mem is 
port(
clk, MemWr, output_en: in std_logic;
data_in, address: in std_logic_vector(31 downto 0);
data_out: out std_logic_vector(31 downto 0));
end component;

component not_gate is
port (
    x   : in  std_logic;
    z   : out std_logic
  );
end component;

--next address
signal addr_inst: std_logic_vector(31 downto 0); 

--InstMEM signal
--Signal Adr: std_logic_vector(31 downto 0); 
Signal opcode, func: std_logic_vector(5 downto 0);
Signal Rs, Rt, Rd: std_logic_vector(4 downto 0);
Signal shamt: std_logic_vector(4 downto 0);
Signal imm16: std_logic_vector(15 downto 0);
---REG FILE signal
signal RegWr,RegDst : std_logic;
signal busW       	: std_logic_vector(31 downto 0);
signal busA        : std_logic_vector(31 downto 0);
signal busB        : std_logic_vector(31 downto 0);
--Control Unit Signal
--signal OPcode : STD_LOGIC_VECTOR (5 downto 0);
signal ALUop : STD_LOGIC_VECTOR (2 downto 0);
signal BranchNE : STD_LOGIC;
signal BranchE : STD_LOGIC;
signal BranchTZ : STD_LOGIC;
signal Nzero: STD_LOGIC;
signal ze_out: STD_LOGIC;
signal Bne_out: STD_LOGIC;
signal Be_out: STD_LOGIC;
signal B_out: STD_LOGIC;
signal BTZ_out_1, BTZ_out: STD_LOGIC;
signal Btemp: STD_LOGIC;
--ALU control Unit
--Extender
signal	imm16_out_ex : std_logic_vector(31 downto 0);
--MUX--SExtender
signal	imm16_out_signex : std_logic_vector(31 downto 0);
--MUX--Extender
signal ExtOp   : std_logic;
signal z_MUX_Extender	 : std_logic_vector(31 downto 0);
--MUX--ALUSrc
signal ALUSrc   : std_logic;
signal z_MUX_ALUSrc	 : std_logic_vector(31 downto 0);
signal nothing	 : std_logic_vector(31 downto 0);
--ALU---
signal ALUctrl	 : std_logic_vector(2 downto 0);
signal ALU_Z, ALU_Cout, ALU_OVF, ALU_Cout_not: std_logic;
signal ALU_out	 : std_logic_vector(31 downto 0);
---DATA MEMORY--------
signal MemWrite, MemRead: std_logic;
signal MEM_out	 : std_logic_vector(31 downto 0);
---MUX_MEMTOREG
signal MemtoReg: std_logic;

signal clk_tb : std_logic :='0';
signal clk_lw : std_logic :='0';
constant clk_period : time := 2 ns;
constant clk_lw_period : time := 1 ns;
constant rst_period : time := 2 ns;
signal rst_tb:std_logic;

begin
nothing <= "00000000000000000000000000000000";
next_logic: next_address_logic port map(clk=>clk_tb, 
					branch=>B_out, 
					zero=>B_out, 
					rst=>rst_tb, 
					instruction=>imm16, 
					addr=>addr_inst);
inst_mem_map: inst_mem port map(addr_inst, 
				opcode, func, Rs, Rt, Rd,shamt,imm16);
CU_map : ControlUnit port map
   	 ( OPcode =>opcode,
           ALUOp=>ALUop,
           RegDst=>RegDst,
           ALUSrc=>ALUSrc,
           MemToReg=>MemToReg,
           RegWrite=>RegWr,
           MemRead=>MemRead,
           MemWrite=>MemWrite,
	   BranchNE=>BranchNE,
           Branch=>BranchE,
	   BranchTZ=>BranchTZ,
	   ExtOP=>ExtOP 
);

--Nzero <= NOT (ALU_Z);
not_gate_map: not_gate port map(x=>ALU_Z,z=>Nzero);
not_gate_map_1: not_gate port map(x=>ALU_cout,z=>ALU_cout_not);
AND2_1: and_gate PORT MAP(BranchNE, Nzero, Bne_out);
AND2_2: and_gate PORT MAP(BranchE, ALU_Z, Be_out);
AND2_3: and_gate PORT MAP(BranchTZ, ALU_cout_not, BTZ_out_1);
AND2_4: and_gate PORT MAP(BTZ_out_1, Nzero, BTZ_out);
OR1: or_gate PORT MAP(Bne_out, Be_out, Btemp);
OR1_2: or_gate PORT MAP(BTZ_out, Btemp, B_out);
OR2: or_gate PORT MAP(Nzero, ALU_Z, ze_out);
ALUCU_map: ALUCU port map 
   			 ( ALUOp => ALUop,
         		   func=>func,
           		  ALUCtr => ALUctrl
			);
reg_map : RegFile port map 
			(
			clk =>clk_tb,
			arst =>rst_tb,
			aload =>'0',
			busW => busW,
			RegWr => RegWr, 
			RegDst => RegDst,
			Rs => Rs,
			Rt => Rt, 
			Rd => Rd,
			busA => busA,
			busB => busB
			);
Exe_map: Extender port map (imm16_in_ex=>imm16, imm16_out_ex => imm16_out_ex);
SignEx_map: sign_ext port map(imm16=>imm16, output=>imm16_out_signex);
mux_extender: mux_32 port map(sel=>ExtOp, src0=>imm16_out_ex ,src1=>imm16_out_signex,z=>z_MUX_Extender);
mux_ALUsrc: mux_32 port map(sel=>ALUSrc, src0=>busB ,src1=>z_MUX_Extender,z=>z_MUX_ALUSrc); 
alu_map: ALU port map (
			ctrl=>ALUctrl,
			A=>busA,
			B=>z_MUX_ALUSrc,
			shamt =>shamt,
			cout=>ALU_cout,
			ovf=> ALU_OVF,
			ze=> ALU_Z,
			R=> ALU_out);
--data_mem_map: data_mem port map(
--				clk=>clk_tb,
--				MemWr=>MemWrite, 
--				output_en=> MemRead,
--				data_in=>busB,
--				address=>ALU_out,
--				data_out=>MEM_out);
data_mem_map: data_mem port map(clk_lw, MemWrite,MemRead,busB,ALU_out, MEM_out);
mux_memtoReg: mux_32 port map(sel=>MemtoReg, src0=>ALU_out ,src1=>MEM_out,z=>busW); 

rst_stim: process
begin
  rst_tb <= '1';
  wait for rst_period;
  rst_tb <= '0';
  wait;
end process;			
clk_stim: process 
begin 
	clk_tb <= '0';
	wait for clk_period;
	clk_tb <= '1';
	wait for clk_period;
end process;
clk_lw_stim: process 
begin 
	clk_lw <= '0';
	wait for clk_lw_period;
	clk_lw <= '1';
	wait for clk_lw_period;
end process;

end architecture struct;
