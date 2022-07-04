LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY SevenSeg IS
    PORT (
        Clock : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        V     : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Set   : IN STD_LOGIC;
        Pmod0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Pmod1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Pmod2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Pmod3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE Behavioral OF SevenSeg IS
    SIGNAL State : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Seg1, Seg2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL currentDigit : STD_LOGIC;
    VARIABLE counter : INTEGER := 0;
BEGIN

    PROCESS (Reset, Clock)
    BEGIN
        IF Reset = '0' THEN
            State <= (OTHERS => '0');
            Seg1 <= (OTHERS => '0');
            Seg2 <= (OTHERS => '0');
            currentDigit <= '0';
            counter := 0;
        ELSIF rising_edge(Clock) THEN
            IF Set = '1' THEN
                State <= V;
            END IF;

            Pmod0 <= Seg1(3 DOWNTO 0);
            Pmod1 <= Seg1(7 DOWNTO 4);
            Pmod2 <= Seg2(3 DOWNTO 0);
            Pmod3 <= Seg2(7 DOWNTO 4);

            Seg1(7) <= currentDigit;
            Seg2(7) <= currentDigit;

            IF currentDigit = '0' THEN
                Seg1(6 DOWNTO 0) <= State(6 DOWNTO 0);
                Seg2(6 DOWNTO 0) <= State(22 DOWNTO 16);
            ELSE
                Seg1(6 DOWNTO 0) <= State(14 DOWNTO 8);
                Seg2(6 DOWNTO 0) <= State(30 DOWNTO 24);
            END IF;

            counter := counter + 1;

            IF counter = 1000000 THEN
                counter := 0;
                IF currentDigit = '0' THEN
                    currentDigit <= '1';
                ELSE
                    currentDigit <= '0';
                END IF;
            END IF;

        END IF;
    END PROCESS;

END Behavioral;