-- Uppgift 8 --
-- Testbench för the 8-bit upp/ned-räknare.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_counter8 is
end entity tb_counter8;

architecture sim of tb_counter8 is
  signal clk, up, reset : std_logic := '0';
  signal count : std_logic_vector(7 downto 0);
begin
  clk <= not clk after 5 ns;   -- 10 ns period

  dut: entity work.counter8
    port map (clk => clk, up => up, reset => reset, count => count);


stimulus: process
begin
    -- Reset
    reset <= '1';
    up <= '1';
    wait for 30 ns;
    reset <= '0';

    -- Up counting
    wait until rising_edge(clk);
    wait for 1 ns;
    assert unsigned(count) = 1 report "uppräkning fel" severity error;

    wait until rising_edge(clk);
    wait for 1 ns;
    assert unsigned(count) = 2 report "uppräkning fel" severity error;

    wait until rising_edge(clk);
    wait for 1 ns;
    assert unsigned(count) = 3 report "uppräkning fel" severity error;

    -- Down counting
    up <= '0';

    wait until rising_edge(clk);
    wait for 1 ns;
    assert unsigned(count) = 2 report "nedräkning fel" severity error;

    wait until rising_edge(clk);
    wait for 1 ns;
    assert unsigned(count) = 1 report "nedräkning fel" severity error;

    -- Synchronous reset
    reset <= '1';

    wait until rising_edge(clk);
    wait for 1 ns;
    assert unsigned(count) = 0 report "resetde inte räknaren till noll" severity error;

    reset <= '0';

    report "Testbench klar" severity note;
    wait;
end process;
end architecture sim;
