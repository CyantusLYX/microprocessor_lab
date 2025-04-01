library ieee;
library base;
use ieee.std_logic_1164.all;
use base.adder_pkg.all;
use work.bcd_pkg.all;
entity bcd_sub_4b is
  port (
    in_a    : in std_logic_vector(3 downto 0);
    in_b    : in std_logic_vector(3 downto 0);
    brr_in  : in std_logic;
    sum     : out std_logic_vector(3 downto 0);
    brr_out : out std_logic
  );
end entity;
architecture rtl_bcd_subtractor_4b of bcd_sub_4b is
  signal b_comp_cout, bcd_cout, brr : std_logic;
  signal b_brr, b_comped, bcd_sum,out_sum   : std_logic_vector(3 downto 0);
begin
  add_brr : base_adder_4b
  port map
  (
    a    => in_b,
    b    => "0000",
    cin  => brr_in,
    sum  => b_brr,
    cout => open
  );
  add_b_comp : adder_4b
  port map
  (
    a    => "1010",
    b    => b_brr,
    cin  => '1',
    op   => '1',
    sum  => b_comped,
    cout => b_comp_cout
  );
  add_bcd : bcd
  port map
  (
    in_a      => in_a,
    in_b      => b_comped,
    carry_in  => '0',
    sum       => bcd_sum,
    carry_out => open,
    is_bcd_out => bcd_cout
  );
  brr <= not(bcd_cout);
  out_comp : adder_4b
  port map
  (
    a    => bcd_sum,
    b(0) => '0',
    b(1) => '0',
    b(2) => '0',
    b(3) => '0',
    op=>'0',
    cin  => '0',
    sum  => out_sum
  );
  process (brr,bcd_sum,out_sum)
  begin
    case brr is
      when '0' =>
        sum <= bcd_sum;
      when '1' =>
        sum <= out_sum;
    end case;
  end process;
  brr_out <= brr;
end architecture;
library ieee;
library base;
use ieee.std_logic_1164.all;
use base.adder_pkg.all;
use work.bcd_pkg.all;
entity bcd_subtractor is
  port (
    in_a      : in std_logic_vector(7 downto 0);
    in_b      : in std_logic_vector(7 downto 0);
    output    : out std_logic_vector(7 downto 0);
    carry_out : out std_logic
  );
end entity;
architecture rtl_bcd_subtractor of bcd_subtractor is
    signal brr : STD_LOGIC;
begin
    bcd_sub_0: bcd_sub_4b port map(
        in_a => in_a(3 downto 0),
        in_b => in_b(3 downto 0),
        brr_in => '0',
        sum => output(3 downto 0),
        brr_out => brr
    );
    bcd_sub_1: bcd_sub_4b port map(
        in_a => in_a(7 downto 4),
        in_b => in_b(7 downto 4),
        brr_in => brr,
        sum => output(7 downto 4),
        brr_out => carry_out
    );
end architecture;