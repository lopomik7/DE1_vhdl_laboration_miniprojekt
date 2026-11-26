-- Uppgift 7 --
-- Testbench för the 30-bit up/down räknaren.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_counter30 is
end entity tb_counter30;

architecture sim of tb_counter30 is
  signal clk, reset, up : std_logic := '0';
  signal count : unsigned(29 downto 0);
  signal leds : std_logic_vector(7 downto 0);
begin
  clk <= not clk after 5 ns;   -- 100 MHz

  dut: entity work.counter30
    port map (clk => clk, up => up, reset => reset, count => count, leds => leds);

  stimulus: process
  begin
    reset <= '1'; up <= '1';
    wait for 20 ns;
    reset <= '0';
    wait until rising_edge(clk);
    assert count = 1 report "reseta första steg fel" severity error;

    -- Räkna upp.
    wait until rising_edge(clk);
    assert count = 2 report "uppräkning fel" severity error;
    wait until rising_edge(clk);
    assert count = 3 report "uppräkning fel" severity error;

    -- Byt till nedrälning; måste ske omedelbart
    up <= '0';
    wait until rising_edge(clk);
    assert count = 2 report "nedräkning fel" severity error;
    wait until rising_edge(clk);
    assert count = 1 report "nedräkning fel" severity error;

    -- Reset returnerar till noll.
    reset <= '1';
    wait until rising_edge(clk);
    assert count = 0 report "resetade ej till noll" severity error;
    reset <= '0';

    report "30-bit räknare testbench OK" severity note;
    wait;
  end process;
end architecture sim;
