---- Algorithmic State Machine Test Bench ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration --
entity asm_tb is
end entity asm_tb;

-- Architecture Body --
architecture beh of asm_tb is -- behave (beh) is used to describe test bench type architecture
  signal reset, clk, x: std_logic := '0'; -- Inputs
  signal cs_o, ns_o: std_logic_vector(1 downto 0) := "00"; -- Current State Output, Next State Output
  signal y0, y1, z: std_logic := '0'; -- Moore and Mealy Outputs
  signal simulate: std_logic := '1'; -- Variable used to stop the simulation
begin
  -- Instantiate Unit Under Test --
  uut: entity work.asm
    port map (
      reset => reset,
      clk => clk,
      x => x,
      y0 => y0,
      y1 => y1,
      z => z,
      cs_o => cs_o,
      ns_o => ns_o
    );
  -- Clock Signal
  process begin
    while simulate = '1' loop
      clk <= not clk;
      wait for 5 ps; -- 2(5) = 10 picosecond period
    end loop;
    wait for 5 ps; wait; -- Suspend the test bench for analysis. Equivalent to $stop. Must be inside a process
  end process;

  -- State Transition Testing
  process is
  begin
    -- Each input will last for a full period to stay synced with the clock
    x <= '0'; wait for 10 ps; x <= '1'; wait for 10 ps; -- S0
    x <= '1'; wait for 10 ps; x <= '0'; wait for 10 ps; -- S1
    x <= '1'; wait for 10 ps; x <= '0'; wait for 10 ps; x <= '0'; wait for 10 ps; -- S2
    x <= '0'; wait for 10 ps; x <= '1'; wait for 10 ps; x <= '0'; wait for 10 ps; x <= '0'; wait for 10 ps; x <= '1'; wait for 10 ps; -- S3
    
    reset <= '1'; wait for 10 ps; reset <= '0';
    
    simulate <= '0'; -- End simulation
    wait; -- Suspend the test bench for analysis. Equivalent to $stop. Must be inside a process
  end process;
end beh;
