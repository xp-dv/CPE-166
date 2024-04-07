---- Stopwatch Finite State Machine Block ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration --
entity stopwatch_fsm is
  port (
    reset, clk: in std_logic; -- Reset and Clock
    start, stop: in std_logic; -- Input Signal
    en: out std_logic; -- Watch Enable Moore Output
    cs_o, ns_o: out std_logic_vector(1 downto 0) -- Output State Registers (Current State Output, Next State Output)
  );
end stopwatch_fsm;

-- Architecture Body --
architecture stopwatch_fsm_beh of stopwatch_fsm is
  constant IDLE: std_logic_vector(1 downto 0) := "00";
  constant RUN: std_logic_vector(1 downto 0) := "01";
  signal cs, ns: std_logic_vector(1 downto 0) := "00"; -- Internal State Registers (Current State, Next State

begin
  -- Set Output State Registers --
  cs_o <= cs;
  ns_o <= ns;

  -- Next State and Output Combinational Logic --
  process (cs, start, stop) begin
    case (cs) is
      when IDLE =>
        en <= '0';
        if (start = '1') then
          ns <= RUN;
        else
          ns <= IDLE;
        end if;
      when RUN =>
        en <= '1';
        if (stop = '1') then
          ns <= IDLE;
        else
          ns <= RUN;
        end if;
      when others => ns <= IDLE;
    end case;
  end process;

  -- State Register and Reset Logic --
  process (reset, clk) begin
    if (reset = '1') then
      cs <= IDLE;
    elsif (rising_edge(clk)) then
      cs <= ns;
    end if;
  end process;

end stopwatch_fsm_beh;
