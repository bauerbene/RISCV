-----------------------------------------------------
-- TODO documentations
-----------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

USE work.constants.ALL;

ENTITY Forward IS
    PORT (
        -- from Decode
        SrcRegNo1, SrcRegNo2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        -- from RegisterSet
        SrcData1, SrcData2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        -- from ALU or ExecuteStage
        DestWrEn_EX  : IN STD_LOGIC;
        DestRegNo_EX : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        DestData_EX  : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        -- from MemStage
        DestWrEn_MEM  : IN STD_LOGIC;
        DestRegNo_MEM : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        DestData_MEM  : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        -- to ExecuteStage
        FwdData1, FwdData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END Forward;

ARCHITECTURE Behavioral OF Forward IS
BEGIN

    PROCESS (SrcRegNo1, SrcRegNo2, SrcData1, SrcData2, DestWrEn_EX, DestRegNo_EX, DestData_EX, DestWrEn_MEM, DestRegNo_MEM, DestData_MEM)
    BEGIN
        IF DestWrEn_EX = '1' AND SrcRegNo1 = DestRegNo_EX AND SrcRegNo1 /= x0 THEN
            FwdData1 <= DestData_EX;
        ELSIF DestWrEn_MEM = '1' AND SrcRegNo1 = DestRegNo_MEM AND SrcRegNo1 /= x0 THEN
            FwdData1 <= DestData_MEM;
        ELSE
            FwdData1 <= SrcData1;
        END IF;

        IF DestWrEn_EX = '1' AND SrcRegNo2 = DestRegNo_EX AND SrcRegNo2 /= x0 THEN
            FwdData2 <= DestData_EX;
        ELSIF DestWrEn_MEM = '1' AND SrcRegNo2 = DestRegNo_MEM AND SrcRegNo2 /= x0 THEN
            FwdData2 <= DestData_MEM;
        ELSE
            FwdData2 <= SrcData2;
        END IF;
    END PROCESS;

END Behavioral;