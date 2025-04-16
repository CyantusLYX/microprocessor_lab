library ieee;
use ieee.std_logic_1164.all;

entity Lab4 is
    port(
        A, B       : in std_logic_vector(6 downto 0);
        opcode     : in std_logic_vector(3 downto 0);
        carryout   : out std_logic;
        zero       : out std_logic;
					  -- 在 Lab4 的 port 加：
			a1, b1, c1, d1, e1, f1, g1 : out std_logic;
			a2, b2, c2, d2, e2, f2, g2 : out std_logic
    );
end Lab4;

architecture Struct of Lab4 is
    component onebitALU
        port(
            A, B, less, carryin : in std_logic;
            opcode : in std_logic_vector(3 downto 0);
            result, set, carryout : out std_logic
        );
    end component;
    
    component hex
        port (sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7 : in std_logic;
                a1, b1, c1, d1, e1, f1, g1, a2, b2, c2, d2, e2, f2, g2 : out std_logic
		  );
    end component hex;

    signal carry : std_logic_vector(7 downto 0);
    signal set   : std_logic;
    signal less  : std_logic_vector(6 downto 0);
	 signal result : std_logic_vector(6 downto 0);
begin
    carry(0) <= '1' when opcode = "0110" or opcode = "0111" else '0';  -- 初始進位為 0

    -- LSB: 處理 SLT 的結果輸出
    LSB: onebitALU
        port map(
            A => A(0),
            B => B(0),
            less => set,  -- 由 MSB 結果回饋來的 set
            carryin => carry(0),
            opcode => opcode,
            result => result(0),
            set => open,  -- LSB 不產生 set
            carryout => carry(1)
        );

    -- 其餘 bits 1~5
    GEN_ALU: for i in 1 to 5 generate
        U: onebitALU
            port map(
                A => A(i),
                B => B(i),
                less => '0',  -- 中間位元 less 無用
                carryin => carry(i),
                opcode => opcode,
                result => result(i),
                set => open,
                carryout => carry(i+1)
            );
    end generate;

    -- MSB bit = 6，要輸出 set 值（給 SLT 使用）
    MSB: onebitALU
        port map(
            A => A(6),
            B => B(6),
            less => '0',
            carryin => carry(6),
            opcode => opcode,
            result => result(6),
            set => set,  -- 輸出到 set，再餵回 LSB
            carryout => carry(7)
        );

    carryout <= carry(7);

    -- zero flag: 全為 0 時設為 1
    zero <= '1' when result = "0000000" else '0';
	 
	 hex_display: hex port map(
    sw0 => result(0),
    sw1 => result(1),
    sw2 => result(2),
    sw3 => result(3),
    sw4 => result(4),
    sw5 => result(5),
    sw6 => result(6),
    sw7 => '0',
    a1 => a2, b1 => b2, c1 => c2, d1 => d2, e1 => e2, f1 => f2, g1 => g2,
    a2 => a1, b2 => b1, c2 => c1, d2 => d1, e2 => e1, f2 => f1, g2 => g1
);

end Struct;
