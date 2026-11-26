library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.ENV.ALL;

entity tb_bin_to_bcd is
end entity;

architecture sim of tb_bin_to_bcd is

    signal bin  : unsigned(7 downto 0) := (others => '0');
    signal bcd0 : unsigned(3 downto 0);
    signal bcd1 : unsigned(3 downto 0);
    signal bcd2 : unsigned(3 downto 0);

begin

    uut: entity work.bin_to_bcd
        port map (
            bin  => bin,
            bcd0 => bcd0,
            bcd1 => bcd1,
            bcd2 => bcd2
        );

    stimulus: process
        variable expected : integer;
    begin

        for i in 0 to 255 loop

            bin <= to_unsigned(i, 8);

            wait for 10 ns;

            expected := i;

            assert bcd0 = to_unsigned(expected mod 10, 4)
                report "Incorrect BCD ones digit"
                severity error;

            assert bcd1 = to_unsigned((expected / 10) mod 10, 4)
                report "Incorrect BCD tens digit"
                severity error;

            assert bcd2 = to_unsigned(expected / 100, 4)
                report "Incorrect BCD hundreds digit"
                severity error;

        end loop;

        report "HEJA: Alla 256 tester godkänt!"
            severity note;

        stop;
        wait;

    end process;

end architecture;
