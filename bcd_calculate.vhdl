library ieee;
library base;
use ieee.std_logic_1164.all;
use base.base_adder_pkg.all;
use base.lcddec_pkg.all;
use work.bcd_pkg.all;

entity bcd_calculate is
    port (
        sw_a       : in std_logic_vector(7 downto 0);
        sw_b       : in std_logic_vector(7 downto 0);
        op         : in std_logic;
        seg7_out_0 : out std_logic_vector(6 downto 0);
        seg7_out_1 : out std_logic_vector(6 downto 0)
    );
end entity;

architecture rtl_bcdcal of bcd_calculate is
    signal carry : STD_LOGIC;
    signal sum_0 : STD_LOGIC_VECTOR(3 downto 0);    
    signal sum_1 : STD_LOGIC_VECTOR(3 downto 0);
begin
    bcd_0: bcd port map(
        in_a => sw_a(3 downto 0),
        in_b => sw_b(3 downto 0),
        carry_in => op,
        sum => sum_0,
        carry_out => carry
    );
    bcd_1: bcd port map(
        in_a => sw_a(7 downto 4),
        in_b => sw_b(7 downto 4),
        carry_in => carry,
        sum => sum_1,
        carry_out => open
    );
    seg_0: lcddec port map(
        hex_in => sum_0,
        seg7_out => seg7_out_0
    );
    seg_1: lcddec port map(
        hex_in => sum_1,
        seg7_out => seg7_out_1
    );
end architecture;