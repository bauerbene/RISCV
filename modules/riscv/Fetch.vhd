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
        PCNext     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        PC         : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        ImemAddr   : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END Fetch;

ARCHITECTURE Behavioral OF Fetch IS
    VARIABLE varPCNext : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
BEGIN
    PROCESS (PCI, Jump, JumpTarget)
    BEGIN
        varPCNext := STD_LOGIC_VECTOR(unsigned(PCI) + 4);

        PC <= PCI;
        ImemAddr <= varPCNext(11 DOWNTO 2);
        IF Jump = '1' THEN
            PCNext <= JumpTarget;
        ELSE
            PCNext <= varPCNext;
        END IF;
    END PROCESS;

END Behavioral;