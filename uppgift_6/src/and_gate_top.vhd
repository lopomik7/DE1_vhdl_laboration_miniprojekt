-- Uppgift 6 --
-- Två-input AND grind realised med FPGA:  LD0 = SW1 AND SW0.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_gate_top is
  port (
    SW : in  std_logic_vector(1 downto 0);
    LD : out std_logic_vector(0 downto 0)
  );
end entity and_gate_top;

architecture rtl of and_gate_top is
begin
  LD(0) <= SW(1) and SW(0);
end architecture rtl;
