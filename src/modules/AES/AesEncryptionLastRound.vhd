LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.AesEncryptionOperations.ALL;
USE work.AesGeneralOperations.ALL;

ENTITY AesEncryptionLastRound IS
    PORT (
        CypherI  : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        RoundKey : IN STD_LOGIC_VECTOR(127 DOWNTO 0);

        CypherO : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END AesEncryptionLastRound;

ARCHITECTURE Behavioral OF AesEncryptionLastRound IS

BEGIN
    PROCESS (CypherI, RoundKey)
        VARIABLE CurrentCypher : STD_LOGIC_VECTOR(127 DOWNTO 0);
    BEGIN
        CurrentCypher := SubBytes(CypherI);
        CurrentCypher := ShiftRows(CurrentCypher);
        CypherO <= AddRoundKey(CurrentCypher, RoundKey);
    END PROCESS;
END Behavioral;