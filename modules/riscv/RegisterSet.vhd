----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2022 03:54:30 PM
-- Design Name: 
-- Module Name: RegisterSet - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY RegisterSet IS
    PORT (
        RdRegNo1 : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        RdRegNo2 : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        WrEn     : IN STD_LOGIC;
        WrRegNo  : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        WrData   : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        RdData1  : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        RdData2  : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Clock    : IN STD_LOGIC;
        Reset    : IN STD_LOGIC);
END RegisterSet;

ARCHITECTURE Behavioral OF RegisterSet IS

    TYPE TRegisters IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Registers : TRegisters;

BEGIN

    PROCESS (RdRegNo1, RdRegNo2)
    BEGIN
        IF NOT RdRegNo1 = "UUUU" THEN
            RdData1 <= Registers(to_integer(unsigned(RdRegNo1)));
        END IF;
        IF NOT RdRegNo2 = "UUUU" THEN
            RdData2 <= Registers(to_integer(unsigned(RdRegNo2)));
        END IF;
    END PROCESS;

    PROCESS (Reset, Clock)
    BEGIN
        IF (Reset = '0') THEN
            Registers <= (1 => x"00000001", OTHERS => x"00000000");
        ELSIF (WrEn = '1') AND (rising_edge(Clock)) AND (unsigned(WrRegNo) /= 0) THEN
            Registers(to_integer(unsigned(WrRegNo))) <= WrData;
        END IF;

    END PROCESS;

END Behavioral;