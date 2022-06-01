-----------------------------------------------------
-- TODO documentations
-----------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

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

END Behavioral;