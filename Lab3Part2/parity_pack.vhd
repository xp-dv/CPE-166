-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;

-- Package Declaration --
package parity_pack is
  function parity (D : std_logic_vector)
  return std_logic;
end parity_pack;

-- Package Body --
package body parity_pack is
  -- Parity Function (Even) --
  function parity (
    D : std_logic_vector
    )
    return std_logic is
    variable par_bit : std_logic;
  begin
    par_bit := D(0);
    for J in 1 to D'high loop
    par_bit := par_bit xor D(J);
    end loop; -- Loop not size dependent
    return par_bit;
  end parity;
end parity_pack;
