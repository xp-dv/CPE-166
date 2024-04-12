---- Watch Block ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Entity Declaration --
entity watch is
  port (
    reset, clk: in std_logic; -- Reset and Clock
    en_i: in std_logic; -- Watch Enable
    y2, y1, y0: out std_logic_vector(3 downto 0) -- 3 BCD Digit Time Output
  );
end watch;

-- Architecture Body --
architecture beh of watch is
  signal time_d: std_logic_vector(9 downto 0) := (others => '0'); -- Time Counter (Max Register Value = 1023, but Max Time Count = 999 due to 3 BCD Digit Display)
begin
  -- Counter, Reset, and Enable --
  process (reset, en_i, clk) begin
    if (reset = '1' or en_i = '0') then
      time_d <= (others => '0');
    elsif (rising_edge(clk)) then
      if (time_d = 999) then
        time_d <= (others => '0');
      else
        time_d <= time_d + 1;
      end if;
    end if;
  end process;

  -- 10-Bit Binary to 3-Digit BCD Conversion --
  process (time_d) is
    variable bcd: std_logic_vector(11 downto 0) := (others => '0');
  begin
    bcd := (others => '0');
    -- Double Dabble Binary to BCD Method --
    for i in 0 to 9 loop -- Iterate for every bit in the binary input
      -- If any BCD digit is >= 5, add 3
      if (bcd(3 downto 0) >= "0101") then
        bcd(3 downto 0) := std_logic_vector(unsigned(bcd(3 downto 0)) + "0011");
      end if;
      if (bcd(7 downto 4) >= "0101") then
        bcd(7 downto 4) := std_logic_vector(unsigned(bcd(7 downto 4)) + "0011");
      end if;
      if (bcd(11 downto 8) >= "0101") then
        bcd(11 downto 8) := std_logic_vector(unsigned(bcd(11 downto 8)) + "0011");
      end if;
      -- Shift bcd left, inserting the next MSB from input
      bcd := bcd(10 downto 0) & time_d(9 - i);
    end loop;

    -- Assign BCD Digits to Output Signals --
    y0 <= bcd(3 downto 0);
    y1 <= bcd(7 downto 4);
    y2 <= bcd(11 downto 8);

  end process;
end beh;
