---- 1:4 Clock Divider Block Test Bench ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration --
entity clk_div_tb is
end entity clk_div_tb;

-- Architecture Body --
architecture beh of clk_div_tb is -- beh signifies that the architecture type is behavioral
  -- Declaration and Initialization of Constants --
  constant CLK_PERIOD: time := 250 ms; -- f = 4 Hz
  -- Declaration and Initialization of Signals --
  signal clk_i: std_logic := '0'; -- Input Clock Signal
  signal clk_o: std_logic := '0'; -- Output Clock Signal
  signal count_o: std_logic_vector(1 downto 0) := "00";

  signal simulate: std_logic := '1'; -- Variable used to stop the simulation. Must be the "signal" type to be used between processes
begin
  -- Instantiate Unit Under Test --
  uut: entity work.clk_div
    port map (
      clk_i => clk_i,
      clk_o => clk_o,
      count_o => count_o
    );

  -- Clock Signal --
  process begin
    -- To ensure that the rising edge of the clock signal occurs as close to the middle of the input signal as possible:
    -- All desired inputs should last for one full clock period
    -- The input signal should only ever rise or fall with the falling edge of the clock signal
    while simulate = '1' loop -- Stop clock by setting simulate = '0' in the test bench
      wait for CLK_PERIOD / 2;
      clk_i <= not clk_i;
    end loop;
    wait; -- Suspend the test bench for analysis. Equivalent to $stop. Must be inside a process
  end process;

  -- State Transition Testing --
  process is
  begin
    wait for (2 sec - CLK_PERIOD / 2);
    simulate <= '0'; -- End simulation
    wait; -- Suspend the test bench for analysis. Equivalent to $stop. Must be inside a process
  end process;
end beh;
