library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
entity RegFile is
  port(
    clk		: in  std_logic;
    arst	: in  std_logic;
    aload	: in  std_logic;
    busW       	: in  std_logic_vector(31 downto 0);
    RegWr	: in  std_logic;
    RegDst	: in  std_logic;
    Rs		: in  std_logic_vector(4 downto 0);
    Rt     	: in  std_logic_vector(4 downto 0);
    Rd     	: in  std_logic_vector(4 downto 0);
    busA        : out std_logic_vector(31 downto 0);
    busB        : out std_logic_vector(31 downto 0)
    );
end RegFile;
architecture structural of RegFile is
type RWtemp is array(31 downto 0) of std_logic_vector(31 downto 0);
--type RWtemp is array(31 downto 0 , 31 downto 0) of std_logic;
signal zero: std_logic_vector(31 downto 0);
signal dec_out: std_logic_vector(31 downto 0);
signal and_out: std_logic_vector(31 downto 0);
signal Rw_in: std_logic_vector(4 downto 0);
signal RWtempsignal:RWtemp;
signal RWtempsignal_tempA_1:RWtemp;
signal RWtempsignal_tempA_2:RWtemp;
signal RWtempsignal_tempA_3:RWtemp;
signal RWtempsignal_tempA_4:RWtemp;
signal RWA_1:RWtemp;
signal RWA_2:RWtemp;
signal RWA_3:RWtemp;
signal RWA_4:RWtemp;
signal RWtempsignal_tempB_1:RWtemp;
signal RWtempsignal_tempB_2:RWtemp;
signal RWtempsignal_tempB_3:RWtemp;
signal RWtempsignal_tempB_4:RWtemp;
signal RWB_1:RWtemp;
signal RWB_2:RWtemp;
signal RWB_3:RWtemp;
signal RWB_4:RWtemp;
	component dffr_32bit is
  		port (
			clk	: in  std_logic;
			d	: in  std_logic_vector(31 downto 0);
			q	: out std_logic_vector(31 downto 0)
 			 );
	end component;
	component dffr_a_32bit is
  		port (
			clk	   : in  std_logic;
    			arst   : in  std_logic;
    			aload  : in  std_logic;
    			adata  : in  std_logic_vector(31 downto 0);
			d	: in  std_logic_vector(31 downto 0);
   			enable : in  std_logic;
			q	   : out std_logic_vector(31 downto 0)
 			 );
	end component;
	component dec_32 is
  		port (
   			 src	: in std_logic_vector(4 downto 0);
   			 z	: out std_logic_vector(31 downto 0)
  			);
	end component;
	component mux_5 is
 		 port (
			sel   : in  std_logic;
			src0  : in  std_logic_vector(4 downto 0);
			src1  : in  std_logic_vector(4 downto 0);
			z	    : out std_logic_vector(4 downto 0)
  			);
		end component;
	component mux_32to1 is
  		port (
			sel   : in  std_logic_vector(4 downto 0);
			src  : in  std_logic_vector(31 downto 0);
			z	    : out std_logic
 			 );
	end component;
	component mux_32 is
	  port (
		sel   : in  std_logic;
		src0  : in  std_logic_vector(31 downto 0);
		src1  : in  std_logic_vector(31 downto 0);
		z	    : out std_logic_vector(31 downto 0)
  	);
	end component;
begin
zero <= "00000000000000000000000000000000";
RWtempsignal(0)<=zero;
mux_5bit: mux_5 port map (sel =>RegDst,src0=>Rt ,src1=>Rd ,z=>Rw_in); 
decmap: dec_32 port map (src =>Rw_in, z=>dec_out);
GEN_REG_clk: 
for I in 0 to 31 generate
	and0_map : and_gate port map (x => RegWr, y => dec_out(I), z => and_out(I));
end generate GEN_REG_clk;
GEN_REG_diff:
for I in 1 to 31 generate
	dffr_map : dffr_a_32bit port map
  		 (
			clk => clk,
   			arst => arst,
    			aload => aload,
   			adata => zero,
			d =>busW,
    			enable => and_out(I),
			q =>RWtempsignal(I)
 		);
end generate GEN_REG_diff;
RWtempsignal_tempA_1 (15 downto 0) <=RWtempsignal(31 downto 16);
GEN_REG_A:
for J in 0 to 15 generate
	mux_sel0: mux_32 port map (
					sel => Rs(4),
					src0 =>RWtempsignal(J),
					src1 => RWtempsignal_tempA_1(J),
					z => RWA_1(J)
					);	
end generate GEN_REG_A;
RWtempsignal_tempA_2 (7 downto 0) <=RWA_1(15 downto 8);
GEN_REG_B:
for J in 0 to 7 generate
	mux_sel1: mux_32 port map (
					sel => Rs(3),
					src0 =>RWA_1(J),
					src1 => RWtempsignal_tempA_2(J),
					z => RWA_2(J)
					);	
end generate GEN_REG_B;
RWtempsignal_tempA_3 (3 downto 0) <= RWA_2(7 downto 4);
GEN_REG_C:
for J in 0 to 3 generate
	mux_sel2: mux_32 port map (
					sel => Rs(2),
					src0 =>RWA_2(J),
					src1 => RWtempsignal_tempA_3(J),
					z => RWA_3(J)
					);	
end generate GEN_REG_C;
RWtempsignal_tempA_4 (1 downto 0) <=RWA_3(3 downto 2);
GEN_REG_D:
for J in 0 to 1 generate
	mux_sel3: mux_32 port map (
					sel => Rs(1),
					src0 =>RWA_3(J),
					src1 => RWtempsignal_tempA_4(J),
					z => RWA_4(J)
					);	
end generate GEN_REG_D;
mux_sel4: mux_32 port map (
				sel => Rs(0),
				src0 =>RWA_4(0),
				src1 => RWA_4(1),
				z => busA
				);	
---------------busB----------------------
RWtempsignal_tempB_1 (15 downto 0) <=RWtempsignal(31 downto 16);
GEN_REG_B1:
for J in 0 to 15 generate
	mux_selB1: mux_32 port map (
					sel => Rt(4),
					src0 =>RWtempsignal(J),
					src1 => RWtempsignal_tempB_1(J),
					z => RWB_1(J)
					);	
end generate GEN_REG_B1;
RWtempsignal_tempB_2 (7 downto 0) <=RWB_1(15 downto 8);
GEN_REG_B2:
for J in 0 to 7 generate
	mux_selB2: mux_32 port map (
					sel => Rt(3),
					src0 =>RWB_1(J),
					src1 => RWtempsignal_tempB_2(J),
					z => RWB_2(J)
					);	
end generate GEN_REG_B2;
RWtempsignal_tempB_3 (3 downto 0) <= RWB_2(7 downto 4);
GEN_REG_B3:
for J in 0 to 3 generate
	mux_selB2: mux_32 port map (
					sel => Rt(2),
					src0 =>RWB_2(J),
					src1 => RWtempsignal_tempB_3(J),
					z => RWB_3(J)
					);	
end generate GEN_REG_B3;
RWtempsignal_tempB_4 (1 downto 0) <=RWB_3(3 downto 2);
GEN_REG_B4:
for J in 0 to 1 generate
	mux_selB3: mux_32 port map (
					sel => Rt(1),
					src0 =>RWB_3(J),
					src1 => RWtempsignal_tempB_4(J),
					z => RWB_4(J)
					);	
end generate GEN_REG_B4;
mux_selB4: mux_32 port map (
				sel => Rt(0),
				src0 =>RWB_4(0),
				src1 => RWB_4(1),
				z => busB
				);	
end architecture structural; 
