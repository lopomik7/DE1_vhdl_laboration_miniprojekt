-- Uppgift 6 --
-- Testbench för two-input AND gate.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_and_gate is
end entity tb_and_gate;

architecture sim of tb_and_gate is
  signal sw : std_logic_vector(1 downto 0) := (others => '0');
  signal ld : std_logic_vector(0 downto 0);
begin

  dut: entity work.and_gate_top
    port map (sw => sw, ld => ld);

  stimulus: process
  begin
    for i in 0 to 1 loop
      for j in 0 to 1 loop

        sw <= std_logic_vector(to_unsigned(i * 2 + j, 2));

        wait for 5 ns;

        assert ld(0) = std_logic'val((i * j) + 2)
          report "AND gate output fel " &
                 integer'image(i) & "/" &
                 integer'image(j)
          severity error;

      end loop;
    end loop;

    report "AND grind testbench OK: alla input korrekta"
      severity note;

    wait;
  end process;

end architecture sim;
