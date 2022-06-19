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
        Inst       : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        PC         : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        InterlockI : IN STD_LOGIC;
        Clear      : IN STD_LOGIC;

        -- out
        Funct      : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        SrcRegNo1  : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
        SrcRegNo2  : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
        DestWrEn   : OUT STD_LOGIC;
        DestRegNo  : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
        Aux        : OUT STD_LOGIC;
        PCNext     : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Jump       : OUT STD_LOGIC;
        JumpRel    : OUT STD_LOGIC;
        JumpTarget : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        MemAccess  : OUT STD_LOGIC;
        MemWrEn    : OUT STD_LOGIC;
        InterlockO : OUT STD_LOGIC;
        Imm        : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        SelSrc2    : OUT STD_LOGIC
    );
END Decode;

ARCHITECTURE Behavioral OF Decode IS

BEGIN

    PROCESS (Inst, Clear, PC, InterlockI)
    BEGIN

        CASE Inst(6 DOWNTO 0) IS
            WHEN opcode_OP =>
                Funct <= Inst(14 DOWNTO 12);
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                SrcRegNo2 <= Inst(24 DOWNTO 20);
                DestWrEn <= '1';
                DestRegNo <= Inst(11 DOWNTO 7);
                SelSrc2 <= Inst(5);
                Jump <= '0';
                JumpRel <= '0';
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
            WHEN opcode_OP_IMM =>
                Funct <= Inst(14 DOWNTO 12);
                DestWrEn <= '1';
                Imm <= STD_LOGIC_VECTOR(resize(signed(Inst(31 DOWNTO 20)), 32));
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                SrcRegNo2 <= Inst(24 DOWNTO 20);
                DestRegNo <= Inst(11 DOWNTO 7);
                SelSrc2 <= Inst(5);
                Jump <= '0';
                JumpRel <= '0';
                IF Inst(14 DOWNTO 12) = funct_ADD THEN
                    Aux <= '0';
                ELSE
                    Aux <= Inst(30);
                END IF;
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
            WHEN opcode_LUI =>
                Funct <= funct_ADD;
                DestWrEn <= '1';
                SrcRegNo1 <= x0;
                DestRegNo <= Inst(11 DOWNTO 7);
                SelSrc2 <= '0';
                Imm <= STD_LOGIC_VECTOR(Inst(31 DOWNTO 12) & x"000");
                Aux <= '0';
                Jump <= '0';
                JumpRel <= '0';
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
            WHEN opcode_AUIPC =>
                Funct <= funct_ADD;
                DestWrEn <= '1';
                SrcRegNo1 <= x0;
                DestRegNo <= Inst(11 DOWNTO 7);
                SelSrc2 <= '0';
                Imm <= STD_LOGIC_VECTOR(signed(Inst(31 DOWNTO 12) & x"000") + signed(PC));
                Aux <= '0';
                Jump <= '0';
                JumpRel <= '0';
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
            WHEN opcode_JAL =>
                Jump <= '1';
                JumpTarget <= STD_LOGIC_VECTOR(signed(PC) + signed(Inst(31) & Inst(19 DOWNTO 12) & Inst(20) & Inst(30 DOWNTO 21) & "0"));
                PCNext <= STD_LOGIC_VECTOR(signed(PC) + 4);
                DestWrEn <= '1';
                DestRegNo <= Inst(11 DOWNTO 7);
                Funct <= (OTHERS => '-');
                SrcRegNo1 <= (OTHERS => '-');
                SrcRegNo2 <= (OTHERS => '-');
                Aux <= '-';
                SelSrc2 <= '-';
                Imm <= (OTHERS => '-');
                JumpRel <= '1';
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
            WHEN opcode_JALR =>
                Jump <= '1';
                Imm <= STD_LOGIC_VECTOR(resize(signed(Inst(31 DOWNTO 20)), 32));
                SelSrc2 <= '0';
                Funct <= funct_ADD;
                Aux <= '0';
                PCNext <= STD_LOGIC_VECTOR(signed(PC) + 4);
                DestWrEn <= '1';
                DestRegNo <= Inst(11 DOWNTO 7);
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                SrcRegNo2 <= (OTHERS => '-');
                JumpRel <= '0';
                JumpTarget <= (OTHERS => '-');
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
            WHEN opcode_BRANCH =>
                Jump <= '0';
                JumpRel <= '1';
                JumpTarget <= STD_LOGIC_VECTOR(signed(PC) + signed(Inst(31) & Inst(7) & Inst(30 DOWNTO 25) & Inst(11 DOWNTO 8) & "0"));
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                SrcRegNo2 <= Inst(24 DOWNTO 20);
                Funct <= Inst(14 DOWNTO 12);
                DestWrEn <= '0';
                DestRegNo <= (OTHERS => '-');
                Aux <= '-';
                SelSrc2 <= '1';
                PCNext <= (OTHERS => '-');
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
            WHEN opcode_LOAD =>
                MemAccess <= '1';
                MemWrEn <= '0';
                DestRegNo <= Inst(11 DOWNTO 7);
                Jump <= '0';
                JumpRel <= '0';
                JumpTarget <= (OTHERS => '-');
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                SrcRegNo2 <= (OTHERS => '-');
                Funct <= Inst(14 DOWNTO 12);
                Imm <= STD_LOGIC_VECTOR(resize(signed(Inst(31 DOWNTO 20)), 32));
                SelSrc2 <= '0';
                PCNext <= (OTHERS => '-');
                Aux <= '-';
                InterlockO <= '1';
            WHEN opcode_STORE =>
                MemAccess <= '1';
                MemWrEn <= '1';
                DestRegNo <= (OTHERS => '-');
                Jump <= '0';
                JumpRel <= '0';
                JumpTarget <= (OTHERS => '-');
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                SrcRegNo2 <= Inst(24 DOWNTO 20);
                Funct <= Inst(14 DOWNTO 12);
                Imm <= STD_LOGIC_VECTOR(resize(signed(Inst(31 DOWNTO 25) & Inst(11 DOWNTO 7)), 32));
                SelSrc2 <= '0';
                PCNext <= (OTHERS => '-');
                Aux <= '-';
                InterlockO <= '0';
            WHEN OTHERS =>
                Funct <= (OTHERS => '-');
                SrcRegNo1 <= (OTHERS => '-');
                SrcRegNo2 <= (OTHERS => '-');
                DestRegNo <= (OTHERS => '-');
                DestWrEn <= '-';
                Aux <= '-';
                Imm <= (OTHERS => '-');
                SelSrc2 <= '-';
                Jump <= '-';
                JumpTarget <= (OTHERS => '-');
                JumpRel <= '-';
                MemAccess <= '-';
                MemWrEn <= '-';
                InterlockO <= '-';
        END CASE;

        IF Clear = '1' OR InterlockI = '1' THEN
            DestWrEn <= '0';
            Jump <= '0';
            JumpRel <= '0';
            MemAccess <= '0';
            MemWrEn <= '0';
            InterlockO <= '0';
        END IF;
    END PROCESS;

END Behavioral;