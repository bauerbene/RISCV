--------------------------
-- todo docu
--------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FetchStage IS
    PORT (
        Clock : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        PCI   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        PCO   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END FetchStage;

ARCHITECTURE Behavioral OF FetchStage IS
BEGIN

    PROCESS (Reset, Clock)
    BEGIN
        IF Reset = '0' THEN
            PCO <= x"fffffffc";
        ELSIF rising_edge(Clock) THEN
            PCO <= PCI;
        END IF;
    END PROCESS;
END Behavioral;