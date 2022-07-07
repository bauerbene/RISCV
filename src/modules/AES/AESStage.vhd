LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY AESStage IS
    PORT (
        Clock      : IN STD_LOGIC;
        Reset      : IN STD_LOGIC;
        AesEncrypt : IN STD_LOGIC;
        AesDecrypt : IN STD_LOGIC;
        Data       : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        AesStallO : OUT STD_LOGIC

    );
END AESStage;

ARCHITECTURE Behavioral OF AESStage IS
    TYPE state_type IS (Idle, Encrypt, Decrypt);
    SIGNAL currentState : state_type;
BEGIN
    PROCESS (Reset, Clock)
    BEGIN
        IF Reset = '0' THEN
            currentState <= Idle;
            AesStallO <= '0';
        ELSIF rising_edge(Clock) THEN

            CASE currentState IS
                WHEN Idle =>
                    IF AesEncrypt = '1' THEN
                        -- todo output values for first round
                        AesStallO <= '1';
                        currentState <= Encrypt;
                    ELSIF AesDecrypt = '1' THEN
                        -- todo output values for first decrypt round
                        AesStallO <= '1';
                        currentState <= Decrypt;
                    END IF;
                WHEN Encrypt =>
                    -- since there is a fix number of 10 count the rounds until no longer busy
                WHEN Decrypt =>
                    -- same as for encrypt
                WHEN OTHERS => NULL;
            END CASE;

        END IF;
    END PROCESS;

END Behavioral;