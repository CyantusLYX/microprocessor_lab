library ieee;
use ieee.std_logic_1164.all;

package fa_pkg is
    component fa is
        port (
            a    : in std_logic;
            b    : in std_logic;
            cin  : in std_logic;
            sum  : out std_logic;
            cout : out std_logic
        );
    end component;
end package;

library ieee;
use ieee.std_logic_1164.all;

package adder_pkg is
    component base_adder_4b is
        port (
            a    : in std_logic_vector(3 downto 0);
            b    : in std_logic_vector(3 downto 0);
            cin  : in std_logic;
            sum  : out std_logic_vector(3 downto 0);
            cout : out std_logic
        );          
    end component;
    component adder_4b is 
        port(
            a    : in std_logic_vector(3 downto 0);
            b    : in std_logic_vector(3 downto 0);
            cin  : in std_logic;
            op   : in std_logic;
            sum  : out std_logic_vector(3 downto 0);
            cout : out std_logic
        );
	end component;
end package adder_pkg;

library ieee;
use ieee.std_logic_1164.all;

package lcddec_pkg is
    component lcddec is
        port (
            hex_in   : in std_logic_vector(3 downto 0);
            seg7_out : out std_logic_vector(6 downto 0)
        );
    end component;
end package lcddec_pkg; 
