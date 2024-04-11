---- Algorithmic State Machine ----
-- Required Libraries --
library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration --
entity asm is
  port (
    reset, clk: in std_logic; -- Reset and Clock
    x: in std_logic; -- Input Signal
    z, y1, y0: out std_logic; -- Mealy Output, Moore Outputs
    cs_o, ns_o: out std_logic_vector(1 downto 0) -- Output State Registers (Current State Output, Next State Output)
  );
end asm;

-- Architecture Body --
architecture beh of asm is
  constant S0: std_logic_vector(1 downto 0) := "00";
  constant S1: std_logic_vector(1 downto 0) := "01";
  constant S2: std_logic_vector(1 downto 0) := "10";
  constant S3: std_logic_vector(1 downto 0) := "11";
  
  signal cs, ns: std_logic_vector(1 downto 0) := "00"; -- Internal State Registers (Current State, Next State)
  
begin
  -- Set Output State Registers --
  cs_o <= cs;
  ns_o <= ns;

  -- Next State Combinational Logic --
  process (cs, x) begin
    case (cs) is
      when S0 =>
        if (x = '0') then
          ns <= S0;
        else
          ns <= S1;
        end if;
      when S1 =>
        if (x = '0') then
          ns <= S2;
        else
          ns <= S1;
        end if;
      when S2 =>
        if (x = '0') then
          ns <= S3;
        else
          ns <= S1;
        end if;
      when S3 => ns <= S0;
      when others => ns <= S0;
    end case;
  end process;

  -- Output Combinational Logic --
  process (cs, x) begin
    case (cs) is
      when S0 =>
        y0 <= '0';
        y1 <= '0';
        z <= '0';
      when S1 =>
        y0 <= '0';
        y1 <= '1';
        if (x = '0') then
          z <= '0';
        else
          z <= '1';
        end if;
      when S2 =>
        y0 <= '1';
        y1 <= '0';
        if (x = '0') then
          z <= '0';
        else
          z <= '1';
        end if;
      when S3 =>
        y0 <= '1';
        y1 <= '0';
        z <= '0';
      when others =>
        y0 <= '0';
        y1 <= '0';
        z <= '0';
    end case;
  end process;

  -- State Register and Reset Logic --
  process (reset, clk) begin
    if (reset = '1') then
      cs <= S0;
    elsif (rising_edge(clk)) then
      cs <= ns;
    end if;
  end process;
  
end beh;
