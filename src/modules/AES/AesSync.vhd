LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY AesSync IS
    PORT (
        Clock : IN STD_LOGIC;
        Reset : IN STD_LOGIC;

        AesStall : IN STD_LOGIC;

        EncryptCypherI   : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        DecryptCypherI   : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
        EncryptI         : IN STD_LOGIC;
        DecryptI         : IN STD_LOGIC;
        DestRegNoI       : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        AesWrToRamI      : IN STD_LOGIC;
        AesWrRamAddressI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        EncryptCypherO   : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
        DecryptCypherO   : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
        EncryptO         : OUT STD_LOGIC;
        DecryptO         : OUT STD_LOGIC;
        DestRegNoO       : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        AesWrToRamO      : OUT STD_LOGIC;
        AesWrRamAddressO : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END AesSync;

ARCHITECTURE Behavioral OF AesSync IS

BEGIN
    PROCESS (Reset, Clock)
    BEGIN
        IF Reset = '0' THEN
            EncryptCypherO <= (OTHERS => '-');
            DecryptCypherO <= (OTHERS => '-');
            EncryptO <= '0';
            DecryptO <= '0';
            DestRegNoO <= (OTHERS => '-');
        ELSIF rising_edge(Clock) THEN
            IF AesStall = '0' THEN
                EncryptCypherO <= EncryptCypherI;
                DecryptCypherO <= DecryptCypherI;
                EncryptO <= EncryptI;
                DecryptO <= DecryptI;
                DestRegNoO <= DestRegNoI;
                AesWrToRamO <= AesWrToRamI;
                AesWrRamAddressO <= AesWrRamAddressI;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;