LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Combine IS
    PORT (
        In1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        In2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        In3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        In4 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        O : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END Combine;

ARCHITECTURE Behavioral OF Combine IS
BEGIN
    PROCESS (In1, In2, In3, In4)
    BEGIN
        O <= In1 & In2 & In3 & In4;
    END PROCESS;

END Behavioral;