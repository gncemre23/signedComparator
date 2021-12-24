LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
 
ENTITY tb_comparator IS
END tb_comparator;
 
ARCHITECTURE behavior OF tb_comparator IS
 
-- Component Declaration for the Unit Under Test (UUT)
 
--Inputs
signal A : signed(7 downto 0) := (others => '0');
signal B : signed(7 downto 0) := (others => '0');

 
--Outputs
signal a_gt_b : std_logic := '0';
signal a_lt_b : std_logic := '0';
signal a_eq_b : std_logic := '0';
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: entity work.stage_2_comp PORT MAP (
A => std_logic_vector(A),
B => std_logic_vector(B),
a_gt_b_o => a_gt_b,
a_lt_b_o => a_lt_b,
a_eq_b_o => a_eq_b
);
 
-- Stimulus process
stim_proc: process
begin
-- hold reset state for 100 ns.
wait for 1000 ns;
 
A <= to_signed(-25,8);
B <= to_signed(-25,8);

wait for 500 ns;
 
A <= to_signed(-48,8);
B <= to_signed(125,8);

wait for 500 ns;
 
A <= to_signed(55,8);
B <= to_signed(25,8);
 
wait for 500 ns;

A <= to_signed(-86,8);
B <= to_signed(-127,8);

wait for 500 ns;

A <= to_signed(96,8);
B <= to_signed(127,8);

wait for 500 ns;

A <= to_signed(10,8);
B <= to_signed(10,8);
 
wait;
 
end process;
 
END;
