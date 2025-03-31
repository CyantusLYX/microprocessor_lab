library ieee;
use ieee.std_logic_1164.all;

entity fa is
  port (
    a    : in std_logic;
    b    : in std_logic;
    cin  : in std_logic;
    sum  : out std_logic;
    cout : out std_logic
  );
end entity;

architecture rtl_fa of fa is
begin
  sum  <= a xor b xor cin;
  cout <= (a and b) or (cin and (a xor b));
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use work.fa_pkg.all;

entity base_adder is
  port (
    a    : in std_logic_vector(3 downto 0);
    b    : in std_logic_vector(3 downto 0);
    cin  : in std_logic;
    sum  : out std_logic_vector(3 downto 0);
    cout : out std_logic;
    of_out : out std_logic
);
  signal carry_arc : STD_LOGIC_VECTOR(2 downto 0);
  signal max_carry : STD_LOGIC;
end entity;

architecture rtl_4b_adder of base_adder is
begin
  FA0 : fa PORT
  map (a(0), b(0), cin, sum(0), carry_arc(0));
  FA1 : fa PORT
  map (a(1), b(1), carry_arc(0), sum(1), carry_arc(1));
  FA2 : fa PORT
  map (a(2), b(2), carry_arc(1), sum(2), carry_arc(2));
  FA3 : fa PORT
  map (a(3), b(3), carry_arc(2), sum(3), max_carry);
  of_out <= max_carry xor carry_arc(2);
  cout <= max_carry;
end architecture;