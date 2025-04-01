library ieee;
library base;
use ieee.std_logic_1164.all;
use base.adder_pkg.all;
use base.lcddec_pkg.all;
use work.bcd_pkg.all;

entity bcd_calculate is
    port (
        sw_a       : in std_logic_vector(7 downto 0);
        sw_b       : in std_logic_vector(7 downto 0);
        op        : in std_logic;        
        seg7_out_0 : out std_logic_vector(6 downto 0);
        seg7_out_1 : out std_logic_vector(6 downto 0);
        of_out     : out std_logic
    );
end entity;

architecture rtl_bcdcal of bcd_calculate is
    signal out_adder : STD_LOGIC_VECTOR(8 downto 0);
    signal out_subtract : STD_LOGIC_VECTOR(8 downto 0);
    signal mux_out : STD_LOGIC_VECTOR(8 downto 0);
begin
    bcd_adder_0: bcd_adder port map(
        in_a => sw_a,
        in_b => sw_b,
        output => out_adder(7 downto 0),
        carry_out => out_adder(8)
    );
    bcd_subtractor_0: bcd_subtractor port map(
        in_a => sw_a,
        in_b => sw_b,
        output => out_subtract(7 downto 0),
        carry_out => out_subtract(8)
    );
    process (op,out_adder,out_subtract)
    begin
        case op is
            when '0' =>
                mux_out <= out_adder;
            when '1' =>
                mux_out <= out_subtract;
        end case;
    end process;
    seg7_0: lcddec port map(
        hex_in => mux_out(3 downto 0),
        seg7_out => seg7_out_0
    );
    seg7_1: lcddec port map(
        hex_in => mux_out(7 downto 4),
        seg7_out => seg7_out_1
    );
    of_out <= mux_out(8);
    
end architecture;