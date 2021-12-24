LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Tb_Carry_Look_Ahead IS
END Tb_Carry_Look_Ahead;
 
ARCHITECTURE behavior OF Tb_Carry_Look_Ahead IS
 
-- Component Declaration for the Unit Under Test (UUT)
 
COMPONENT Carry_Look_Ahead
PORT(
A : IN std_logic_vector(7 downto 0);
B : IN std_logic_vector(7 downto 0);
C_in : IN std_logic;
S : OUT std_logic_vector(7 downto 0);
C_out : OUT std_logic
);
END COMPONENT;
 
--Inputs
signal A : std_logic_vector(7 downto 0) := (others => '0');
signal B : std_logic_vector(7 downto 0) := (others => '0');
signal Cin : std_logic := '0';
 
--Outputs
signal S : std_logic_vector(7 downto 0);
signal Cout : std_logic;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: Carry_Look_Ahead PORT MAP (
A => A,
B => B,
C_in => Cin,
S => S,
C_out => Cout
);
 
-- Stimulus process
stim_proc: process
begin
-- hold reset state for 100 ns.
wait for 1000 ns;
 
A <= "11110000";
B <= "11110001";
Cin <= '1';
 
wait for 500 ns;
 
A <= "10101010";
B <= "00110101";
Cin <= '0';
 
wait for 500 ns;
 
A <= "10001000";
B <= "10011001";
Cin <= '0';
 
wait;
 
end process;
 
END;
