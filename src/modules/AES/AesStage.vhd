LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY AesStage IS
    PORT (
        Clock      : IN STD_LOGIC;
        Reset      : IN STD_LOGIC;
        AesEncrypt : IN STD_LOGIC;
        AesDecrypt : IN STD_LOGIC;
        CypherI    : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        CypherO    : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
        Stall      : IN STD_LOGIC;
        DestRegNoI : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        DestRegNoO : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);

        AesStallO : OUT STD_LOGIC

    );
END AesStage;

ARCHITECTURE Behavioral OF AESStage IS
    TYPE state_type IS (Idle, AesWrite);
    SIGNAL currentState : state_type;
BEGIN
    PROCESS (Reset, Clock)
    BEGIN
        IF Reset = '0' THEN
            currentState <= Idle;
            AesStallO <= '0';
            DestRegNoO <= (OTHERS => '-');
        ELSIF rising_edge(Clock) THEN
            IF Stall = '0' THEN
                CASE currentState IS
                    WHEN Idle =>
                        IF AesEncrypt = '1' OR AesDecrypt = '1' THEN
                            AesStallO <= '1';
                            currentState <= AesWrite;
                            CypherO <= CypherI;
                            DestRegNoO <= DestRegNoI;
                        END IF;
                    WHEN AesWrite =>
                        AesStallO <= '0';
                        currentState <= Idle;
                    WHEN OTHERS => NULL;
                END CASE;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;