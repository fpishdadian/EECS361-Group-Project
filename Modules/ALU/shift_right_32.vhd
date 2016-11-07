library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

entity shift_right_32 is
       port (
       sh_in0: in std_logic_vector(31 downto 0);
       sh_in1: in std_logic_vector(31 downto 0);
       sh_out: out std_logic_vector(31 downto 0)
       );
end shift_right_32;

architecture structural of shift_right_32 is

component mux
    port (
      sel   : in  std_logic;
      src0  : in  std_logic;
      src1  : in  std_logic;
      z     : out std_logic
    );
end component mux;

signal b0,b1,b2,b3,b4: std_logic;
signal out_0,out_1,out_2,out_3,out_4: std_logic_vector(31 downto 0);


begin

b0 <= sh_in1(0);
b1 <= sh_in1(1);
b2 <= sh_in1(2);
b3 <= sh_in1(3);
b4 <= sh_in1(4);

u0_00: mux port map(
     sel => b0,
     src0 => sh_in0(0),
     src1 => sh_in0(1),
     z => out_0(0)
     );

u0_01: mux port map(
     sel => b0,
     src0 => sh_in0(1),
     src1 => sh_in0(2),
     z => out_0(1)
     );

u0_02: mux port map(
     sel => b0,
     src0 => sh_in0(2),
     src1 => sh_in0(3),
     z => out_0(2)
     );

u0_03: mux port map(
     sel => b0,
     src0 => sh_in0(3),
     src1 => sh_in0(4),
     z => out_0(3)
     );

u0_04: mux port map(
     sel => b0,
     src0 => sh_in0(4),
     src1 => sh_in0(5),
     z => out_0(4)
     );

u0_05: mux port map(
     sel => b0,
     src0 => sh_in0(5),
     src1 => sh_in0(6),
     z => out_0(5)
     );

u0_06: mux port map(
     sel => b0,
     src0 => sh_in0(6),
     src1 => sh_in0(7),
     z => out_0(6)
     );

u0_07: mux port map(
     sel => b0,
     src0 => sh_in0(7),
     src1 => sh_in0(8),
     z => out_0(7)
     );

u0_08: mux port map(
     sel => b0,
     src0 => sh_in0(8),
     src1 => sh_in0(9),
     z => out_0(8)
     );

u0_09: mux port map(
     sel => b0,
     src0 => sh_in0(9),
     src1 => sh_in0(10),
     z => out_0(9)
     );

u0_10: mux port map(
     sel => b0,
     src0 => sh_in0(10),
     src1 => sh_in0(11),
     z => out_0(10)
     );

u0_11: mux port map(
     sel => b0,
     src0 => sh_in0(11),
     src1 => sh_in0(12),
     z => out_0(11)
     );


u0_12: mux port map(
     sel => b0,
     src0 => sh_in0(12),
     src1 => sh_in0(13),
     z => out_0(12)
     );

u0_13: mux port map(
     sel => b0,
     src0 => sh_in0(13),
     src1 => sh_in0(14),
     z => out_0(13)
     );

u0_14: mux port map(
     sel => b0,
     src0 => sh_in0(14),
     src1 => sh_in0(15),
     z => out_0(14)
     );

u0_15: mux port map(
     sel => b0,
     src0 => sh_in0(15),
     src1 => sh_in0(16),
     z => out_0(15)
     );

u0_16: mux port map(
     sel => b0,
     src0 => sh_in0(16),
     src1 => sh_in0(17),
     z => out_0(16)
     );

u0_17: mux port map(
     sel => b0,
     src0 => sh_in0(17),
     src1 => sh_in0(18),
     z => out_0(17)
     );

u0_18: mux port map(
     sel => b0,
     src0 => sh_in0(18),
     src1 => sh_in0(19),
     z => out_0(18)
     );

u0_19: mux port map(
     sel => b0,
     src0 => sh_in0(19),
     src1 => sh_in0(20),
     z => out_0(19)
     );

u0_20: mux port map(
     sel => b0,
     src0 => sh_in0(20),
     src1 => sh_in0(21),
     z => out_0(20)
     );

u0_21: mux port map(
     sel => b0,
     src0 => sh_in0(21),
     src1 => sh_in0(22),
     z => out_0(21)
     );

u0_22: mux port map(
     sel => b0,
     src0 => sh_in0(22),
     src1 => sh_in0(23),
     z => out_0(22)
     );

u0_23: mux port map(
     sel => b0,
     src0 => sh_in0(23),
     src1 => sh_in0(24),
     z => out_0(23)
     );

u0_24: mux port map(
     sel => b0,
     src0 => sh_in0(24),
     src1 => sh_in0(25),
     z => out_0(24)
     );

u0_25: mux port map(
     sel => b0,
     src0 => sh_in0(25),
     src1 => sh_in0(26),
     z => out_0(25)
     );

u0_26: mux port map(
     sel => b0,
     src0 => sh_in0(26),
     src1 => sh_in0(27),
     z => out_0(26)
     );

u0_27: mux port map(
     sel => b0,
     src0 => sh_in0(27),
     src1 => sh_in0(28),
     z => out_0(27)
     );

u0_28: mux port map(
     sel => b0,
     src0 => sh_in0(28),
     src1 => sh_in0(29),
     z => out_0(28)
     );

u0_29: mux port map(
     sel => b0,
     src0 => sh_in0(29),
     src1 => sh_in0(30),
     z => out_0(29)
     );

u0_30: mux port map(
     sel => b0,
     src0 => sh_in0(30),
     src1 => sh_in0(31),
     z => out_0(30)
     );

u0_31: mux port map(
     sel => b0,
     src0 => sh_in0(31),
     src1 => '0',
     z => out_0(31)
     );

--------------------------------------

u1_00: mux port map(
     sel => b1,
     src0 => out_0(0),
     src1 => out_0(2),
     z => out_1(0)
     );

u1_01: mux port map(
     sel => b1,
     src0 => out_0(1),
     src1 => out_0(3),
     z => out_1(1)
     );

u1_02: mux port map(
     sel => b1,
     src0 => out_0(2),
     src1 => out_0(4),
     z => out_1(2)
     );

u1_03: mux port map(
     sel => b1,
     src0 => out_0(3),
     src1 => out_0(5),
     z => out_1(3)
     );

u1_04: mux port map(
     sel => b1,
     src0 => out_0(4),
     src1 => out_0(6),
     z => out_1(4)
     );

u1_05: mux port map(
     sel => b1,
     src0 => out_0(5),
     src1 => out_0(7),
     z => out_1(5)
     );

u1_06: mux port map(
     sel => b1,
     src0 => out_0(6),
     src1 => out_0(8),
     z => out_1(6)
     );

u1_07: mux port map(
     sel => b1,
     src0 => out_0(7),
     src1 => out_0(9),
     z => out_1(7)
     );

u1_08: mux port map(
     sel => b1,
     src0 => out_0(8),
     src1 => out_0(10),
     z => out_1(8)
     );

u1_09: mux port map(
     sel => b1,
     src0 => out_0(9),
     src1 => out_0(11),
     z => out_1(9)
     );

u1_10: mux port map(
     sel => b1,
     src0 => out_0(10),
     src1 => out_0(12),
     z => out_1(10)
     );

u1_11: mux port map(
     sel => b1,
     src0 => out_0(11),
     src1 => out_0(13),
     z => out_1(11)
     );

u1_12: mux port map(
     sel => b1,
     src0 => out_0(12),
     src1 => out_0(14),
     z => out_1(12)
     );

u1_13: mux port map(
     sel => b1,
     src0 => out_0(13),
     src1 => out_0(15),
     z => out_1(13)
     );

u1_14: mux port map(
     sel => b1,
     src0 => out_0(14),
     src1 => out_0(16),
     z => out_1(14)
     );

u1_15: mux port map(
     sel => b1,
     src0 => out_0(15),
     src1 => out_0(17),
     z => out_1(15)
     );

u1_16: mux port map(
     sel => b1,
     src0 => out_0(16),
     src1 => out_0(18),
     z => out_1(16)
     );

u1_17: mux port map(
     sel => b1,
     src0 => out_0(17),
     src1 => out_0(19),
     z => out_1(17)
     );

u1_18: mux port map(
     sel => b1,
     src0 => out_0(18),
     src1 => out_0(20),
     z => out_1(18)
     );

u1_19: mux port map(
     sel => b1,
     src0 => out_0(19),
     src1 => out_0(21),
     z => out_1(19)
     );

u1_20: mux port map(
     sel => b1,
     src0 => out_0(20),
     src1 => out_0(22),
     z => out_1(20)
     );

u1_21: mux port map(
     sel => b1,
     src0 => out_0(21),
     src1 => out_0(22),
     z => out_1(21)
     );

u1_22: mux port map(
     sel => b1,
     src0 => out_0(22),
     src1 => out_0(23),
     z => out_1(22)
     );

u1_23: mux port map(
     sel => b1,
     src0 => out_0(23),
     src1 => out_0(25),
     z => out_1(23)
     );

u1_24: mux port map(
     sel => b1,
     src0 => out_0(24),
     src1 => out_0(26),
     z => out_1(24)
     );

u1_25: mux port map(
     sel => b1,
     src0 => out_0(25),
     src1 => out_0(27),
     z => out_1(25)
     );

u1_26: mux port map(
     sel => b1,
     src0 => out_0(26),
     src1 => out_0(28),
     z => out_1(26)
     );

u1_27: mux port map(
     sel => b1,
     src0 => out_0(27),
     src1 => out_0(29),
     z => out_1(27)
     );

u1_28: mux port map(
     sel => b1,
     src0 => out_0(28),
     src1 => out_0(30),
     z => out_1(28)
     );

u1_29: mux port map(
     sel => b1,
     src0 => out_0(29),
     src1 => out_0(31),
     z => out_1(29)
     );

u1_30: mux port map(
     sel => b1,
     src0 => out_0(30),
     src1 => '0',
     z => out_1(30)
     );

u1_31: mux port map(
     sel => b1,
     src0 => out_0(31),
     src1 => '0',
     z => out_1(31)
     );

---------------------------------

u2_00: mux port map(
     sel => b2,
     src0 => out_1(0),
     src1 => out_1(4),
     z => out_2(0)
     );

u2_01: mux port map(
     sel => b2,
     src0 => out_1(1),
     src1 => out_1(5),
     z => out_2(1)
     );

u2_02: mux port map(
     sel => b2,
     src0 => out_1(2),
     src1 => out_1(6),
     z => out_2(2)
     );

u2_03: mux port map(
     sel => b2,
     src0 => out_1(3),
     src1 => out_1(7),
     z => out_2(3)
     );

u2_04: mux port map(
     sel => b2,
     src0 => out_1(4),
     src1 => out_1(8),
     z => out_2(4)
     );

u2_05: mux port map(
     sel => b2,
     src0 => out_1(5),
     src1 => out_1(9),
     z => out_2(5)
     );

u2_06: mux port map(
     sel => b2,
     src0 => out_1(6),
     src1 => out_1(10),
     z => out_2(6)
     );

u2_07: mux port map(
     sel => b2,
     src0 => out_1(7),
     src1 => out_1(11),
     z => out_2(7)
     );

u2_08: mux port map(
     sel => b2,
     src0 => out_1(8),
     src1 => out_1(12),
     z => out_2(8)
     );

u2_09: mux port map(
     sel => b2,
     src0 => out_1(9),
     src1 => out_1(13),
     z => out_2(9)
     );

u2_10: mux port map(
     sel => b2,
     src0 => out_1(10),
     src1 => out_1(14),
     z => out_2(10)
     );

u2_11: mux port map(
     sel => b2,
     src0 => out_1(11),
     src1 => out_1(15),
     z => out_2(11)
     );

u2_12: mux port map(
     sel => b2,
     src0 => out_1(12),
     src1 => out_1(16),
     z => out_2(12)
     );

u2_13: mux port map(
     sel => b2,
     src0 => out_1(13),
     src1 => out_1(17),
     z => out_2(13)
     );

u2_14: mux port map(
     sel => b2,
     src0 => out_1(14),
     src1 => out_1(18),
     z => out_2(14)
     );

u2_15: mux port map(
     sel => b2,
     src0 => out_1(15),
     src1 => out_1(19),
     z => out_2(15)
     );

u2_16: mux port map(
     sel => b2,
     src0 => out_1(16),
     src1 => out_1(20),
     z => out_2(16)
     );

u2_17: mux port map(
     sel => b2,
     src0 => out_1(17),
     src1 => out_1(21),
     z => out_2(17)
     );

u2_18: mux port map(
     sel => b2,
     src0 => out_1(18),
     src1 => out_1(22),
     z => out_2(18)
     );

u2_19: mux port map(
     sel => b2,
     src0 => out_1(19),
     src1 => out_1(23),
     z => out_2(19)
     );

u2_20: mux port map(
     sel => b2,
     src0 => out_1(20),
     src1 => out_1(24),
     z => out_2(20)
     );

u2_21: mux port map(
     sel => b2,
     src0 => out_1(21),
     src1 => out_1(25),
     z => out_2(21)
     );

u2_22: mux port map(
     sel => b2,
     src0 => out_1(22),
     src1 => out_1(26),
     z => out_2(22)
     );

u2_23: mux port map(
     sel => b2,
     src0 => out_1(23),
     src1 => out_1(27),
     z => out_2(23)
     );

u2_24: mux port map(
     sel => b2,
     src0 => out_1(24),
     src1 => out_1(28),
     z => out_2(24)
     );

u2_25: mux port map(
     sel => b2,
     src0 => out_1(25),
     src1 => out_1(29),
     z => out_2(25)
     );

u2_26: mux port map(
     sel => b2,
     src0 => out_1(26),
     src1 => out_1(30),
     z => out_2(26)
     );

u2_27: mux port map(
     sel => b2,
     src0 => out_1(27),
     src1 => out_1(31),
     z => out_2(27)
     );

u2_28: mux port map(
     sel => b2,
     src0 => out_1(28),
     src1 => '0',
     z => out_2(28)
     );

u2_29: mux port map(
     sel => b2,
     src0 => out_1(29),
     src1 => '0',
     z => out_2(29)
     );

u2_30: mux port map(
     sel => b2,
     src0 => out_1(30),
     src1 => '0',
     z => out_2(30)
     );

u2_31: mux port map(
     sel => b2,
     src0 => out_1(31),
     src1 => '0',
     z => out_2(31)
     );

----------------------------------

u3_00: mux port map(
     sel => b3,
     src0 => out_2(0),
     src1 => out_2(8),
     z => out_3(0)
     );

u3_01: mux port map(
     sel => b3,
     src0 => out_2(1),
     src1 => out_2(9),
     z => out_3(1)
     );

u3_02: mux port map(
     sel => b3,
     src0 => out_2(2),
     src1 => out_2(10),
     z => out_3(2)
     );

u3_03: mux port map(
     sel => b3,
     src0 => out_2(3),
     src1 => out_2(11),
     z => out_3(3)
     );

u3_04: mux port map(
     sel => b3,
     src0 => out_2(4),
     src1 => out_2(12),
     z => out_3(4)
     );

u3_05: mux port map(
     sel => b3,
     src0 => out_2(5),
     src1 => out_2(13),
     z => out_3(5)
     );

u3_06: mux port map(
     sel => b3,
     src0 => out_2(6),
     src1 => out_2(14),
     z => out_3(6)
     );

u3_07: mux port map(
     sel => b3,
     src0 => out_2(7),
     src1 => out_2(15),
     z => out_3(7)
     );

u3_08: mux port map(
     sel => b3,
     src0 => out_2(8),
     src1 => out_2(16),
     z => out_3(8)
     );

u3_09: mux port map(
     sel => b3,
     src0 => out_2(9),
     src1 => out_2(17),
     z => out_3(9)
     );

u3_10: mux port map(
     sel => b3,
     src0 => out_2(10),
     src1 => out_2(18),
     z => out_3(10)
     );

u3_11: mux port map(
     sel => b3,
     src0 => out_2(11),
     src1 => out_2(19),
     z => out_3(11)
     );

u3_12: mux port map(
     sel => b3,
     src0 => out_2(12),
     src1 => out_2(20),
     z => out_3(12)
     );

u3_13: mux port map(
     sel => b3,
     src0 => out_2(13),
     src1 => out_2(21),
     z => out_3(13)
     );

u3_14: mux port map(
     sel => b3,
     src0 => out_2(14),
     src1 => out_2(22),
     z => out_3(14)
     );

u3_15: mux port map(
     sel => b3,
     src0 => out_2(15),
     src1 => out_2(23),
     z => out_3(15)
     );

u3_16: mux port map(
     sel => b3,
     src0 => out_2(16),
     src1 => out_2(24),
     z => out_3(16)
     );

u3_17: mux port map(
     sel => b3,
     src0 => out_2(17),
     src1 => out_2(25),
     z => out_3(17)
     );


u3_18: mux port map(
     sel => b3,
     src0 => out_2(18),
     src1 => out_2(26),
     z => out_3(18)
     );

u3_19: mux port map(
     sel => b3,
     src0 => out_2(19),
     src1 => out_2(27),
     z => out_3(19)
     );


u3_20: mux port map(
     sel => b3,
     src0 => out_2(20),
     src1 => out_2(28),
     z => out_3(20)
     );

u3_21: mux port map(
     sel => b3,
     src0 => out_2(21),
     src1 => out_2(29),
     z => out_3(21)
     );

u3_22: mux port map(
     sel => b3,
     src0 => out_2(22),
     src1 => out_2(30),
     z => out_3(22)
     );

u3_23: mux port map(
     sel => b3,
     src0 => out_2(23),
     src1 => out_2(31),
     z => out_3(23)
     );


u3_24: mux port map(
     sel => b3,
     src0 => out_2(24),
     src1 => '0',
     z => out_3(24)
     );

u3_25: mux port map(
     sel => b3,
     src0 => out_2(25),
     src1 => '0',
     z => out_3(25)
     );

u3_26: mux port map(
     sel => b3,
     src0 => out_2(26),
     src1 => '0',
     z => out_3(26)
     );

u3_27: mux port map(
     sel => b3,
     src0 => out_2(27),
     src1 => '0',
     z => out_3(27)
     );

u3_28: mux port map(
     sel => b3,
     src0 => out_2(28),
     src1 => '0',
     z => out_3(28)
     );

u3_29: mux port map(
     sel => b3,
     src0 => out_2(29),
     src1 => '0',
     z => out_3(29)
     );

u3_30: mux port map(
     sel => b3,
     src0 => out_2(30),
     src1 => '0',
     z => out_3(30)
     );

u3_31: mux port map(
     sel => b3,
     src0 => out_2(31),
     src1 => '0',
     z => out_3(31)
     );

----------------------------------

u4_00: mux port map(
     sel => b4,
     src0 => out_3(0),
     src1 => out_3(16),
     z => out_4(0)
     );

u4_01: mux port map(
     sel => b4,
     src0 => out_3(1),
     src1 => out_3(17),
     z => out_4(1)
     );

u4_02: mux port map(
     sel => b4,
     src0 => out_3(2),
     src1 => out_3(18),
     z => out_4(2)
     );

u4_03: mux port map(
     sel => b4,
     src0 => out_3(3),
     src1 => out_3(19),
     z => out_4(3)
     );

u4_04: mux port map(
     sel => b4,
     src0 => out_3(4),
     src1 => out_3(20),
     z => out_4(4)
     );

u4_05: mux port map(
     sel => b4,
     src0 => out_3(5),
     src1 => out_3(21),
     z => out_4(5)
     );

u4_06: mux port map(
     sel => b4,
     src0 => out_3(6),
     src1 => out_3(22),
     z => out_4(6)
     );

u4_07: mux port map(
     sel => b4,
     src0 => out_3(7),
     src1 => out_3(23),
     z => out_4(7)
     );

u4_08: mux port map(
     sel => b4,
     src0 => out_3(8),
     src1 => out_3(24),
     z => out_4(8)
     );

u4_09: mux port map(
     sel => b4,
     src0 => out_3(9),
     src1 => out_3(25),
     z => out_4(9)
     );

u4_10: mux port map(
     sel => b4,
     src0 => out_3(10),
     src1 => out_3(26),
     z => out_4(10)
     );

u4_11: mux port map(
     sel => b4,
     src0 => out_3(11),
     src1 => out_3(27),
     z => out_4(11)
     );

u4_12: mux port map(
     sel => b4,
     src0 => out_3(12),
     src1 => out_3(28),
     z => out_4(12)
     );

u4_13: mux port map(
     sel => b4,
     src0 => out_3(13),
     src1 => out_3(29),
     z => out_4(13)
     );

u4_14: mux port map(
     sel => b4,
     src0 => out_3(14),
     src1 => out_3(30),
     z => out_4(14)
     );

u4_15: mux port map(
     sel => b4,
     src0 => out_3(15),
     src1 => out_3(31),
     z => out_4(15)
     );

u4_16: mux port map(
     sel => b4,
     src0 => out_3(16),
     src1 => '0',
     z => out_4(16)
     );

u4_17: mux port map(
     sel => b4,
     src0 => out_3(17),
     src1 => '0',
     z => out_4(17)
     );

u4_18: mux port map(
     sel => b4,
     src0 => out_3(18),
     src1 => '0',
     z => out_4(18)
     );

u4_19: mux port map(
     sel => b4,
     src0 => out_3(19),
     src1 => '0',
     z => out_4(19)
     );

u4_20: mux port map(
     sel => b4,
     src0 => out_3(20),
     src1 => '0',
     z => out_4(20)
     );

u4_21: mux port map(
     sel => b4,
     src0 => out_3(21),
     src1 => '0',
     z => out_4(21)
     );

u4_22: mux port map(
     sel => b4,
     src0 => out_3(22),
     src1 => '0',
     z => out_4(22)
     );

u4_23: mux port map(
     sel => b4,
     src0 => out_3(23),
     src1 => '0',
     z => out_4(23)
     );

u4_24: mux port map(
     sel => b4,
     src0 => out_3(24),
     src1 => '0',
     z => out_4(24)
     );

u4_25: mux port map(
     sel => b4,
     src0 => out_3(25),
     src1 => '0',
     z => out_4(25)
     );

u4_26: mux port map(
     sel => b4,
     src0 => out_3(26),
     src1 => '0',
     z => out_4(26)
     );

u4_27: mux port map(
     sel => b4,
     src0 => out_3(27),
     src1 => '0',
     z => out_4(27)
     );

u4_28: mux port map(
     sel => b4,
     src0 => out_3(28),
     src1 => '0',
     z => out_4(28)
     );

u4_29: mux port map(
     sel => b4,
     src0 => out_3(29),
     src1 => '0',
     z => out_4(29)
     );

u4_30: mux port map(
     sel => b4,
     src0 => out_3(30),
     src1 => '0',
     z => out_4(30)
     );

u4_31: mux port map(
     sel => b4,
     src0 => out_3(31),
     src1 => '0',
     z => out_4(31)
     );


sh_out <= out_4;


   
end structural;