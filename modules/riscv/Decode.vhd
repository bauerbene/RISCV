----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2022 03:29:50 PM
-- Design Name: 
-- Module Name: Decode - Behavioral
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

USE work.constants.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

USE work.constants.ALL;

ENTITY Decode IS
    PORT (
        -- in
        Inst : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        -- PC         : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        -- InterlockI : IN STD_LOGIC;
        -- Clear      : IN STD_LOGIC;

        -- out
        Funct     : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        SrcRegNo1 : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
        SrcRegNo2 : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
        DestWrEn  : OUT STD_LOGIC;
        DestRegNo : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
        Aux       : OUT STD_LOGIC;
        -- PCNext     : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        -- Jump       : OUT STD_LOGIC;
        -- JumpRel    : OUT STD_LOGIC;
        -- JumpTarget : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        -- MemAccess  : OUT STD_LOGIC;
        -- MemWrEn    : OUT STD_LOGIC;
        -- InterlockO : OUT STD_LOGIC;
        Imm     : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        SelSrc2 : OUT STD_LOGIC
    );
END Decode;

ARCHITECTURE Behavioral OF Decode IS

BEGIN

    PROCESS (Inst)
    BEGIN

        CASE Inst(6 DOWNTO 0) IS
            WHEN opcode_OP =>
                Funct <= Inst(14 DOWNTO 12);
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                SrcRegNo2 <= Inst(24 DOWNTO 20);
                DestWrEn <= '1';
                DestRegNo <= Inst(11 DOWNTO 7);
                SelSrc2 <= Inst(5);
            WHEN opcode_OP_IMM =>
                Funct <= Inst(14 DOWNTO 12);
                DestWrEn <= '1';
                Imm <= STD_LOGIC_VECTOR(resize(signed(Inst(31 DOWNTO 20)), 32));
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                SrcRegNo2 <= Inst(24 DOWNTO 20);
                DestRegNo <= Inst(11 DOWNTO 7);
                SelSrc2 <= Inst(5);
                IF Inst(14 DOWNTO 12) = funct_ADD THEN
                    Aux <= '0';
                ELSE
                    Aux <= Inst(30);
                END IF;
            WHEN opcode_LUI =>
                Funct <= funct_ADD;
                DestWrEn <= '1';
                SrcRegNo1 <= x0;
                DestRegNo <= Inst(11 DOWNTO 7);
                SelSrc2 <= '0';
                Imm <= STD_LOGIC_VECTOR(Inst(31 DOWNTO 12) & x"000");
                Aux <= '0';
            WHEN OTHERS =>
                Funct <= (OTHERS => '-');
                SrcRegNo1 <= (OTHERS => '-');
                SrcRegNo2 <= (OTHERS => '-');
                DestRegNo <= (OTHERS => '-');
                DestWrEn <= '-';
                Aux <= '-';
                Imm <= (OTHERS => '-');
                SelSrc2 <= '-';
        END CASE;
    END PROCESS;

END Behavioral;