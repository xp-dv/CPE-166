---- (7,4) Hamming Code Generator Test Bench ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration --
entity hamming7_4_tb is
end entity hamming7_4_tb;

-- Architecture Body --
architecture behave of hamming7_4_tb is -- behave is used to describe test bench type architecture
  signal d7, d6, d5, d3: std_logic; -- Data/Input Bit
  signal dout: std_logic_vector(7 downto 1); -- Data Out
  -- signal din: std_logic_vector(3 downto 0); -- Data In signal used for test bench
begin
  -- Instantiate Unit Under Test --
  uut: entity work.hamming7_4
    port map (
      d7 => d7,
      d6 => d6,
      d5 => d5,
      d3 => d3,
      dout => dout
    );
  process is
  begin
    (d7, d6, d5, d3) <=  std_logic_vector'("0000"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("0001"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("0010"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("0011"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("0100"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("0101"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("0110"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("0111"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("1000"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("1001"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("1010"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("1011"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("1100"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("1101"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("1110"); wait for 10 ps;
    (d7, d6, d5, d3) <=  std_logic_vector'("1111"); wait for 10 ps;
    wait; -- Suspend the test bench for analysis. Equivalent to $stop. Must be inside a process
  end process;
end behave;
