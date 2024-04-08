---- Stopwatch Finite State Machine Test Bench ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration --
entity stopwatch_fsm_tb is
end entity stopwatch_fsm_tb;

-- Architecture Body --
architecture beh of stopwatch_fsm_tb is -- beh signifies that the architecture type is behavioral
  -- Declaration and Initialization of Constants --
  constant CLK_PERIOD: time := 1 sec; -- f = 1 Hz

  -- Declaration and Initialization of Signals --
  signal reset, clk: std_logic := '0'; -- Reset and Clock Signal
  signal start, stop: std_logic := '0'; -- Input Signal(s)
  signal en_o: std_logic := '0'; -- Output Signal(s)
  signal cs_o, ns_o: std_logic_vector(1 downto 0) := "00"; -- Current State Output, Next State Output

  signal simulate: std_logic := '1'; -- Variable used to stop the simulation. Must be the "signal" type to be used between processes
begin
  -- Instantiate Unit Under Test --
  uut: entity work.stopwatch_fsm
    port map (
      reset => reset,
      clk => clk,
      start => start,
      stop => stop,
      en_o => en_o,
      cs_o => cs_o,
      ns_o => ns_o
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
    start <= '0'; stop <= '0'; wait for CLK_PERIOD; start <= '0'; stop <= '1'; wait for CLK_PERIOD; start <= '1'; stop <= '0'; wait for CLK_PERIOD; -- IDLE
    start <= '0'; stop <= '0'; wait for CLK_PERIOD; start <= '1'; stop <= '0'; wait for CLK_PERIOD; start <= '0'; stop <= '1'; wait for CLK_PERIOD; -- RUN
    simulate <= '0'; reset <= '1'; wait for CLK_PERIOD; reset <= '0'; -- Reset

    wait; -- Suspend the test bench for analysis. Equivalent to $stop. Must be inside a process
  end process;
end beh;
