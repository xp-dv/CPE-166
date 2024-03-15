---- 3-Bit Parity Bit Generator ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;
-- My Packages --
use work.parity_pack.all;

-- Entity Declaration --
entity par is
  port(
    db: in std_logic_vector(2 downto 0); -- Data/Input Bits
    pb: out std_logic -- Parity Bit
  );
end par;

-- Architecture Body --
architecture par_arch of par is
begin
  pb <= parity(db);
end par_arch;
