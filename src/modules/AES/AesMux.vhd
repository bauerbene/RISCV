LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AesMux IS
    PORT (
        AesEncrypt       : IN STD_LOGIC;
        AesDecrypt       : IN STD_LOGIC;
        EncryptedCypherI : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        DecryptedCypherI : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        CypherO          : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END AesMux;

ARCHITECTURE Behavioral OF AesMux IS
BEGIN
    PROCESS (AesEncrypt, AesDecrypt, EncryptedCypherI, DecryptedCypherI)
    BEGIN
        IF AesEncrypt = '1' THEN
            CypherO <= EncryptedCypherI;
        ELSIF AesDecrypt = '1' THEN
            CypherO <= DecryptedCypherI;
        END IF;
    END PROCESS;
END Behavioral;