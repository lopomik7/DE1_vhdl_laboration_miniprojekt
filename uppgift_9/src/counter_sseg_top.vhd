-- Uppgift 9 --
-- Structural top module for the multiplexed 7-segment counter.
--
-- Every block/komponent is its own entity (see the other files in src/) and
-- is instantiated and wired together here -- this is structural VHDL
-- (Free Range VHDL, chapter 9).
--
--   counter      : 30-bit up/down counter (switch = up/down, reset)
--   bin_to_bcd   : 8 MSBs -> three BCD digits (ones/tens/hundreds)
--   mux_31       : cycles through the three digits
--   dec_24       : activates one anode at a time
--   bcd_to_sseg  : digit -> segment code
--
-- The 100 MHz clock is divided down so each digit stays lit long enough to
-- be seen but switches fast enough to avoid flicker (a 49999 counter gives a
-- 2 kHz digit tick; three digits -> ~667 full refreshes per second).
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_sseg_top is
  port (
    clk, switch, reset : in  std_logic;
    an    : out std_logic_vector(3 downto 0);
    sseg  : out std_logic_vector(6 downto 0);
    LEDs  : out std_logic_vector(7 downto 0)
  );
end entity counter_sseg_top;

architecture structural of counter_sseg_top is
  signal count_val : std_logic_vector(29 downto 0);
  signal bin8      : std_logic_vector(7 downto 0);
  signal h, t, o   : unsigned(3 downto 0);
  signal digit     : std_logic_vector(3 downto 0);
  signal sel       : std_logic_vector(1 downto 0) := "00";
  signal scan_div  : unsigned(15 downto 0) := (others => '0');
begin
  -- Main counter.
  u_count: entity work.counter
    port map (clk => clk, up => switch, reset => reset, count => count_val);

  -- LED display of the top counter bits + binary-to-BCD conversion.
  bin8 <= count_val(29 downto 22);
  LEDs <= bin8;

  u_bcd: entity work.bin_to_bcd
    port map (bin => unsigned(bin8), bcd0 => o, bcd1 => t, bcd2 => h);

  -- Multiplex the three digits; sel=00 -> ones, 01 -> tens, 10 -> hundreds.
  u_mux: entity work.mux_31
    port map (sel => sel, d0 => std_logic_vector(o),
                       d1 => std_logic_vector(t),
                       d2 => std_logic_vector(h), y => digit);

  -- One anode active at a time.
  u_dec: entity work.dec_24
    port map (sel => sel, an => an);

  -- Digit to segments.
  u_seg: entity work.bcd_to_sseg
    port map (bcd => digit, sseg => sseg);

  -- Scan driver: cycle sel and refresh digits ~667 times per second.
  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        scan_div <= (others => '0');
        sel <= "00";
      elsif scan_div = to_unsigned(49999, scan_div'length) then
        scan_div <= (others => '0');
        if sel = "10" then
          sel <= "00";
        else
          sel <= std_logic_vector(unsigned(sel) + 1);
        end if;
      else
        scan_div <= scan_div + 1;
      end if;
    end if;
  end process;
end architecture structural;
