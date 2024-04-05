---- Watch Block ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;
-- use ieee.std_logic_unsigned.all;
-- use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Entity Declaration --
entity watch is
  port (
    reset, clk: in std_logic; -- Reset and Clock
    en: in std_logic; -- Watch Enable
    y2, y1, y0: out std_logic_vector(3 downto 0) -- 3 BCD Digit Time Output
  );
end watch;

-- Architecture Body --
architecture watch_beh of watch is
  signal time_d: std_logic_vector(9 downto 0) := (others => '0'); -- Time Counter (Max Register Value = 1023, but Max Time Count = 999 due to 3 BCD Digit Display)
begin

  process (reset, en, clk) begin
    if (reset = '1' or en = '0') then
      time_d <= (others => '0');
    elsif (rising_edge(clk)) then
      if (time_d = 999) then
        time_d <= (others => '0');
      else
        time_d <= time_d + 1;
      end if;
    end if;
  end process;
  
  process (time_d) is
    variable bcd: std_logic_vector(11 downto 0) := (others => '0');
  begin
    bcd := (others => '0');
    -- Double Dabble Binary to BCD Method
    for i in 0 to 9 loop -- Iterate once for each bit in input number
      if (bcd(3 downto 0) >= "0101") then -- If any BCD digit is >= 5, add 3
        bcd(3 downto 0) := std_logic_vector(unsigned(bcd(3 downto 0)) + "0011");
      end if;
      if (bcd(7 downto 4) >= "0101") then
        bcd(7 downto 4) := std_logic_vector(unsigned(bcd(7 downto 4)) + "0011");
      end if;
      if (bcd(11 downto 8) >= "0101") then
        bcd(11 downto 8) := std_logic_vector(unsigned(bcd(11 downto 8)) + "0011");
      end if;
      -- Shift one bit, and shift in proper bit from input
      bcd := bcd(10 downto 0) & time_d(9 - i);
    end loop;

    y0 <= bcd(3 downto 0);
    y1 <= bcd(7 downto 4);
    y2 <= bcd(11 downto 8);

  end process;
end watch_beh;
