--Define a new data type: an array wich can store several std_logic_vector(31 downto 0)
library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

package data_type is

type src_type is array (natural range <>) of std_logic_vector(31 downto 0);

end data_type;
