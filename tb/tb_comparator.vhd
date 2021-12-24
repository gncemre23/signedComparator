library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_signed.all;

entity tb_comparator is
end tb_comparator;

architecture behavior of tb_comparator is

  -- Component Declaration for the Unit Under Test (UUT)

  constant verify_stage1 : boolean := true;
  constant verify_stage2 : boolean := false;

  --Inputs
  signal A : signed(7 downto 0) := (others => '0');
  signal B : signed(7 downto 0) := (others => '0');

  signal A_reg : signed(7 downto 0);
  signal B_reg : signed(7 downto 0);
  --Outputs
  signal a_gt_b : std_logic := '0';
  signal a_lt_b : std_logic := '0';
  signal a_eq_b : std_logic := '0';

  signal a_gt_b_reg  : std_logic := '0';
  signal a_lt_b_reg  : std_logic := '0';
  signal a_eq_b_reg  : std_logic := '0';
  signal stable      : std_logic := '0';
  signal clk_ena     : boolean   := false;
  signal clk_ena_chk : boolean   := false;
  signal clk         : std_logic := '0';
  signal clk_chk     : std_logic := '0';
begin

  -- Instantiate the Unit Under Test (UUT)
  stage1_gen : if verify_stage1 generate
    uut : entity work.stage_1_comp port map (
      A      => std_logic_vector(A_reg),
      B      => std_logic_vector(B_reg),
      a_gt_b => a_gt_b,
      a_lt_b => a_lt_b,
      a_eq_b => a_eq_b
      );
  end generate;
  stage2_gen : if verify_stage2 generate
    uut : entity work.stage_2_comp port map (
      A        => std_logic_vector(A_reg),
      B        => std_logic_vector(B_reg),
      a_gt_b_o => a_gt_b,
      a_lt_b_o => a_lt_b,
      a_eq_b_o => a_eq_b
      );
  end generate;
  clk     <= not clk after 200 ns when clk_ena else '0';
  clk_chk <= not clk_chk after 200 ns when clk_ena_chk else '0';
  process (clk)
  begin
    if rising_edge(clk) then
      a_gt_b_reg <= a_gt_b;
      a_lt_b_reg <= a_lt_b;
      a_eq_b_reg <= a_eq_b;
    end if;
  end process;

  process (clk)
  begin
    if falling_edge(clk) then
      A_reg <= A;
      B_reg <= B;
    end if;
  end process;
  checker : process (clk_chk)
  begin
    if rising_edge(clk_chk) then
      if A_reg > B_reg then
        assert (a_gt_b_reg = '1')
        report "a > b error"
          severity error;
      elsif A_reg < B_reg then
        assert (a_lt_b_reg = '1')
        report "a < b error"
          severity error;
      elsif A_reg = B_reg then
        assert (a_eq_b_reg = '1')
        report "a = b error"
          severity error;
      end if;
    end if;
  end process;
  -- Stimulus process
  stim_proc : process
  begin
    -- hold reset state for 100 ns.
    report("starting simulation");
    clk_ena <= true;
    wait for 100 ns;
    clk_ena_chk <= true;
    wait for 1000 ns;
    for i in -127 to 127 loop
      A <= to_signed(i, 8);
      for j in -127 to 127 loop
        B <= to_signed(j, 8);
        wait until clk'event and clk = '0'; --negedge
      end loop;

    end loop;
    assert false report "Test: OK" severity failure;
  end process;

end;