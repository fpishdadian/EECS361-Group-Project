library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.eecs361_gates.all;

entity ControlUnit is
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
end ControlUnit;

architecture Structural of ControlUnit is

component and_6To1
     port (
         x: in std_logic_vector(5 downto 0);
         z: out std_logic
         );
end component and_6To1;

component or_6To1
     port (
         x: in std_logic_vector(5 downto 0);
         z: out std_logic
         );
end component or_6To1;

component or_gate is
port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;
component not_gate is
port (
    x   : in  std_logic;
    z   : out std_logic
  );
end component;

SIGNAL R_type, LW, SW, BEQ, BNEQ,BGTZ, addi: std_logic;

begin

R_type <= '1' when OPcode = "000000" else '0';
LW <= '1' when OPcode = "100011" else '0';
SW <= '1' when OPcode = "101011" else '0';
BEQ <= '1' when  OPcode = "000100" else '0';
BNEQ <= '1' when  OPcode = "000101" else '0';
BGTZ <= '1' when  OPcode = "000111" else '0';
addi<= '1'  when  OPcode = "001000" else '0'; 

Branch <= BEQ; 
BranchNE<= BNEQ; 
BranchTZ  <=BGTZ;

MemToReg <= LW;
ALUSrc <= LW Or SW or addi;

RegDst <= R_type;
MemRead <= LW;
MemWrite <= SW;
RegWrite <= R_type Or LW or addi;

ExtOP <= LW Or SW;


ALUOp(2) <= R_type;	
ALUOp(1) <= addi;
ALUOp(0) <= BEQ Or BNEQ or BGTZ; 



end Structural;


