-- Uppgift 8 --
-- Simulering av räknare från föregående uppgift
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter8 is
  port (
    clk   : in  std_logic;
    up    : in  std_logic;
    reset : in  std_logic;
    count : out std_logic_vector(7 downto 0)
  );
end entity counter8;

architecture rtl of counter8 is
  signal count_reg : unsigned(7 downto 0) := (others => '0');
begin
  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        count_reg <= (others => '0');
      elsif up = '1' then
        count_reg <= count_reg + 1;
      else
        count_reg <= count_reg - 1;
      end if;
    end if;
  end process;

  count <= std_logic_vector(count_reg);
end architecture rtl;
