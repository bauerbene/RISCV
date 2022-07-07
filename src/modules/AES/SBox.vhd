LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY SBox IS
    PORT (
        InByte           : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        ByteSubstitution : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END SBox;