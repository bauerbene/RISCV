----------------------------------------------
-- TODO add documentation
----------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY MemStage IS
    PORT (
        -- Clock      : IN STD_LOGIC;
        -- Reset      : IN STD_LOGIC;
        DestDataI  : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DestWrEnI  : IN STD_LOGIC;
        DestRegNoI : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        -- MemAccessI : IN STD_LOGIC;
        -- MemWrData  : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        -- MemByteEna : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        -- FunctI : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        -- StallI : IN STD_LOGIC;

        DestDataO  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        DestWrEnO  : OUT STD_LOGIC;
        DestRegNoO : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
        -- MemAccessO : OUT STD_LOGIC;
        -- MemRdData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        -- FunctO : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        -- StallO : OUT STD_LOGIC
    );
END MemStage;

ARCHITECTURE Behavioral OF MemStage IS
BEGIN
    DestDataO <= DestDataI;
    DestWrEnO <= DestWrEnI;
    DestRegNoO <= DestRegNoI;
    -- MemAccessO <= MemAccessI;
    -- MemRdData <= MemWrData;
    -- FunctO <= FunctI;
    -- StallO <= StallI;
END Behavioral;