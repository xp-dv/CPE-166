---- Parity Bit Generator Package ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;

-- Package Declaration --
package parity_pack is
  function parity (din: std_logic_vector) -- parity function with any size input Data In
  return std_logic;
end parity_pack;

-- Package Body --
package body parity_pack is
  -- Parity Function (Even) --
  function parity (
    din: std_logic_vector -- Data in
    )
    return std_logic is
    variable par_bit: std_logic; -- Parity Bit
  begin
    par_bit := din(0); -- Variables use the := assignment operator
    for J in 1 to din'high loop -- Input is not size constrained
    par_bit := par_bit xor din(J);
    end loop;
    return par_bit;
  end parity;
end parity_pack;
