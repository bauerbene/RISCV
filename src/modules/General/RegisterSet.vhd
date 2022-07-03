LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

USE IEEE.NUMERIC_STD.ALL;

ENTITY RegisterSet IS
    PORT (
        RdRegNo1 : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        RdRegNo2 : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        WrEn     : IN STD_LOGIC;
        WrRegNo  : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        WrData   : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Stall    : IN STD_LOGIC := '0';
        RdData1  : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        RdData2  : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Clock    : IN STD_LOGIC;
        Reset    : IN STD_LOGIC);
END RegisterSet;

ARCHITECTURE Behavioral OF RegisterSet IS

    TYPE TRegisters IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Registers : TRegisters;

BEGIN

    PROCESS (RdRegNo1, RdRegNo2, Registers)
    BEGIN
        RdData1 <= Registers(to_integer(unsigned(RdRegNo1)));
        RdData2 <= Registers(to_integer(unsigned(RdRegNo2)));
    END PROCESS;

    PROCESS (Reset, Clock, WrEn, WrRegNo, WrData, Stall)
    BEGIN
        IF (Reset = '0') THEN
            Registers <= (1 => x"00000001", OTHERS => x"00000000");
        ELSIF (WrEn = '1') AND (rising_edge(Clock)) AND (unsigned(WrRegNo) /= 0) AND Stall /= '1' THEN
            Registers(to_integer(unsigned(WrRegNo))) <= WrData;
        END IF;

    END PROCESS;

END Behavioral;