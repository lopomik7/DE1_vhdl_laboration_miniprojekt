-- Uppgift 9 --
-- Component: 3-to-1 multiplexer, 4-bit wide.
--
-- Selects one of the three BCD digits (ones/tens/hundreds) for display.
-- The "others" branch keeps the output defined for any selector value.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_31 is
  port (
    sel : in  std_logic_vector(1 downto 0);
    d0, d1, d2 : in  std_logic_vector(3 downto 0);
    y            : out std_logic_vector(3 downto 0)
  );
end entity mux_31;

architecture rtl of mux_31 is
begin
  with sel select
    y <= d0 when "00",
         d1 when "01",
         d2 when "10",
         "0000" when others;
end architecture rtl;
