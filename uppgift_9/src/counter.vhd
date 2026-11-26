-- Uppgift 9 --
-- Component: 30-bit up/down counter with synchronous reset.
--
-- This is one building block of the multiplexed 7-segment counter. It is
-- described on its own so it can be instantiated (and reused) from the
-- structural top module counter_sseg_top.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
  port (
    clk, up, reset : in  std_logic;
    count          : out std_logic_vector(29 downto 0)
  );
end entity counter;

architecture rtl of counter is
  signal q : unsigned(29 downto 0) := (others => '0');
begin
  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        q <= (others => '0');
      elsif up = '1' then
        q <= q + 1;
      else
        q <= q - 1;
      end if;
    end if;
  end process;

  count <= std_logic_vector(q);
end architecture rtl;
