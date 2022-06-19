-- todo documentation
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MemMux IS
    PORT (
        ALUDataIn    : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        MemoryDataIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Sel          : IN STD_LOGIC;
        --FunctI       : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

        WrData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END MemMux;

ARCHITECTURE Behavioral OF MemMux IS
BEGIN

    PROCESS (Sel, MemoryDataIn, ALUDataIn)
    BEGIN
        IF Sel = '1' THEN
            WrData <= MemoryDataIn;
        ELSE
            WrData <= ALUDataIn;
        END IF;
    END PROCESS;
END Behavioral;