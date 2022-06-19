-- todo documentation
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

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

    FUNCTION LB(AddressLastTwo : STD_LOGIC_VECTOR; MemoryData : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        IF AddressLastTwo = "00" THEN
            RETURN STD_LOGIC_VECTOR(resize(signed(MemoryData(7 DOWNTO 0)), 32));
        ELSIF AddressLastTwo = "01" THEN
            RETURN STD_LOGIC_VECTOR(resize(signed(MemoryData(15 DOWNTO 0)), 32));
        ELSIF AddressLastTwo = "10" THEN
            RETURN STD_LOGIC_VECTOR(resize(signed(MemoryData(23 DOWNTO 16)), 32));
        ELSE
            RETURN STD_LOGIC_VECTOR(resize(signed(MemoryData(31 DOWNTO 24)), 32));
        END IF;
    END;

    FUNCTION LBU(AddressLastTwo : STD_LOGIC_VECTOR; MemoryData : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        IF AddressLastTwo = "00" THEN
            RETURN STD_LOGIC_VECTOR(resize(unsigned(MemoryData(7 DOWNTO 0)), 32));
        ELSIF AddressLastTwo = "01" THEN
            RETURN STD_LOGIC_VECTOR(resize(unsigned(MemoryData(15 DOWNTO 0)), 32));
        ELSIF AddressLastTwo = "10" THEN
            RETURN STD_LOGIC_VECTOR(resize(unsigned(MemoryData(23 DOWNTO 16)), 32));
        ELSE
            RETURN STD_LOGIC_VECTOR(resize(unsigned(MemoryData(31 DOWNTO 24)), 32));
        END IF;
    END;

    FUNCTION LH(AddressLastTwo : STD_LOGIC_VECTOR; MemoryData : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        IF AddressLastTwo = "00" THEN
            RETURN STD_LOGIC_VECTOR(resize(signed(MemoryData(15 DOWNTO 0)), 32));
        ELSE
            RETURN STD_LOGIC_VECTOR(resize(signed(MemoryData(31 DOWNTO 16)), 32));
        END IF;
    END;

    FUNCTION LHU(AddressLastTwo : STD_LOGIC_VECTOR; MemoryData : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        IF AddressLastTwo = "00" THEN
            RETURN STD_LOGIC_VECTOR(resize(unsigned(MemoryData(15 DOWNTO 0)), 32));
        ELSE
            RETURN STD_LOGIC_VECTOR(resize(unsigned(MemoryData(31 DOWNTO 16)), 32));
        END IF;
    END;

BEGIN

    PROCESS (Sel, MemoryDataIn, ALUDataIn, FunctI)
    BEGIN
        IF Sel = '1' THEN
            CASE FunctI IS
                WHEN funct_LB =>
                    WrData <= LB(ALUDataIn(1 DOWNTO 0), MemoryDataIn);
                WHEN funct_LBU =>
                    WrData <= LBU(ALUDataIn(1 DOWNTO 0), MemoryDataIn);
                WHEN funct_LH =>
                    WrData <= LH(ALUDataIn(1 DOWNTO 0), MemoryDataIn);
                WHEN funct_LHU =>
                    WrData <= LHU(ALUDataIn(1 DOWNTO 0), MemoryDataIn);
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