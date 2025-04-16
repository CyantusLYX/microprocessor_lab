library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- 確保包含這一行

entity hex is
    port (
        sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7 : in std_logic;
        a1, b1, c1, d1, e1, f1, g1 : out std_logic; -- 7-segment display for first digit
        a2, b2, c2, d2, e2, f2, g2 : out std_logic  -- 7-segment display for second digit
    );
end hex;

architecture behavior of hex is
    type seg_table is array (0 to 15) of std_logic_vector(0 to 6); -- 7 segments (a-g)
    constant seg : seg_table := (
        "0000001", -- 0
        "1001111", -- 1
        "0010010", -- 2
        "0000110", -- 3
        "1001100", -- 4
        "0100100", -- 5
        "0100000", -- 6
        "0001111", -- 7
        "0000000", -- 8
        "0000100", -- 9
        "0001000", -- A
        "1100000", -- B
        "0110001", -- C
        "1000010", -- D
        "0110000", -- E
        "0111000"  -- F
    );
begin
    process (sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7)
        variable value1 : integer range 0 to 15;
        variable value2 : integer range 0 to 15;
        variable switches1 : std_logic_vector(7 downto 4);
        variable switches2 : std_logic_vector(3 downto 0);
    begin
        -- 合併 sw0 到 sw7 的值，並轉換為 std_logic_vector
        switches1 := (sw7 & sw6 & sw5 & sw4);
        switches2 := (sw3 & sw2 & sw1 & sw0);

        -- 將 std_logic_vector 轉換為 unsigned，然後轉換為整數
        value1 := to_integer(unsigned(switches1));
        value2 := to_integer(unsigned(switches2));

        -- 將對應的顯示模式傳送到 7-segment 顯示器
        a1 <= seg(value1)(0);
        b1 <= seg(value1)(1);
        c1 <= seg(value1)(2);
        d1 <= seg(value1)(3);
        e1 <= seg(value1)(4);
        f1 <= seg(value1)(5);
        g1 <= seg(value1)(6);

        -- 對於第二個顯示器，這裡假設你會使用相同的 `value`，如果需要不同的顯示可以修改邏輯
        a2 <= seg(value2)(0);
        b2 <= seg(value2)(1);
        c2 <= seg(value2)(2);
        d2 <= seg(value2)(3);
        e2 <= seg(value2)(4);
        f2 <= seg(value2)(5);
        g2 <= seg(value2)(6);
    end process;
end behavior;
