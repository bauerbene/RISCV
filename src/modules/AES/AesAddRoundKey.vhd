LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE work.AesGeneralOperations.ALL;

ENTITY AesAddRoundKey IS
    PORT (
        RoundKey : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        CypherI  : IN STD_LOGIC_VECTOR(127 DOWNTO 0);

        CypherO : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END AesAddRoundKey;

ARCHITECTURE Behavioral OF AesAddRoundKey IS

BEGIN

    PROCESS (RoundKey, CypherI)
    BEGIN
        CypherO <= AddRoundKey(CypherI, RoundKey);
    END PROCESS;

END Behavioral;