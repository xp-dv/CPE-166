---- Stopwatch Test Bench ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration --
entity stopwatch_tb is
end entity stopwatch_tb;

-- Architecture Body --
architecture beh of stopwatch_tb is -- beh signifies that the architecture type is behavioral
  -- Declaration and Initialization of Constants --
  constant CLK_PERIOD: time := 250 ms; -- f = 4 Hz
  constant CLK2_PERIOD: time := 1 sec; -- f2 = 1 Hz
  constant TEST_DURATION: time := 1000 sec;

  -- Declaration and Initialization of Signals --
  signal reset: std_logic := '0'; -- Reset Signal
  signal clk: std_logic := '1'; -- Clock Signal
  signal start, stop: std_logic := '0'; -- Input Signal(s)
  signal y2, y1, y0: std_logic_vector(3 downto 0); -- 3 BCD Digit Time Output

  signal simulate: std_logic := '1'; -- Variable used to stop the simulation. Must be the "signal" type to be used between processes
begin
  -- Instantiate Unit Under Test --
  uut: entity work.stopwatch
    port map (
      reset => reset,
      clk => clk,
      start => start,
      stop => stop,
      y2 => y2,
      y1 => y1,
      y0 => y0
    );

  -- Clock Signal --
  process begin
    -- To ensure that the rising edge of the clock signal occurs as close to the middle of the input signal as possible:
    -- All desired inputs should last for one full clock period
    -- The input signal should only ever rise or fall with the falling edge of the clock signal
    while simulate = '1' loop -- Stop clock by setting simulate = '0' in the test bench
      wait for CLK_PERIOD / 2;
      clk <= not clk;
    end loop;
    wait; -- Suspend the test bench for analysis. Equivalent to $stop. Must be inside a process
  end process;

  -- State Transition Testing --
  process is
  begin
    start <= '0'; stop <= '0'; wait for CLK2_PERIOD; start <= '0'; stop <= '1'; wait for CLK2_PERIOD; start <= '1'; stop <= '0'; wait for CLK2_PERIOD; -- IDLE
    start <= '1'; stop <= '0'; wait for CLK2_PERIOD; start <= '0'; stop <= '0'; wait for TEST_DURATION; start <= '0'; stop <= '1'; wait for CLK2_PERIOD; -- RUN
    simulate <= '0'; reset <= '1'; wait for CLK2_PERIOD; reset <= '0'; -- Reset

    wait; -- Suspend the test bench for analysis. Equivalent to $stop. Must be inside a process
  end process;
end beh;
