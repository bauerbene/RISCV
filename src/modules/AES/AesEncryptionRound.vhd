LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.AesEncryptionOperations.ALL;

ENTITY AesEncryptionRound IS
    PORT (
        CypherI  : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        RoundKey : IN STD_LOGIC_VECTOR(127 DOWNTO 0);

        CypherO : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END AesEncryptionRound;

ARCHITECTURE Behavioral OF AESEncryptionRound IS
BEGIN
    PROCESS (CypherI, RoundKey)
        VARIABLE CurrentCypher : STD_LOGIC_VECTOR(127 DOWNTO 0);
    BEGIN
        CurrentCypher := SubBytes(CypherI);
        CurrentCypher := ShiftRows(CurrentCypher);
        CurrentCypher := MixColumns(CurrentCypher);
        CypherO <= AddRoundKey(CurrentCypher, RoundKey);
    END PROCESS;
END Behavioral;