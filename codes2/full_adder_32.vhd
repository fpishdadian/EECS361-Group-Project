--full adder 32 bit
--Shuyue Zheng

library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity full_adder_32 is
  port (   A        : in std_logic_vector(31 downto 0);
           B        : in std_logic_vector(31 downto 0);
		   ctrlsig  : in std_logic_vector(1 downto 0);
		   cout     : out std_logic_vector(0 downto 0);
		   sum      : out std_logic_vector(31 downto 0);
		   overflow : out std_logic_vector(0 downto 0)
      );
	end full_adder_32;
	
architecture structral of full_adder_32 is
signal not_B : std_logic_vector(31 downto 0);
signal B_sel : std_logic_vector(31 downto 0);
signal sum0  : std_logic_vector(31 downto 0);
signal sum1  : std_logic_vector(31 downto 0);
signal and0 : std_logic_vector(31 downto 0);
signal and1 : std_logic_vector(31 downto 0);
signal and2 : std_logic_vector(31 downto 0);
signal or0  : std_logic_vector(31 downto 0);
signal cout0 : std_logic_vector(31 downto 0);
signal c_out : std_logic_vector(32 downto 0);


  component and_gate
    port (
      x : in std_logic;
      y : in std_logic;
      z : out std_logic
    );
  end component and_gate;
  
 component or_gate
    port (
      x : in std_logic;
      y : in std_logic;
      z : out std_logic
    );
  end component or_gate;
  
  component xor_gate
    port (
      x : in std_logic;
      y : in std_logic;
      z : out std_logic
    );
  end component xor_gate;
  
  component not_gate_32
    port (
      x : in std_logic_vector(31 downto 0);
      z : out std_logic_vector(31 downto 0)
    );
  end component not_gate_32;
  
  component mux_32
    port (
      sel   : in  std_logic;
      src0  : in  std_logic_vector(31 downto 0);
      src1  : in  std_logic_vector(31 downto 0);
      z	    : out std_logic_vector(31 downto 0)
    );
  end component mux_32;
  
  begin
  b_inverter: not_gate_32 port map(B, not_B);
  add_sub_sel: mux_32 port map(sel=>ctrlsig(1), src0(31 downto 0)=>B(31 downto 0), 
            src1(31 downto 0)=>not_B(31 downto 0), z(31 downto 0)=>B_sel(31 downto 0));
  c_out(0)<=ctrlsig(0);--cin
	
 
  G1: for i in 0 to 31 generate
      sum_0: xor_gate port map(x=>A(i), y=>B_sel(i), z=>sum0(i));
	  sum_1: xor_gate port map(x=>sum0(i), y=>c_out(i), z=>sum1(i));
	  
	  cout_0: and_gate port map(x=>A(i), y=>B_sel(i), z=>and0(i));
	  cout_1: and_gate port map(x=>A(i), y=>c_out(i), z=>and1(i));
	  cout_2: and_gate port map(x=>B_sel(i), y=>c_out(i), z=>and2(i));
	  cout_3: or_gate port map(x=>and0(i), y=>and1(i), z=>or0(i));
	  cout_4: or_gate port map(x=>and2(i), y=>or0(i), z=>c_out(i+1));
   end generate G1;
	  
	  overflow_1 : xor_gate port map(x=>c_out(32), y=>c_out(31), z=>overflow(0));
	  
	  cout(0) <= c_out(32);
	  sum <= sum1;
	  
end structral;