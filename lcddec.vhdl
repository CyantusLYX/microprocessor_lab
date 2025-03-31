library ieee;
use ieee.std_logic_1164.all;

entity lcddec is
  port (
    hex_in   : in std_logic_vector(3 downto 0);
    seg7_out : out std_logic_vector(6 downto 0)
  );
end entity;

architecture rtl_lcddec of lcddec is
begin
  process(hex_in)
  begin
    seg7_out(0) <= (not hex_in(3) and not hex_in(2) and not hex_in(1) and hex_in(0)) or --a
    (hex_in(3) and not hex_in(2) and hex_in(1) and hex_in(0)) or
    (hex_in(2) and not hex_in(1) and not hex_in(0)) or
    (hex_in(3) and hex_in(2) and not hex_in(1));
            
seg7_out(1) <= (not hex_in(3) and hex_in(2) and not hex_in(1) and hex_in(0)) or --b
    (hex_in(2) and hex_in(1) and not hex_in(0)) or
    (hex_in(3) and hex_in(1) and hex_in(0)) or
    (hex_in(3) and hex_in(2) and not hex_in(0));
    
seg7_out(2) <= (not hex_in(3) and not hex_in(2) and hex_in(1) and not hex_in(0)) or --c
    (hex_in(3) and hex_in(2) and not hex_in(0)) or
    (hex_in(3) and hex_in(2) and hex_in(1));
    
seg7_out(3) <= (not hex_in(2) and not hex_in(1) and hex_in(0)) or --d
    (not hex_in(3) and hex_in(2) and not hex_in(1) and not hex_in(0)) or
    (hex_in(2) and hex_in(1) and hex_in(0)) or
    (hex_in(3) and not hex_in(2) and hex_in(1) and not hex_in(0));
    
seg7_out(4) <= (not hex_in(3) and hex_in(0)) or
    (not hex_in(3) and hex_in(2) and not hex_in(1)) or
    (not hex_in(2) and not hex_in(1) and hex_in(0));
    
seg7_out(5) <= (not hex_in(3) and not hex_in(2) and hex_in(0)) or
    (not hex_in(3) and not hex_in(2) and hex_in(1)) or
    (not hex_in(3) and hex_in(1) and hex_in(0)) or
    (hex_in(2) and not hex_in(1) and hex_in(3));
    
seg7_out(6) <= (not hex_in(2) and not hex_in(1) and not hex_in(3)) or
    (not hex_in(3) and hex_in(2) and hex_in(1) and hex_in(0));
  end process;
end architecture;
