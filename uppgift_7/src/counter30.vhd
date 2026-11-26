-- Uppgift 7 --
-- I denna uppgift ska 100MHz-klockan användas för att trigga en 30-bitars
-- räknare. Räknaren ska räkna ett steg upp eller ner för varje klockpuls. En av
-- switcharna på Basys3-kortet (SW0) ska användas för att styra huruvida räknaren
-- räknar upp eller ner, och räknarens värde ska visualiseras genom att låta de
-- åtta mest signifikanta bitarna aktivera lysdioder (LD7..LD0).



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter30 is
    port (
        clk   : in  std_logic;
        up    : in  std_logic;
        leds  : out std_logic_vector(7 downto 0)
    );
end entity counter30;

architecture rtl of counter30 is

    signal count_reg : unsigned(29 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if up = '1' then
                count_reg <= count_reg + 1;
            else
                count_reg <= count_reg - 1;
            end if;
        end if;
    end process;

    -- Visa 8 mest signifikanta bitarna på LEDen
    leds <= std_logic_vector(count_reg(29 downto 22));

end architecture rtl;
