LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY AesStageStart IS
    PORT (
        Clock : IN STD_LOGIC;
        Reset : IN STD_LOGIC;

        CypherI          : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        EncryptI         : IN STD_LOGIC;
        DecryptI         : IN STD_LOGIC;
        DestRegNoI       : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        AesWrToRamI      : IN STD_LOGIC;
        AesWrRamAddressI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesRdFromRamI    : IN STD_LOGIC;
        AesRdRamAddressI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Stall            : IN STD_LOGIC;
        LastAddressI     : IN STD_LOGIC;
        AesDataFromRamEn : IN STD_LOGIC;
        AesDataFromRam   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        CypherO            : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
        EncryptO           : OUT STD_LOGIC;
        DecryptO           : OUT STD_LOGIC;
        DestRegNoO         : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        AesWrToRamO        : OUT STD_LOGIC;
        AesWrToRamAddressO : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesRdStallO        : OUT STD_LOGIC;
        AesMemRdAddressO   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesMemRdAccessO    : OUT STD_LOGIC;
        LastAddressO       : OUT STD_LOGIC;
        StallO             : OUT STD_LOGIC
    );
END AesStageStart;

ARCHITECTURE Behavioral OF AesStageStart IS
    TYPE state_type IS (Idle, AesRdFromRam, WaitForLastRamData);
    SIGNAL currentState : state_type;
BEGIN

    PROCESS (Clock, Reset)
        VARIABLE addressCounter : INTEGER := 0;
        VARIABLE initialAddress : INTEGER := 0;
        VARIABLE currentCypher : STD_LOGIC_VECTOR(127 DOWNTO 0);
        VARIABLE currentCypherRdState : INTEGER := 0;
        VARIABLE destRegNoRd : STD_LOGIC_VECTOR(4 DOWNTO 0);
    BEGIN
        IF Reset = '0' THEN
            CypherO <= (OTHERS => '-');
            EncryptO <= '-';
            DecryptO <= '-';
            DestRegNoO <= (OTHERS => '-');
            LastAddressO <= '0';
        ELSIF rising_edge(Clock) THEN
            CASE currentState IS
                WHEN Idle =>
                    IF AesRdFromRamI = '1' THEN
                        currentState <= AesRdFromRam;
                        AesMemRdAccessO <= '1';
                        AesMemRdAddressO <= AesRdRamAddressI;
                        addressCounter := 0;
                        initialAddress := to_integer(unsigned(AesRdRamAddressI));
                        destRegNoRd := DestRegNoI;
                    ELSE
                        CypherO <= CypherI;
                        EncryptO <= EncryptI;
                        DecryptO <= DecryptI;
                        DestRegNoO <= DestRegNoI;
                        AesWrToRamO <= AesWrToRamI;
                        AesWrToRamAddressO <= AesWrRamAddressI;
                    END IF;
                WHEN AesRdFromRam =>
                    IF Stall = '0' THEN
                        addressCounter := addressCounter + 4;
                        AesMemRdAccessO <= '1';
                        AesMemRdAddressO <= STD_LOGIC_VECTOR(to_unsigned(initialAddress + addressCounter, 32));
                        IF addressCounter = 12 THEN
                            LastAddressO <= '1';
                            currentState <= WaitForLastRamData;
                            StallO <= '0';
                            initialAddress := 0;
                            addressCounter := 0;
                            AesMemRdAccessO <= '0';
                        END IF;
                        IF AesDataFromRamEn = '1' THEN
                            currentCypher(127 - currentCypherRdState DOWNTO 127 - currentCypherRdState - 31) := AesDataFromRam;
                            currentCypherRdState := currentCypherRdState + 32;
                        END IF;
                    END IF;
                WHEN WaitForLastRamData =>
                    IF LastAddressI = '1' THEN
                        currentCypher(31 DOWNTO 0) := AesDataFromRam;
                        CypherO <= currentCypher;
                        DecryptO <= '1';
                        DestRegNoO <= destRegNoRd;
                        destRegNoRd := (OTHERS => '-');
                        AesWrToRamO <= '0';
                        AesWrToRamAddressO <= (OTHERS => '-');
                    END IF;
                WHEN OTHERS =>
                    NULL;
            END CASE;
        END IF;
    END PROCESS;

END Behavioral;