----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/25/2022 04:02:17 PM
-- Design Name: 
-- Module Name: MUX - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY MUX IS
    PORT (
        In1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        In2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        O   : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Sel : IN STD_LOGIC);
END MUX;

ARCHITECTURE Behavioral OF MUX IS

BEGIN

    PROCESS (In1, In2, Sel)
    BEGIN
        IF Sel = '1' THEN
            O <= In2;
        ELSE
            O <= In1;
        END IF;

    END PROCESS;

END Behavioral;