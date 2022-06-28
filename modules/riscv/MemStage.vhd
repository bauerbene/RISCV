----------------------------------------------
-- TODO add documentation
----------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY MemStage IS
    PORT (
        Clock      : IN STD_LOGIC;
        Reset      : IN STD_LOGIC;
        DestDataI  : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DestWrEnI  : IN STD_LOGIC;
        DestRegNoI : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        MemAccessI : IN STD_LOGIC;
        MemWrData  : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        MemByteEna : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        FunctI     : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        StallI     : IN STD_LOGIC;
        RamRdData  : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        RamBusy    : IN STD_LOGIC;

        DestDataO  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        DestWrEnO  : OUT STD_LOGIC;
        DestRegNoO : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        MemAccessO : OUT STD_LOGIC;
        -- MemRdData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        FunctO     : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        RamReadEn  : OUT STD_LOGIC;
        RamWriteEn : OUT STD_LOGIC;
        RamByteEna : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        RamAddress : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        RamWrData  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        StallO     : OUT STD_LOGIC
    );
END MemStage;

ARCHITECTURE Behavioral OF MemStage IS
    TYPE state_type IS (Idle, Stalled);
    SIGNAL currentState : state_type;
BEGIN
    PROCESS (Reset, Clock)
    BEGIN
        IF Reset = '0' THEN
            DestDataO <= x"00000000";
            DestWrEnO <= '0';
            DestRegNoO <= "00000";
            MemAccessO <= '0';
            RamReadEn <= '0';
            RamWriteEn <= '0';
            -- MemRdData <= x"00000000";
            FunctO <= "000";
            StallO <= '0';
            currentState <= Idle;
        ELSIF rising_edge(Clock) THEN

            -- Stall state machine
            CASE currentState IS
                WHEN Idle =>
                    IF MemAccessI = '1' THEN
                        StallO <= '1';
                        currentState <= Stalled;
                    END IF;
                WHEN Stalled =>
                    StallO <= '0';
                    currentState <= Idle;
                WHEN OTHERS => NULL;
            END CASE;

            IF StallI = '0' THEN
                DestDataO <= DestDataI;
                DestWrEnO <= DestWrEnI;
                DestRegNoO <= DestRegNoI;
                MemAccessO <= MemAccessI;
                -- MemRdData <= MemWrData;
                FunctO <= FunctI;
            END IF;
        END IF;
    END PROCESS;
END Behavioral;