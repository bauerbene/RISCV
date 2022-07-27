LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

USE IEEE.NUMERIC_STD.ALL;
USE work.constants.ALL;

ENTITY RegisterSet IS
    PORT (
        RdRegNo1             : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        RdRegNo2             : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        WrEn                 : IN STD_LOGIC;
        WrRegNo              : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        WrData               : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Stall                : IN STD_LOGIC := '0';
        RdData1              : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        RdData2              : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        LoadAesData          : IN STD_LOGIC := '0';
        AesData1             : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesData2             : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesData3             : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesData4             : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Clock                : IN STD_LOGIC;
        Reset                : IN STD_LOGIC;
        AesWr                : IN STD_LOGIC;
        AesWrData1           : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesWrData2           : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesWrData3           : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesWrData4           : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesDestRegNo         : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        AesWrRamAddressRegNo : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        AesWrRamAddress      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END RegisterSet;

ARCHITECTURE Behavioral OF RegisterSet IS

    TYPE TRegisters IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Registers : TRegisters;

BEGIN

    PROCESS (RdRegNo1, RdRegNo2, Registers, LoadAesData, AesWrRamAddressRegNo)
    BEGIN
        RdData1 <= Registers(to_integer(unsigned(RdRegNo1)));
        RdData2 <= Registers(to_integer(unsigned(RdRegNo2)));
        IF LoadAesData = '1' THEN
            AesData1 <= Registers(to_integer(unsigned(RdRegNo1)));
            AesData2 <= Registers(to_integer(unsigned(RdRegNo1)) + 1);
            AesData3 <= Registers(to_integer(unsigned(RdRegNo1)) + 2);
            AesData4 <= Registers(to_integer(unsigned(RdRegNo1)) + 3);
        END IF;
        AesWrRamAddress <= Registers(to_integer(unsigned(AesWrRamAddressRegNo)));
    END PROCESS;

    PROCESS (Reset, Clock)
    BEGIN
        IF (Reset = '0') THEN
            Registers <= (1 => x"00000001", OTHERS => x"00000000");
        ELSIF rising_edge(Clock) THEN
            IF WrRegNo /= x0 AND Stall /= '1' AND WrEn = '1' AND AesWr = '0' THEN
                Registers(to_integer(unsigned(WrRegNo))) <= WrData;
            ELSIF AesWr = '1' THEN
                Registers(to_integer(unsigned(AesDestRegNo))) <= AesWrData1;
                Registers(to_integer(unsigned(AesDestRegNo)) + 1) <= AesWrData2;
                Registers(to_integer(unsigned(AesDestRegNo)) + 2) <= AesWrData3;
                Registers(to_integer(unsigned(AesDestRegNo)) + 3) <= AesWrData4;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;