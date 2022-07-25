LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY AesSync IS
    PORT (
        Clock          : IN STD_LOGIC;
        Reset          : IN STD_LOGIC;
        EncryptCypherI : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        EncryptCypherO : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
        DecryptCypherI : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        DecryptCypherO : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
        EncryptI       : IN STD_LOGIC;
        DecryptI       : IN STD_LOGIC;
        EncryptO       : OUT STD_LOGIC;
        DecryptO       : OUT STD_LOGIC
    );
END AesSync;

ARCHITECTURE Behavioral OF AesSync IS

BEGIN
    PROCESS (Reset, Clock)
    BEGIN
        IF Reset = '0' THEN
            EncryptCypherO <= (OTHERS => '-');
            DecryptCypherO <= (OTHERS => '-');
            EncryptO <= '0';
            DecryptO <= '0';
        ELSIF rising_edge(Clock) THEN
            EncryptCypherO <= EncryptCypherI;
            DecryptCypherO <= DecryptCypherI;
            EncryptO <= EncryptI;
            DecryptO <= DecryptI;
        END IF;
    END PROCESS;

END Behavioral;