--control+datapath

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.eecs361_gates.all;

entity processor is
port(  instr   : in std_logic_vector(31 downto 0);
       clk     : in std_logic;
	   arst    : in std_logic;
	   data_in : in std_logic_vector(31 downto 0);
	   instr_addr  : out std_logic_vector(29 downto 0);
	   data_addr   : out std_logic_vector(31 downto 0);
	   data_out    : out std_logic_vector(31 downto 0)
);
end processor;

architecture structural of processor is
signal      sig_RegWrt   :  std_logic;
signal	   sig_ALUsrc   :  std_logic;
 signal     sig_RegDst   :  std_logic;
 signal     sig_MemtoReg :  std_logic;
 signal     sig_MemWrt   :  std_logic;
 signal     sig_branch   :  std_logic;
 signal     sig_Extop    :  std_logic;
signal      sig_ALUctr   :  std_logic_vector(3 downto 0);


component datapath
port(  instr   : in std_logic_vector(31 downto 0);
       clk     : in std_logic;
	   arst    : in std_logic;
	   data_in : in std_logic_vector(31 downto 0);
	   --control
	   RegWrt : in std_logic;
       ALUsrc :in std_logic;
       RegDst :in std_logic;
       --MemtoReg : in std_logic;
       --MemWrt : in std_logic;
       branch : in std_logic;
       Extop : in std_logic;
       ALUctr : in std_logic_vector(3 downto 0);
	   
	   instr_addr  : out std_logic_vector(29 downto 0);
	   data_addr   : out std_logic_vector(31 downto 0);
	   data_out    : out std_logic_vector(31 downto 0)
);
end component;

component control
port (op       : in std_logic_vector(5 downto 0);
      func     : in std_logic_vector(5 downto 0);
	  RegWrt   : out std_logic;
	  ALUsrc   : out std_logic;
      RegDst   : out std_logic;
      MemtoReg : out std_logic;
      MemWrt   : out std_logic;
      branch   : out std_logic;
      Extop    : out std_logic;
      ALUctr   : out std_logic_vector(3 downto 0));
end component;

begin
datapath_map: datapath port map(instr => instr, clk => clk,  arst => arst,
                    data_in => data_in, RegWrt => sig_RegWrt, ALUsrc => sig_ALUsrc,
					RegDst => sig_RegDst, branch => sig_branch, Extop => sig_Extop,
					ALUctr => sig_ALUctr, instr_addr => instr_addr, data_addr => data_addr,
					data_out => data_out);
control_map: control port map(op => instr(31 downto 26), func => instr(5 downto 0),
                    RegWrt => sig_RegWrt, ALUsrc => sig_ALUsrc, RegDst => sig_RegDst,
					branch => sig_branch, Extop => sig_Extop, ALUctr => sig_ALUctr);
end structural;
					
					
