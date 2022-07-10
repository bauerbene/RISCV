LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.AesGeneralOperations.ALL;
USE work.AesDecryptionOperations.ALL;

ENTITY AesDecryptionFirstRound IS
    PORT (
        CypherI  : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        RoundKey : IN STD_LOGIC_VECTOR(127 DOWNTO 0);

        CypherO : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END AesDecryptionFirstRound;

ARCHITECTURE Behavioral OF AesDecryptionFirstRound IS

BEGIN
    PROCESS (CypherI, RoundKey)
        VARIABLE CurrentCypher : STD_LOGIC_VECTOR(127 DOWNTO 0);
    BEGIN
        CurrentCypher := AddRoundKey(CypherI, RoundKey);
        CurrentCypher := InvShiftRows(CurrentCypher);
        CypherO <= InvSubBytes(CurrentCypher);
    END PROCESS;
END Behavioral;