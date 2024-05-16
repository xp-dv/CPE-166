--! The following code has not been test benched, only compile checked --
---- SRAM Block ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity Declaration -
entity sram is
  port (
    address: in std_logic_vector(4 downto 0);
    data: inout std_logic_vector(7 downto 0);
    cs, we, oe: in std_logic
  );
end sram;

architecture beh of sram is
  type memory is array(0 to 31) of std_logic_vector(7 downto 0);
  signal mem: memory;
begin

mem_write: process(address, data, cs, we)
begin
  if (cs = '1' and we = '1') then
    mem(conv_integer(address)) <= data;
  end if;
end process mem_write;

mem_read: process(address, cs, we, oe, mem)
begin
  if (cs = '1' and we = '0' and oe = '1') then
    data <= mem(conv_integer(address));
  else
    data <= (others => 'Z');
  end if;
end process mem_read;

end beh;
