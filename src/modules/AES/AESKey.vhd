-- Note: this is a temporary module to provide the key
-- as long as it is not implemented to get the key from memory
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AESKey IS
    PORT (
        KeyO : OUT STD_LOGIC_VECTOR(127 DOWNTO 0) := x"000102030405060708090a0b0c0d0e0f"
    );
END ENTITY;