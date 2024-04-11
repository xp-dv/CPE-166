---- Even Parity Bit Generator Package ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;

-- Package Declaration --
package parity_pack is
  function parity (
    db: std_logic_vector -- Data Bits Input (Any size)
    )
    return std_logic; -- Parity Bit Output
end parity_pack;

-- Package Body --
package body parity_pack is
  -- Parity Function (Even) --
  function parity (
    db: std_logic_vector
    )
    return std_logic is
    variable pb: std_logic; -- Parity Bit
  begin
    pb := d(0); -- Set initial parity bit to match first data bit, making parity even
    for i in 1 to db'high loop -- Loop through all values of d so the input is not size constrained
      pb := pb xor db(i); -- Calculate parity bit according to each bit
    end loop;
    return pb;

  end parity;
end parity_pack;
