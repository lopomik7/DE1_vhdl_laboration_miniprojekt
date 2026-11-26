-- Uppgift 9 --
-- Component: 8-bit binary to three BCD digits converter.
--
-- This uses the interface supplied on the course page (bin, bcd0..bcd2).
-- bcd0 holds the ones, bcd1 the tens, bcd2 the hundreds. The internal
-- double-dabble algorithm shifts the binary value in from the most-significant
-- bit and adds 3 to any BCD nibble that is >= 5 before each shift.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bin_to_bcd is
    port (
        bin  : in  unsigned(7 downto 0);
        bcd0 : out unsigned(3 downto 0); -- Ental
        bcd1 : out unsigned(3 downto 0); -- Tiotal
        bcd2 : out unsigned(3 downto 0)  -- Hundratal
    );
end entity bin_to_bcd;

architecture arch of bin_to_bcd is

    signal P : unsigned(11 downto 0);

begin

    process(bin)
        variable z : unsigned(19 downto 0);
    begin

        -- Nollställ arbetsregistret.
        z := (others => '0');

        -- Placera insignalen i de 8 lägsta bitarna.
        z(7 downto 0) := bin;

        -- Double Dabble: 8 iterationer.
        for i in 0 to 7 loop

            -- Korrigera ental.
            if z(11 downto 8) >= 5 then
                z(11 downto 8) :=
                    z(11 downto 8) + to_unsigned(3, 4);
            end if;

            -- Korrigera tiotal.
            if z(15 downto 12) >= 5 then
                z(15 downto 12) :=
                    z(15 downto 12) + to_unsigned(3, 4);
            end if;

            -- Korrigera hundratal.
            if z(19 downto 16) >= 5 then
                z(19 downto 16) :=
                    z(19 downto 16) + to_unsigned(3, 4);
            end if;

            -- Skifta hela registret ett steg åt vänster.
            z := shift_left(z, 1);

        end loop;

        -- Extrahera de tre BCD-siffrorna.
        P <= z(19 downto 8);

    end process;

    bcd0 <= P(3 downto 0);
    bcd1 <= P(7 downto 4);
    bcd2 <= P(11 downto 8);

end architecture arch;
