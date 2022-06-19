-- todo documentation
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

USE work.constants.ALL;

ENTITY MemMux IS
    PORT (
        ALUDataIn    : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        MemoryDataIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Sel          : IN STD_LOGIC;
        FunctI       : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

        WrData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END MemMux;

ARCHITECTURE Behavioral OF MemMux IS
BEGIN

    PROCESS (Sel, MemoryDataIn, ALUDataIn, FunctI)
    BEGIN
        IF Sel = '1' THEN
            CASE FunctI IS
                WHEN funct_LB =>
                    WrData <= STD_LOGIC_VECTOR(x"FFFFFF" & MemoryDataIn(31 DOWNTO 24));
                WHEN funct_LBU =>
                    WrData <= STD_LOGIC_VECTOR(x"000000" & MemoryDataIn(31 DOWNTO 24));
                WHEN funct_LH =>
                    WrData <= STD_LOGIC_VECTOR(x"FFFF" & MemoryDataIn(31 DOWNTO 16));
                WHEN funct_LHU =>
                    WrData <= STD_LOGIC_VECTOR(x"0000" & MemoryDataIn(31 DOWNTO 16));
                WHEN funct_LW =>
                    WrData <= MemoryDataIn;
                WHEN OTHERS =>
                    NULL; -- maybe handle this case
            END CASE;
        ELSE
            WrData <= ALUDataIn;
        END IF;

    END PROCESS;
END Behavioral;