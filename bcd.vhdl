library ieee;
library base;
use ieee.std_logic_1164.all;
use base.base_adder_pkg.all;

entity bcd is
    port (
        in_a       : in std_logic_vector(3 downto 0);
        in_b       : in std_logic_vector(3 downto 0);
        carry_in   : in std_logic;
        sum       : out std_logic_vector(3 downto 0);
        carry_out : out std_logic
    );
end entity;

architecture rtl_bcd of bcd is
    signal added : STD_LOGIC_VECTOR(3 downto 0);
    signal cout_base : STD_LOGIC;
    signal cout_bcd : STD_LOGIC;
    signal is_bcd : STD_LOGIC;
    signal b_bcd : STD_LOGIC_VECTOR(3 downto 0);
begin
    FA1: base_adder
     port map(
        a => in_a,
        b => in_b,
        cin => carry_in,
        sum => added,
        cout => cout_base,
        of_out => open
    );
    is_bcd <= cout_base or added(3) and (added(2) or added(1));
    b_bcd(0) <= '0';
    b_bcd(1) <= is_bcd;
    b_bcd(2) <= is_bcd;
    b_bcd(3) <= '0';
    FA_BCD: base_adder
     port map(
        a => added,
        b => b_bcd,
        cin => '0',
        sum => sum,
        cout => cout_bcd,
        of_out => open
    );
    carry_out <= cout_base or cout_bcd;
end architecture;