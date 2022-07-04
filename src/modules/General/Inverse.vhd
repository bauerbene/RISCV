LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY inverse IS
    PORT (
        val : IN STD_LOGIC;
        inv : OUT STD_LOGIC);
END inverse;

ARCHITECTURE inv_Behaviour OF inverse IS

BEGIN

    inv <= NOT val;

END ARCHITECTURE;