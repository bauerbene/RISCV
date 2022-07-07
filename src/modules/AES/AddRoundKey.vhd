LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY AddRoundKey IS
    PORT (
        RoundKey       : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        CurrentCypherI : IN STD_LOGIC_VECTOR(127 DOWNTO 0);

        CurrentCypherO : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)

    );
END AddRoundKey;

ARCHITECTURE Behavioral OF AddRoundKey IS

BEGIN

    PROCESS (RoundKey, CurrentCypherI)
    BEGIN
        CurrentCypherO <= RoundKey XOR CurrentCypherI;
    END PROCESS;

END Behavioral;