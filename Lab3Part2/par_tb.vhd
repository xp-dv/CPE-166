---- 3-Bit Parity Bit Generator (Par) Test Bench ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration --
entity par_tb is
end entity par_tb;

-- Architecture Body --
architecture beh of par_tb is -- beh is used to describe test bench type architecture (short for behavioral)
  signal db: std_logic_vector(2 downto 0); -- Data/Input Bits
  signal pb: std_logic; -- Parity Bit

begin
  -- Instantiate Unit Under Test --
  uut: entity work.par -- par MUST be set as the top-level entity for simulation to work since hamming does not instantiate par
    port map (
    db => db,
    pb => pb
    );

  -- Test bench process --
  process is
  begin
    db <=  "000"; wait for 10 ps;
    db <=  "001"; wait for 10 ps;
    db <=  "010"; wait for 10 ps;
    db <=  "011"; wait for 10 ps;
    db <=  "100"; wait for 10 ps;
    db <=  "101"; wait for 10 ps;
    db <=  "110"; wait for 10 ps;
    db <=  "111"; wait for 10 ps;
    wait; -- Suspend the test bench for analysis. Equivalent to $stop. Must be inside a process
  end process;
end beh;
