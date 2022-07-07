LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY SubBytes IS
    PORT (
        CurrentCypher   : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        TempSubstituion : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END SubBytes;

ARCHITECTURE Behavioral OF SubBytes IS
BEGIN

END Behavioral;