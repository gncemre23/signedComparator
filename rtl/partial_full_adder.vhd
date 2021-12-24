library IEEE;
library work;
use work.gate_package.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity partial_full_adder is
	port(	A 	  : in  std_logic;	
			B 	  : in  std_logic;
			C	  : in  std_logic;
			P 	  : out std_logic;
			S	  : out std_logic;
			G	  : out std_logic
	);

end entity;

architecture arch of partial_full_adder is
--Signals	
	signal A_in,B_in,xor1_out,C_xor2,xor2_out,and1_out : std_logic;
	
	begin
--Port Mapping		
xor1 : xor_gate port map (I_0 => A_in, I_1 => B_in, O => xor1_out);
xor2 : xor_gate port map (I_0 => xor1_out, I_1 => C_xor2, O => xor2_out);
and1 : and_gate port map (I_0 => A_in, I_1 => B_in, O => and1_out);

--Final Assigns
A <= A_in;
B <= B_in;
C <= C_xor2;
P <= xor1_out; 
S <= xor2_out;
G <= and1_out;

end architecture;