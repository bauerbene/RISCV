LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY AesStageStart IS
    PORT (
        Clock : IN STD_LOGIC;
        Reset : IN STD_LOGIC;

        CypherI    : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        EncryptI   : IN STD_LOGIC;
        DecryptI   : IN STD_LOGIC;
        DestRegNoI : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        CypherO    : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
        EncryptO   : OUT STD_LOGIC;
        DecryptO   : OUT STD_LOGIC;
        DestRegNoO : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)

    );
END AesStageStart;

ARCHITECTURE Behavioral OF AesStageStart IS

BEGIN

    PROCESS (Clock, Reset)
    BEGIN
        IF Reset = '0' THEN
            CypherO <= (OTHERS => '-');
            EncryptO <= '-';
            DecryptO <= '-';
            DestRegNoO <= (OTHERS => '-');
        ELSIF rising_edge(Clock) THEN
            CypherO <= CypherI;
            EncryptO <= EncryptI;
            DecryptO <= DecryptI;
            DestRegNoO <= DestRegNoI;
        END IF;
    END PROCESS;

END Behavioral;