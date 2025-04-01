library ieee;
library base;
use ieee.std_logic_1164.all;
use base.adder_pkg.all;
use base.lcddec_pkg.all;
use work.bcd_pkg.all;

entity bcd_adder is
    port (
        in_a       : in std_logic_vector(7 downto 0);
        in_b       : in std_logic_vector(7 downto 0);
        output     : out std_logic_vector(7 downto 0);
        carry_out : out std_logic
    );
end entity;

architecture rtl_bcd_adder of bcd_adder is
    signal cout_0 : STD_LOGIC;
    signal cout_1 : STD_LOGIC;
    signal sum_0 : STD_LOGIC_VECTOR(3 downto 0);    
    signal sum_1 : STD_LOGIC_VECTOR(3 downto 0);
begin
    bcd_0: bcd port map(
        in_a => in_a(3 downto 0),
        in_b => in_b(3 downto 0),
        carry_in => '0',
        sum => sum_0,
        carry_out => cout_0,
        is_bcd_out => open
    );
    bcd_1: bcd port map(
        in_a => in_a(7 downto 4),
        in_b => in_b(7 downto 4),
        carry_in => cout_0,
        sum => sum_1,
        carry_out => cout_1,
        is_bcd_out => open
    );
    output(3 downto 0) <= sum_0;
    output(7 downto 4) <= sum_1;
    carry_out <= cout_1;
end architecture;