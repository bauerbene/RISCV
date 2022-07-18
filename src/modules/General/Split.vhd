LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Split IS
    PORT (
        I : IN STD_LOGIC_VECTOR(127 DOWNTO 0);

        Out1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Out2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Out3 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Out4 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END Split;

ARCHITECTURE Behavioral OF Split IS

BEGIN
    PROCESS (I)
    BEGIN
        Out1 <= I(127 DOWNTO 96);
        Out2 <= I(95 DOWNTO 64);
        Out3 <= I(63 DOWNTO 32);
        Out4 <= I(31 DOWNTO 0);
    END PROCESS;

END Behavioral;