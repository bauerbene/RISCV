LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE work.constants.ALL;
ENTITY Forward IS
    PORT (
        -- from Decode
        SrcRegNo1, SrcRegNo2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        AesRamAddressRegNo : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        -- from RegisterSet
        SrcData1, SrcData2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        -- Aes Data from RegisterSet
        AesData1, AesData2, AesData3, AesData4 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesWrRamAddressI                       : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        -- AesDataOut
        AesData1O, AesData2O, AesData3O, AesData4O : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesWrRamAddressO                           : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);

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

    PROCESS (SrcRegNo1, SrcRegNo2, SrcData1, SrcData2, DestWrEn_EX, DestRegNo_EX, DestData_EX, DestWrEn_MEM, DestRegNo_MEM, DestData_MEM, AesData1, AesData2, AesData3, AesData4, AesWrRamAddressI, AesRamAddressRegNo)
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

        IF DestWrEn_EX = '1' AND AesRamAddressRegNo = DestRegNo_EX AND AesRamAddressRegNo /= x0 THEN
            AesWrRamAddressO <= DestData_EX;
        ELSIF DestWrEn_MEM = '1' AND AesRamAddressRegNo = DestRegNo_MEM AND AesRamAddressRegNo /= x0 THEN
            AesWrRamAddressO <= DestData_MEM;
        ELSE
            AesWrRamAddressO <= AesWrRamAddressI;
        END IF;

        IF DestWrEn_EX = '1' AND SrcRegNo1 /= x0 THEN
            IF SrcRegNo1 = DestRegNo_EX THEN
                AesData1O <= DestData_EX;
                AesData2O <= AesData2;
                AesData3O <= AesData3;
                AesData4O <= AesData4;
            ELSIF SrcRegNo1 = DestRegNo_MEM THEN
                AesData1O <= DestData_MEM;
                AesData2O <= AesData2;
                AesData3O <= AesData3;
                AesData4O <= AesData4;
            ELSE
                AesData1O <= AesData1;
                AesData2O <= AesData2;
                AesData3O <= AesData3;
                AesData4O <= AesData4;
            END IF;

            IF STD_LOGIC_VECTOR(unsigned(SrcRegNo1) + 1) = DestRegNo_EX THEN
                AesData1O <= AesData1;
                AesData2O <= DestData_EX;
                AesData3O <= AesData3;
                AesData4O <= AesData4;
            ELSIF STD_LOGIC_VECTOR(unsigned(SrcRegNo1) + 1) = DestRegNo_MEM THEN
                AesData1O <= AesData1;
                AesData2O <= DestData_MEM;
                AesData3O <= AesData3;
                AesData4O <= AesData4;
            ELSE
                AesData1O <= AesData1;
                AesData2O <= AesData2;
                AesData3O <= AesData3;
                AesData4O <= AesData4;
            END IF;

            IF STD_LOGIC_VECTOR(unsigned(SrcRegNo1) + 2) = DestRegNo_EX THEN
                AesData1O <= AesData1;
                AesData2O <= DestData_EX;
                AesData3O <= AesData3;
                AesData4O <= AesData4;
            ELSIF STD_LOGIC_VECTOR(unsigned(SrcRegNo1) + 2) = DestRegNo_MEM THEN
                AesData1O <= AesData1;
                AesData2O <= DestData_MEM;
                AesData3O <= AesData3;
                AesData4O <= AesData4;
            ELSE
                AesData1O <= AesData1;
                AesData2O <= AesData2;
                AesData3O <= AesData3;
                AesData4O <= AesData4;
            END IF;

            IF STD_LOGIC_VECTOR(unsigned(SrcRegNo1) + 3) = DestRegNo_EX THEN
                AesData1O <= AesData1;
                AesData2O <= DestData_EX;
                AesData3O <= AesData3;
                AesData4O <= AesData4;
            ELSIF STD_LOGIC_VECTOR(unsigned(SrcRegNo1) + 3) = DestRegNo_MEM THEN
                AesData1O <= AesData1;
                AesData2O <= DestData_MEM;
                AesData3O <= AesData3;
                AesData4O <= AesData4;
            ELSE
                AesData1O <= AesData1;
                AesData2O <= AesData2;
                AesData3O <= AesData3;
                AesData4O <= AesData4;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;