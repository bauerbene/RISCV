LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.AesSubstitutionBoxes.ALL;
USE work.AesGeneralOperations.ALL;

PACKAGE AesDecryptionOperations IS
    FUNCTION InvShiftRows(CypherI : STD_LOGIC_VECTOR(127 DOWNTO 0)) RETURN STD_LOGIC_VECTOR;
    FUNCTION InvSubBytes(CypherI : STD_LOGIC_VECTOR(127 DOWNTO 0)) RETURN STD_LOGIC_VECTOR;
    FUNCTION InvMixColumns(CypherI : STD_LOGIC_VECTOR(127 DOWNTO 0)) RETURN STD_LOGIC_VECTOR;
END PACKAGE AesDecryptionOperations;

PACKAGE BODY AesDecryptionOperations IS

    -- row 0: CypherI(127 downto 120) CypherI(95 downto 88) CypherI(63 downto 56) CypherI(31 downto 24)
    -- row 1: CypherI(119 downto 112) CypherI(87 downto 80) CypherI(55 downto 48) CypherI(23 downto 16)
    -- row 2: CypherI(111 downto 104) CypherI(79 downto 72) CypherI(47 downto 40) CypherI(15 downto 8)
    -- row 3:  CypherI(103 downto 96) CypherI(71 downto 64) CypherI(39 downto 32) CypherI(7 downto 0)
    FUNCTION InvShiftRows(CypherI : STD_LOGIC_VECTOR(127 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
        VARIABLE Result : STD_LOGIC_VECTOR(127 DOWNTO 0);
    BEGIN
        -- dont shift row 0
        Result(127 DOWNTO 120) := CypherI(127 DOWNTO 120);
        Result(95 DOWNTO 88) := CypherI(95 DOWNTO 88);
        Result(63 DOWNTO 56) := CypherI(63 DOWNTO 56);
        Result(31 DOWNTO 24) := CypherI(31 DOWNTO 24);

        -- shift row 1 by 1 byte right
        Result(23 DOWNTO 16) := CypherI(55 DOWNTO 48);
        Result(55 DOWNTO 48) := CypherI(87 DOWNTO 80);
        Result(87 DOWNTO 80) := CypherI(119 DOWNTO 112);
        Result(119 DOWNTO 112) := CypherI(23 DOWNTO 16);

        -- shift row 2 by 2 bytes right
        Result(15 DOWNTO 8) := CypherI(79 DOWNTO 72);
        Result(47 DOWNTO 40) := CypherI(111 DOWNTO 104);
        Result(79 DOWNTO 72) := CypherI(15 DOWNTO 8);
        Result(111 DOWNTO 104) := CypherI(47 DOWNTO 40);

        -- shift row 3 by 3 bytes right
        Result(7 DOWNTO 0) := CypherI(103 DOWNTO 96);
        Result(39 DOWNTO 32) := CypherI(7 DOWNTO 0);
        Result(71 DOWNTO 64) := CypherI(39 DOWNTO 32);
        Result(103 DOWNTO 96) := CypherI(71 DOWNTO 64);
        RETURN Result;
    END FUNCTION;

    FUNCTION InvSubBytes(CypherI : STD_LOGIC_VECTOR(127 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
        VARIABLE idx_v : NATURAL;
        VARIABLE Result : STD_LOGIC_VECTOR(127 DOWNTO 0);
        CONSTANT FOR_START : NATURAL := 7;
        CONSTANT FOR_STEP : NATURAL := 8;
    BEGIN
        FOR idx_pre IN 0 TO 15 LOOP
            idx_v := FOR_START + FOR_STEP * idx_pre;
            Result(idx_v DOWNTO idx_v - 7) := InvSBox(to_integer(unsigned(CypherI(idx_v DOWNTO idx_v - 7))));
        END LOOP;
        RETURN Result;
    END FUNCTION;

    FUNCTION InvMixColumns(CypherI : STD_LOGIC_VECTOR(127 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
        VARIABLE idx_v : NATURAL;
        VARIABLE Byte1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE Byte2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE Byte3 : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE Byte4 : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE Temp : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE Result : STD_LOGIC_VECTOR(127 DOWNTO 0);
        CONSTANT FOR_STEP : NATURAL := 32;
        VARIABLE TempU : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE TempV : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE TempT : STD_LOGIC_VECTOR(7 DOWNTO 0);
    BEGIN
        FOR idx_pre IN 4 DOWNTO 1 LOOP
            idx_v := FOR_STEP * idx_pre - 1;
            Byte1 := CypherI(idx_v DOWNTO idx_v - 7);
            Byte2 := CypherI(idx_v - 8 DOWNTO idx_v - 15);
            Byte3 := CypherI(idx_v - 16 DOWNTO idx_v - 23);
            Byte4 := CypherI(idx_v - 24 DOWNTO idx_v - 31);

            Temp := Byte1 XOR Byte2 XOR Byte3 XOR Byte4;
            Result(idx_v DOWNTO idx_v - 7) := Temp XOR Byte1 XOR MULGAL(Byte1 XOR Byte2);
            Result(idx_v - 8 DOWNTO idx_v - 15) := Temp XOR Byte2 XOR MULGAL(Byte2 XOR Byte3);
            Result(idx_v - 16 DOWNTO idx_v - 23) := Temp XOR Byte3 XOR MULGAL(Byte3 XOR Byte4);
            Result(idx_v - 24 DOWNTO idx_v - 31) := Temp XOR Byte4 XOR MULGAL(Byte4 XOR Byte1);

            TempU := MULGAL(MULGAL(Byte1 XOR Byte3));
            TempV := MULGAL(MULGAL(Byte2 XOR Byte4));
            TempT := MULGAL(TempU XOR TempV);

            Result(idx_v DOWNTO idx_v - 7) := Result(idx_v DOWNTO idx_v - 7) XOR TempT XOR TempU;
            Result(idx_v - 8 DOWNTO idx_v - 15) := Result(idx_v - 8 DOWNTO idx_v - 15) XOR TempT XOR TempV;
            Result(idx_v - 16 DOWNTO idx_v - 23) := Result(idx_v - 16 DOWNTO idx_v - 23) XOR TempT XOR TempU;
            Result(idx_v - 24 DOWNTO idx_v - 31) := Result(idx_v - 24 DOWNTO idx_v - 31) XOR TempT XOR TempV;
        END LOOP;
        RETURN Result;
    END FUNCTION;

END PACKAGE BODY AesDecryptionOperations;