library IEEE;
library work;
use work.gate_package.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity carry_look_ahead is
	port ( A 	 : in  std_logic_vector (7 downto 0);
		   B 	 : in  std_logic_vector (7 downto 0);
		   C_in  : in  std_logic;
		   S 	 : out std_logic_vector (7 downto 0);
		   C_out : out std_logic);
end entity;
 
architecture arch of carry_look_ahead is
 
component partial_full_adder
	port ( A : in  std_logic;	
		   B : in  std_logic;
		   C : in  std_logic;
		   P : out std_logic;
		   S : out std_logic;
		   G : out std_logic);
end component;

signal C_in1,C1,C2,C3,C4,C5,C6,C7 : std_logic;
signal P,G   : std_logic_vector(7 downto 0);
signal not_B : std_logic_vector(7 downto 0); 

	begin
--Port Mapping

--for 1's complement	
B0 : inverter port map (I => B(0), O => not_B(0));
B1 : inverter port map (I => B(1), O => not_B(1));
B2 : inverter port map (I => B(2), O => not_B(2));
B3 : inverter port map (I => B(3), O => not_B(3));
B4 : inverter port map (I => B(4), O => not_B(4));
B5 : inverter port map (I => B(5), O => not_B(5));
B6 : inverter port map (I => B(6), O => not_B(6));
B7 : inverter port map (I => B(7), O => not_B(7));

PFA0  : partial_full_adder port map (A => A(0), B => not_B(0),C => C_in1, P => P(0), S => S(0), G => G(0)); 	
PFA1  : partial_full_adder port map (A => A(1), B => not_B(1),C => C1, 	 P => P(1), S => S(1), G => G(1)); 	
PFA2  : partial_full_adder port map (A => A(2), B => not_B(2),C => C2, 	 P => P(2), S => S(2), G => G(2)); 	
PFA3  : partial_full_adder port map (A => A(3), B => not_B(3),C => C3, 	 P => P(3), S => S(3), G => G(3)); 	
PFA4  : partial_full_adder port map (A => A(4), B => not_B(4),C => C4, 	 P => P(4), S => S(4), G => G(4)); 	
PFA5  : partial_full_adder port map (A => A(5), B => not_B(5),C => C5, 	 P => P(5), S => S(5), G => G(5)); 	
PFA6  : partial_full_adder port map (A => A(6), B => not_B(6),C => C6, 	 P => P(6), S => S(6), G => G(6)); 	
PFA7  : partial_full_adder port map (A => A(7), B => not_B(7),C => C7, 	 P => P(7), S => S(7), G => G(7)); 	

--CLA Circuit Functions









--for 2's complement
C_in1 <= '1';




end architecture;
	