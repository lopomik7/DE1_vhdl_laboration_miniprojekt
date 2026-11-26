-- Uppgift 9 --
-- Component: 2-to-4 decode for the four common-anode 7-segment displays.
--
-- The Basys3 anodes are active low, so exactly one anode is driven low at a
-- time to select its display. sel=00 selects AN0, 01 selects AN1, 10 selects
-- AN2; AN3 is held disabled.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec_24 is
  port (
    sel : in  std_logic_vector(1 downto 0);
    an  : out std_logic_vector(3 downto 0)
  );
end entity dec_24;

architecture rtl of dec_24 is
begin
  with sel select
    an <= "1110" when "00",   -- AN0 active (low)
          "1101" when "01",   -- AN1 active (low)
          "1011" when "10",   -- AN2 active (low)
          "1111" when others; -- all disabled
end architecture rtl;
