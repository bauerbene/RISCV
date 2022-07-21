LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

USE IEEE.NUMERIC_STD.ALL;
USE work.constants.ALL;

ENTITY RegisterSet IS
    PORT (
        RdRegNo1   : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        RdRegNo2   : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        WrEn       : IN STD_LOGIC;
        WrRegNo    : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        WrData     : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Stall      : IN STD_LOGIC := '0';
        RdData1    : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        RdData2    : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        AesData1   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesData2   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesData3   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesData4   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Clock      : IN STD_LOGIC;
        Reset      : IN STD_LOGIC;
        AesWr      : IN STD_LOGIC;
        AesWrData1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesWrData2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesWrData3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        AesWrData4 : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END RegisterSet;

ARCHITECTURE Behavioral OF RegisterSet IS

    TYPE TRegisters IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Registers : TRegisters;

BEGIN

    AesData1 <= Registers(to_integer(unsigned(x1)));
    AesData2 <= Registers(to_integer(unsigned(x2)));
    AesData3 <= Registers(to_integer(unsigned(x3)));
    AesData4 <= Registers(to_integer(unsigned(x4)));

    PROCESS (RdRegNo1, RdRegNo2, Registers)
    BEGIN
        RdData1 <= Registers(to_integer(unsigned(RdRegNo1)));
        RdData2 <= Registers(to_integer(unsigned(RdRegNo2)));
    END PROCESS;

    PROCESS (Reset, Clock)
    BEGIN
        IF (Reset = '0') THEN
            Registers <= (1 => x"00000001", OTHERS => x"00000000");
        ELSIF rising_edge(Clock) AND unsigned(WrRegNo) /= 0 AND Stall /= '1' AND WrEn = '1' THEN
            Registers(to_integer(unsigned(WrRegNo))) <= WrData;
        END IF;
        IF rising_edge(Clock) AND AesWr = '1' THEN
            Registers(to_integer(unsigned(x1))) <= AesWrData1;
            Registers(to_integer(unsigned(x2))) <= AesWrData2;
            Registers(to_integer(unsigned(x3))) <= AesWrData3;
            Registers(to_integer(unsigned(x4))) <= AesWrData4;
        END IF;
    END PROCESS;

END Behavioral;