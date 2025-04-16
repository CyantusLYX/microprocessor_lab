library ieee;
use ieee.std_logic_1164.all;

entity onebitALU is
    port(
        A, B, less, carryin : in std_logic;
        opcode : in std_logic_vector(3 downto 0);
        result, set, carryout : out std_logic
    );
end onebitALU;

architecture Struct of onebitALU is
    signal Binv, Bsel : std_logic;
    signal and_out, or_out, sum_out : std_logic;
begin
    -- Bsel: 用來做減法時對 B 取反
    Binv <= not B when opcode = "0110" or opcode = "0111" else B;  -- SUBTRACT 用到 B 的補數

    -- AND 與 OR 運算
    and_out <= A and B;
    or_out  <= A or B;

    -- 加法器邏輯：Sum 與 Carryout
    sum_out <= A xor Binv xor carryin;
    carryout <= (A and Binv) or (A and carryin) or (Binv and carryin);

    -- set：只在 MSB 位元輸出 sum 給 SLT 使用
    set <= sum_out;

    -- 結果選擇邏輯
    with opcode select
        result <= and_out      when "0000", -- AND
                  or_out       when "0001", -- OR
                  sum_out      when "0010", -- ADD
                  sum_out      when "0110", -- SUB
                  less         when "0111", -- SLT
                  not (A or B) when "1100", -- NOR
                  '0'          when others;
end Struct;
