LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE AesGeneralOperations IS
    FUNCTION AddRoundKey(CypherI : STD_LOGIC_VECTOR(127 DOWNTO 0); RoundKey : STD_LOGIC_VECTOR(127 DOWNTO 0)) RETURN STD_LOGIC_VECTOR;
    FUNCTION MULGAL (InByte : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN STD_LOGIC_VECTOR;
END AesGeneralOperations;

PACKAGE BODY AesGeneralOperations IS
    FUNCTION AddRoundKey(CypherI : STD_LOGIC_VECTOR(127 DOWNTO 0); RoundKey : STD_LOGIC_VECTOR(127 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        RETURN CypherI XOR RoundKey;
    END FUNCTION;

    FUNCTION MULGAL (InByte : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
        VARIABLE Result : STD_LOGIC_VECTOR(7 DOWNTO 0);
    BEGIN
        Result := STD_LOGIC_VECTOR(shift_left(unsigned(InByte), 1));
        IF ((InByte AND x"80") = x"80") THEN
            Result := Result XOR x"1B";
        END IF;
        RETURN Result;
    END FUNCTION;
END PACKAGE BODY AesGeneralOperations;