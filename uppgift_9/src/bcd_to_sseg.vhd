-- Uppgift 9 --
-- I denna uppgift ska LED-räknaren från uppgift 8 byggas ut så att den även visar
-- det decimala värdet (av de åtta högsta bitarna i 30-bitars-räknaren) på tre av
-- Basys3-kortets fyra 7-segments- displayer.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_to_sseg is
  port (
    bcd  : in  std_logic_vector(3 downto 0);
    sseg : out std_logic_vector(6 downto 0)
  );
end entity bcd_to_sseg;

architecture rtl of bcd_to_sseg is
begin
  process(bcd)
  begin
    case bcd is
      when "0000" => sseg <= "1000000"; -- 0
      when "0001" => sseg <= "1111001"; -- 1
      when "0010" => sseg <= "0100100"; -- 2
      when "0011" => sseg <= "0110000"; -- 3
      when "0100" => sseg <= "0011001"; -- 4
      when "0101" => sseg <= "0010010"; -- 5
      when "0110" => sseg <= "0000010"; -- 6
      when "0111" => sseg <= "1111000"; -- 7
      when "1000" => sseg <= "0000000"; -- 8
      when "1001" => sseg <= "0010000"; -- 9
      when others => sseg <= "1111111"; -- Blank
    end case;
  end process;
end architecture rtl;
