-- Par Test Bench --
library IEEE;
use IEEE.std_logic_1164.all;

entity par_tb is
end entity par_tb;

architecture behave of par_tb is
  signal a: std_logic_vector(2 downto 0);
  signal f:std_logic;
  component top
    port ( a: instd_logic_vector(2 downto 0);
    f: out std_logic );
  end component;

begin

  uut: top
    port map (a, f);
  process is
  begin
    a <=  "000";
    wait for 10 ns;
    a <=  "001";
    wait for 10 ns;
    a <=  "010";
    wait for 10 ns;
    a <=  "011";
    wait for 10 ns;
    a <=  "100";
    wait for 10 ns;
    a <=  "101";
    wait for 10 ns;
    a <=  "110";
    wait for 10 ns;
    a <=  "111";
    wait for 10 ns;
    wait; -- wait is required in this testbench
  end process;

end behave;
