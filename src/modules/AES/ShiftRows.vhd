LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ShiftRows IS
    PORT (
        CypherI : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        CypherO : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
END ShiftRows;

ARCHITECTURE Behavioral OF ShiftRows IS

    -- CypherI(127 downto 120) CypherI(119 downto 112) CypherI(111 downto 104) CypherI(103 downto 96)
    -- CypherI(95 downto 88)   CypherI(87 downto 80)   CypherI(79 downto 73)   CypherI(71 downto 65)
    -- CypherI(63 downto 56)   CypherI(55 downto 48)   CypherI(47 downto 40)   CypherI(39 downto 32)
    -- CypherI(31 downto 24)   CypherI(23 downto 16)   CypherI(15 downto 8)    CypherI(7 downto 0)

    -- row 0: CypherI(127 downto 120) CypherI(95 downto 88) CypherI(63 downto 56) CypherI(31 downto 24)
    -- row 1: CypherI(119 downto 112) CypherI(87 downto 80) CypherI(55 downto 48) CypherI(23 downto 16)
    -- row 2: CypherI(111 downto 104) CypherI(79 downto 72) CypherI(47 downto 40) CypherI(15 downto 8)
    -- row 3:  CypherI(103 downto 96) CypherI(71 downto 64) CypherI(39 downto 32) CypherI(7 downto 0)
BEGIN
    PROCESS (CypherI)
    BEGIN
        -- dont shift row 0
        CypherO(127 DOWNTO 120) <= CypherI(127 DOWNTO 120);
        CypherO(95 DOWNTO 88) <= CypherI(95 DOWNTO 88);
        CypherO(63 DOWNTO 56) <= CypherI(63 DOWNTO 56);
        CypherO(31 DOWNTO 24) <= CypherI(31 DOWNTO 24);

        -- shift row 1 by 1 byte left
        CypherO(119 DOWNTO 112) <= CypherI(87 DOWNTO 80);
        CypherO(87 DOWNTO 80) <= CypherI(55 DOWNTO 48);
        CypherO(55 DOWNTO 48) <= CypherI(23 DOWNTO 16);
        CypherO(23 DOWNTO 16) <= CypherI(119 DOWNTO 112);

        -- shift row 2 by 2 bytes left
        CypherO(111 DOWNTO 104) <= CypherI(47 DOWNTO 40);
        CypherO(79 DOWNTO 72) <= CypherI(15 DOWNTO 8);
        CypherO(47 DOWNTO 40) <= CypherI(111 DOWNTO 104);
        CypherO(15 DOWNTO 8) <= CypherI(79 DOWNTO 72);

        -- shift row 3 by 3 bytes left
        CypherO(103 DOWNTO 96) <= CypherI(7 DOWNTO 0);
        CypherO(71 DOWNTO 64) <= CypherI(103 DOWNTO 96);
        CypherO(39 DOWNTO 32) <= CypherI(71 DOWNTO 64);
        CypherO(7 DOWNTO 0) <= CypherI(39 DOWNTO 32);
    END PROCESS;

END Behavioral;