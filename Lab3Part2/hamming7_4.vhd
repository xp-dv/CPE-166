---- (7,4) Hamming Code Generator ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;
-- My Packages --
use work.parity_pack.all;

-- Entity Declaration --
entity hamming7_4 is
  port (
    d7, d6, d5, d3: in std_logic; -- Data Bits
    dout: out std_logic_vector(7 downto 1) -- Data Out
  );
end hamming7_4;

-- Architecture Body --
architecture beh of hamming7_4 is
  -- Internal Signals --
  signal p4: std_logic;
  signal p2: std_logic;
  signal p1: std_logic;
begin
  -- Parity Bit Function --
  p4 <= parity(d7 & d6 & d5);
  p2 <= parity(d7 & d6 & d3);
  p1 <= parity(d7 & d5 & d3);
  -- Output Concatenation
  dout <= d7 & d6 & d5 & p4 & d3 & p2 & p1;
end beh;
