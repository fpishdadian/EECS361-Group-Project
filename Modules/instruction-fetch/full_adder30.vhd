--full adder 30 bit
--Shuyue Zheng

library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity full_adder30 is
  port (   A        : in std_logic_vector(29 downto 0);
           B        : in std_logic_vector(29 downto 0);
		   ctrlsig  : in std_logic;
		   sum      : out std_logic_vector(29 downto 0)
		   
      );
	end full_adder30;
	
architecture structral of full_adder30 is
signal not_B : std_logic_vector(29 downto 0);
signal B_sel : std_logic_vector(29 downto 0);
signal sum0  : std_logic_vector(29 downto 0);
signal sum1  : std_logic_vector(29 downto 0);
signal and0 : std_logic_vector(29 downto 0);
signal and1 : std_logic_vector(29 downto 0);
signal and2 : std_logic_vector(29 downto 0);
signal or0  : std_logic_vector(29 downto 0);
signal cout0 : std_logic_vector(29 downto 0);
signal c_out : std_logic_vector(30 downto 0);


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
  
  component not_gate_30
    port (
      x : in std_logic_vector(29 downto 0);
      z : out std_logic_vector(29 downto 0)
    );
  end component not_gate_30;
  
  component mux_30
    port (
      sel   : in  std_logic;
      src0  : in  std_logic_vector(29 downto 0);
      src1  : in  std_logic_vector(29 downto 0);
      z	    : out std_logic_vector(29 downto 0)
    );
  end component mux_30;
  
  begin
  b_inverter: not_gate_30 port map(B, not_B);
  add_sub_sel: mux_30 port map(sel=>ctrlsig, src0(29 downto 0)=>B(29 downto 0), 
            src1(29 downto 0)=>not_B(29 downto 0), z(29 downto 0)=>B_sel(29 downto 0));
  c_out(0)<=ctrlsig;--cin
	
 
  G1: for i in 0 to 29 generate
      sum_0: xor_gate port map(x=>A(i), y=>B_sel(i), z=>sum0(i));
	  sum_1: xor_gate port map(x=>sum0(i), y=>c_out(i), z=>sum1(i));
	  
	  cout_0: and_gate port map(x=>A(i), y=>B_sel(i), z=>and0(i));
	  cout_1: and_gate port map(x=>A(i), y=>c_out(i), z=>and1(i));
	  cout_2: and_gate port map(x=>B_sel(i), y=>c_out(i), z=>and2(i));
	  cout_3: or_gate port map(x=>and0(i), y=>and1(i), z=>or0(i));
	  cout_4: or_gate port map(x=>and2(i), y=>or0(i), z=>c_out(i+1));
   end generate G1;
	  
	  sum <= sum1;
	  
end structral;