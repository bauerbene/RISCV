LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY AesStage IS
    PORT (
        Clock         : IN STD_LOGIC;
        Reset         : IN STD_LOGIC;
        AesEncrypt    : IN STD_LOGIC;
        AesDecrypt    : IN STD_LOGIC;
        CypherI       : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        WrCypherToRam : IN STD_LOGIC;
        RamWrAddress  : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Stall         : IN STD_LOGIC;
        DestRegNoI    : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        CypherO       : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
        DestRegNoO    : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        AesStallO     : OUT STD_LOGIC;
        AesMemAddress : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesMemAccessO : OUT STD_LOGIC;
        AesMemWrData  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

    );
END AesStage;

ARCHITECTURE Behavioral OF AESStage IS
    TYPE state_type IS (Idle, AesWriteRegister, AesWriteRam);
    SIGNAL currentState : state_type;
BEGIN
    PROCESS (Reset, Clock)
        VARIABLE addressCounter : INTEGER := 0;
        VARIABLE initialAddress : INTEGER := 0;
        VARIABLE bitCounter : NATURAL := 0;
        VARIABLE CypherToWriteToRam : STD_LOGIC_VECTOR(127 DOWNTO 0);
    BEGIN
        IF Reset = '0' THEN
            currentState <= Idle;
            AesStallO <= '0';
            DestRegNoO <= (OTHERS => '-');
        ELSIF rising_edge(Clock) THEN
            IF Stall = '0' THEN
                CASE currentState IS
                    WHEN Idle =>
                        IF (AesEncrypt = '1' OR AesDecrypt = '1') AND WrCypherToRam = '0' THEN
                            AesStallO <= '1';
                            currentState <= AesWriteRegister;
                            CypherO <= CypherI;
                            DestRegNoO <= DestRegNoI;
                        ELSIF (AesEncrypt = '1' OR AesDecrypt = '1') AND WrCypherToRam = '1' THEN
                            AesStallO <= '1';
                            currentState <= AesWriteRam;
                            CypherO <= CypherI;
                            AesMemAccessO <= '1';
                            AesMemAddress <= RamWrAddress;
                            AesMemWrData <= CypherI(127 DOWNTO 96);
                            CypherToWriteToRam := CypherI;
                            addressCounter := to_integer(unsigned(RamWrAddress));
                            initialAddress := addressCounter;
                        END IF;
                    WHEN AesWriteRegister =>
                        AesStallO <= '0';
                        currentState <= Idle;
                    WHEN AesWriteRam =>
                        addressCounter := addressCounter + 4;
                        bitCounter := bitCounter + 32;
                        AesMemAddress <= STD_LOGIC_VECTOR(to_unsigned(initialAddress + addressCounter, 32));
                        AesMemAccessO <= '1';
                        AesMemWrData <= CypherToWriteToRam(127 - bitCounter DOWNTO 127 - bitCounter - 31);
                        CypherO <= CypherI;
                        IF addressCounter = initialAddress + 12 THEN
                            AesStallO <= '0';
                            currentState <= Idle;
                            bitCounter := 0;
                            addressCounter := 0;
                            AesMemAccessO <= '0';
                        END IF;
                    WHEN OTHERS => NULL;
                END CASE;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;