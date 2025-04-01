library ieee;
use ieee.std_logic_1164.all;

package bcd_pkg is
  component bcd is
    port (
      in_a       : in std_logic_vector(3 downto 0);
      in_b       : in std_logic_vector(3 downto 0);
      carry_in   : in std_logic;
      sum       : out std_logic_vector(3 downto 0);
      carry_out : out STD_LOGIC;
      is_bcd_out     : out STD_LOGIC
  );
  end component;
  component bcd_adder is
    port (
      in_a      : in std_logic_vector(7 downto 0);
      in_b      : in std_logic_vector(7 downto 0);
      output    : out std_logic_vector(7 downto 0);
      carry_out : out std_logic
    );
  end component;
  component bcd_sub_4b is
    port (
      in_a    : in std_logic_vector(3 downto 0);
      in_b    : in std_logic_vector(3 downto 0);
      brr_in  : in std_logic;
      sum     : out std_logic_vector(3 downto 0);
      brr_out : out std_logic
    );
  end component;
    component bcd_subtractor is
        port (
          in_a      : in std_logic_vector(7 downto 0);
          in_b      : in std_logic_vector(7 downto 0);
          output    : out std_logic_vector(7 downto 0);
          carry_out : out std_logic
        );
    end component;
end package;