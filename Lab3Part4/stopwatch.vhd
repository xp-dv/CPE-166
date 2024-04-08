---- Stopwatch Top-Level Module ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration --
entity stopwatch is
  port (
    reset, clk: in std_logic; -- Reset and Clock
    start, stop: in std_logic; -- Input Signal
    y2, y1, y0: out std_logic_vector(3 downto 0) -- 3 BCD Digit Time Output
  );
end stopwatch;

-- Architecture Body --
architecture interface of stopwatch is
  -- Declare Internal Signals --
  signal clk2: std_logic; -- Internal 1 Hz Clock
  signal en_io: std_logic; -- Enable wire

  -- Module Instance Declaration --
  -- component clk_div is
  --   port (
  --     clk_i: in std_logic; -- Clock Input
  --     clk_o: out std_logic := '0' -- Clock Output
  --   );
  -- end component clk_div;

  -- component stopwatch_fsm is
  --   port (
  --     reset, clk: in std_logic; -- Reset and Clock
  --     start, stop: in std_logic; -- Input Signal
  --     en_o: out std_logic -- Watch Enable Moore Output
  --   );
  -- end component stopwatch_fsm;

  -- component watch is
  --   port (
  --     reset, clk: in std_logic; -- Reset and Clock
  --     en_i: in std_logic; -- Watch Enable
  --     y2, y1, y0: out std_logic_vector(3 downto 0) -- 3 BCD Digit Time Output
  --   );
  -- end component watch;

begin
  -- Module Instantiation --
  clk_div: entity work.clk_div
    port map (
      clk_i => clk,
      clk_o => clk2,
      count_o => open
    );

  stopwatch_fsm: entity work.stopwatch_fsm
    port map (
      reset => reset,
      clk => clk2,
      start => start,
      stop => stop,
      en_o => en_io,
      cs_o => open,
      ns_o => open
    );

  watch: entity work.watch
    port map (
      reset => reset,
      clk => clk2,
      en_i => en_io,
      y2 => y2,
      y1 => y1,
      y0 => y0
    );

end interface;
