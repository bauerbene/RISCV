------------------------
-- TODO documentation
------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Fetch IS
    PORT (
        PCI        : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Jump       : IN STD_LOGIC;
        JumpTarget : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        InterlockI : IN STD_LOGIC;
        Stall      : IN STD_LOGIC;
        AesStall   : IN STD_LOGIC;
        PCNext     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        PC         : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        ImemAddr   : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END Fetch;

ARCHITECTURE Behavioral OF Fetch IS
BEGIN

    PROCESS (PCI, Jump, JumpTarget, InterlockI, Stall, AesStall)
        VARIABLE varPCNext : STD_LOGIC_VECTOR(31 DOWNTO 0);
    BEGIN
        IF Jump = '1' THEN
            varPCNext := JumpTarget;
        ELSE
            IF InterlockI = '1' THEN
                varPCNext := PCI;
            ELSE
                varPCNext := STD_LOGIC_VECTOR (unsigned(PCI) + 4);
            END IF;
        END IF;

        PC <= PCI;

        IF Stall = '0' AND AesStall = '0' THEN
            PCNext <= varPCNext;
            ImemAddr <= varPCNext(11 DOWNTO 2);
        END IF;
    END PROCESS;

END Behavioral;