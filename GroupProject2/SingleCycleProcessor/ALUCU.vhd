library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.eecs361.mux_n;

entity ALUCU is
    Port ( ALUOp : in  STD_LOGIC_VECTOR (2 downto 0);
           func : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUCtr : out  STD_LOGIC_VECTOR (2 downto 0));
end ALUCU;

architecture Structural of ALUCU is
component mux_3bit is
  port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(2 downto 0);
	src1  : in  std_logic_vector(2 downto 0);
	z	    : out std_logic_vector(2 downto 0)
  );
end component;	
signal ALUCtr_temp: STD_LOGIC_VECTOR (2 downto 0);
signal ALUCtr_sll: STD_LOGIC_VECTOR (2 downto 0);
signal ALUCtr_adu: STD_LOGIC_VECTOR (2 downto 0);
--signal ALUCtr_slt: STD_LOGIC_VECTOR (2 downto 0);
--signal ALUCtr_slts: STD_LOGIC_VECTOR (2 downto 0);
signal ALUCtemp: STD_LOGIC_VECTOR (2 downto 0);
signal ALUCtremp: STD_LOGIC_VECTOR (2 downto 0);
--signal sel: STD_LOGIC_VECTOR (2 downto 0);
signal Ffunc: std_logic;
signal self:STD_LOGIC;
begin
Ffunc<=func(5)OR func(4)OR func(3)OR func(2)OR func(1) OR func(0) OR (NOT ALUOp(2)); 
--self <= func(5)OR func(4)OR func(3)OR func(2)OR func(1) OR func(0) OR (NOT ALUOp(2)); 
ALUCtr_sll<="101";
self <= func(5)AND(Not func(4))AND(Not func(3))AND(Not func(2))AND(Not func(1)) AND func(0)AND(ALUOp(2));
ALUCtr_adu <= "010";
--ALUCtr_temp(2)<= ((NOT ALUOp(2))AND ALUOp(0)) OR ( ALUOp(2) AND (NOT func(2))AND func(1)AND (NOT func(0)));
--ALUCtr_temp(1)<=((NOT ALUOp(2))AND (NOT ALUOp(1))) OR (ALUOp(2) AND (NOT func(2))AND(NOT func(0)));
--ALUCtr_temp(0)<=((NOT ALUOp(2))AND ALUOp(0))OR (ALUOp(2) AND (NOT func(3))AND func(2)AND (NOT func(1))AND func(0))OR (ALUOp(2)AND func(3) AND (NOT func(2))AND func(1)AND (NOT func(0)));
ALUCtr_temp(2)<= ((NOT ALUOp(2))AND ALUOp(0)) OR ( ALUOp(2) AND (NOT func(2))AND func(1)AND (NOT func(0)));
ALUCtr_temp(1)<=((NOT ALUOp(2))AND (ALUOp(1) NAND ALUOp(0))) OR (ALUOp(2) AND (NOT func(2))AND(NOT func(0)));
ALUCtr_temp(0)<=(ALUOp(2) AND (NOT func(3))AND func(2)AND (NOT func(1))AND func(0))OR (ALUOp(2)AND func(3) AND (NOT func(2))AND func(1)AND (NOT func(0)));
mux_map_0: mux_3bit port map (sel =>Ffunc,src0=>ALUCtr_sll,src1=>ALUCtr_temp, z=>ALUCtremp);
mux_map_1: mux_3bit port map (sel =>self,src0=>ALUCtremp,src1=>ALUCtr_adu, z=>ALUCtr);


end Structural;



