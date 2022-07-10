LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY MixColumns IS
    PORT (
        CypherI : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        CypherO : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END MixColumns;

ARCHITECTURE Behavioral OF MixColumns IS
    CONSTANT FOR_STEP : NATURAL := 32;

    FUNCTION MULGAL (InByte : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
        VARIABLE Result : STD_LOGIC_VECTOR(7 DOWNTO 0);
    BEGIN
        Result := STD_LOGIC_VECTOR(shift_left(unsigned(InByte), 1));
        IF ((InByte AND x"80") = x"80") THEN
            Result := Result XOR x"1B";
        END IF;
        RETURN Result;
    END FUNCTION;
    -- 127 .. 96 
    -- 95 .. 64
    -- 63 .. 32
    -- 31 .. 0

BEGIN
    PROCESS (CypherI)
        VARIABLE idx_v : NATURAL;
        VARIABLE Byte1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE Byte2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE Byte3 : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE Byte4 : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE Temp : STD_LOGIC_VECTOR(7 DOWNTO 0);
    BEGIN
        FOR idx_pre IN 4 DOWNTO 1 LOOP
            idx_v := FOR_STEP * idx_pre - 1;
            Byte1 := CypherI(idx_v DOWNTO idx_v - 7);
            Byte2 := CypherI(idx_v - 8 DOWNTO idx_v - 15);
            Byte3 := CypherI(idx_v - 16 DOWNTO idx_v - 23);
            Byte4 := CypherI(idx_v - 24 DOWNTO idx_v - 31);

            Temp := Byte1 XOR Byte2 XOR Byte3 XOR Byte4;
            CypherO(idx_v DOWNTO idx_v - 7) <= MULGAL(Byte1 XOR Byte2) XOR Byte1 XOR Temp;
            CypherO(idx_v - 8 DOWNTO idx_v - 15) <= MULGAL(Byte2 XOR Byte3) XOR Byte2 XOR Temp;
            CypherO(idx_v - 16 DOWNTO idx_v - 23) <= MULGAL(Byte3 XOR Byte4) XOR Byte3 XOR Temp;
            CypherO(idx_v - 24 DOWNTO idx_v - 31) <= MULGAL(Byte4 XOR Byte1) XOR Byte4 XOR Temp;
        END LOOP;
    END PROCESS;

END Behavioral;