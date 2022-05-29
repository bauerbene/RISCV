-----------------
-- TODO add documentation
-----------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY DecodeStage IS
    PORT (
        Clock      : IN STD_LOGIC;
        Reset      : IN STD_LOGIC;
        InstI      : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        PCI        : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        InterlockI : IN STD_LOGIC;
        ClearI     : IN STD_LOGIC;
        Stall      : IN STD_LOGIC;

        InstO      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        PCO        : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        InterlockO : OUT STD_LOGIC;
        ClearO     : OUT STD_LOGIC
    );
END DecodeStage;

ARCHITECTURE Behavioral OF DecodeStage IS
BEGIN
    PROCESS (Clock, Reset)
    BEGIN
        InstO <= InstI;
        PCO <= PCI;
        InterlockO <= InterlockI;
        ClearO <= ClearI;
    END PROCESS;
END Behavioral;