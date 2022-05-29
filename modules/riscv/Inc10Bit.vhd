----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2022 02:43:12 PM
-- Design Name: 
-- Module Name: Inc10Bit - Behavioral
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

ENTITY Inc10Bit IS
    PORT (
        Clock : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        O     : OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
    );
END Inc10Bit;

ARCHITECTURE Behavioral OF Inc10Bit IS

BEGIN
    PROCESS (Reset, Clock)
        VARIABLE curr_sum : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
    BEGIN
        IF Reset = '0' THEN
            curr_sum := "0000000000";
            O <= curr_sum;
            ELSIF rising_edge(Clock) THEN
            curr_sum := STD_LOGIC_VECTOR(unsigned(curr_sum) + to_unsigned(1, 10));
            O <= curr_sum;
        END IF;
    END PROCESS;

END Behavioral;