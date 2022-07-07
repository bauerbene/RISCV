LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ZeroPadding IS
    PORT (
        DataI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DataO : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ZeroPadding;

ARCHITECTURE Behavioral OF ZeroPadding IS

BEGIN

    PROCESS (DataI)
    BEGIN
        DataO <= DataI & x"000000000000000000000000";
    END PROCESS;

END Behavioral;