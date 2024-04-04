---- 1:4 Clock Divider Block ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Entity Declaration --
entity clk_div is
  port (
    clk_i: in std_logic; -- Clock Input
    clk_o: out std_logic; -- Clock Output
  );
end clk_div;

-- Architecture Body --
architecture clk_div_beh of clk_div is
  signal count: std_logic_vector(1 downto 0) := "00"; -- Frequency Count Register
begin
  -- Next State Combinational Logic --
  process (clk_i) begin
  if (rising_edge(clk_i)) then
    if ( count = 3 ) then
      count <= "00";
      clk_o <= '1';
    elsif (count = 0 ) then
      count <= count + 1;
      clk_o <= '1';
    else
      count <= count + 1;
      clk_o <= '0';
    end if;
  end if;
  end process;
  
end clk_div_beh;
