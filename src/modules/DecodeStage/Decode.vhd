LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
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
        SelSrc2    : OUT STD_LOGIC;
        Set7Seg    : OUT STD_LOGIC;
        AESEncrypt : OUT STD_LOGIC;
        AESDecrypt : OUT STD_LOGIC
    );
END Decode;

ARCHITECTURE Behavioral OF Decode IS

BEGIN
    -- das ist ein test kommentar
    PROCESS (Inst, Clear, PC, InterlockI)
    BEGIN
        CASE Inst(6 DOWNTO 0) IS
            WHEN opcode_OP =>
                -- S-Type Instruction
                SrcRegNo2 <= Inst(24 DOWNTO 20);
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                Funct <= Inst(14 DOWNTO 12);
                DestRegNo <= Inst(11 DOWNTO 7);
                SelSrc2 <= Inst(5);

                DestWrEn <= '1';
                AESEncrypt <= '0';
                AESDecrypt <= '0';

                Jump <= '0';
                JumpRel <= '0';
                JumpTarget <= (OTHERS => '-');
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
                Aux <= '-';
                PCNext <= (OTHERS => '-');
                Imm <= (OTHERS => '-');
                Set7Seg <= '0';
            WHEN opcode_OP_IMM =>
                -- I-Type Instruction
                Imm <= STD_LOGIC_VECTOR(resize(signed(Inst(31 DOWNTO 20)), 32));
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                Funct <= Inst(14 DOWNTO 12);
                DestRegNo <= Inst(11 DOWNTO 7);
                SelSrc2 <= Inst(5);

                IF Inst(14 DOWNTO 12) = funct_ADD THEN
                    Aux <= '0';
                ELSE
                    Aux <= Inst(30);
                END IF;

                DestWrEn <= '1';
                AESEncrypt <= '0';
                AESDecrypt <= '0';

                Jump <= '0';
                JumpRel <= '0';
                JumpTarget <= (OTHERS => '-');
                SrcRegNo2 <= (OTHERS => '-');
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
                PCNext <= (OTHERS => '-');
                Set7Seg <= '0';
            WHEN opcode_LUI =>
                -- U-Type Instruction
                Imm <= STD_LOGIC_VECTOR(Inst(31 DOWNTO 12) & x"000");
                DestRegNo <= Inst(11 DOWNTO 7);

                Funct <= funct_ADD;
                SrcRegNo1 <= x0;
                DestWrEn <= '1';
                SelSrc2 <= '0';
                Aux <= '0';
                AESEncrypt <= '0';
                AESDecrypt <= '0';

                Jump <= '0';
                JumpRel <= '0';
                JumpTarget <= (OTHERS => '-');
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
                SrcRegNo2 <= (OTHERS => '-');
                PCNext <= (OTHERS => '-');
                Set7Seg <= '0';
            WHEN opcode_AUIPC =>
                -- U-Type Instruction
                Imm <= STD_LOGIC_VECTOR(signed(Inst(31 DOWNTO 12) & x"000") + signed(PC));
                DestRegNo <= Inst(11 DOWNTO 7);

                Funct <= funct_ADD;
                SrcRegNo1 <= x0;
                DestWrEn <= '1';
                SelSrc2 <= '0';
                Aux <= '0';
                AESEncrypt <= '0';
                AESDecrypt <= '0';

                Jump <= '0';
                JumpRel <= '0';
                JumpTarget <= (OTHERS => '-');
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
                SrcRegNo2 <= (OTHERS => '-');
                PCNext <= (OTHERS => '-');
                Set7Seg <= '0';
            WHEN opcode_JAL =>
                -- J-Type instruction
                JumpTarget <= STD_LOGIC_VECTOR(signed(PC) + signed(Inst(31) & Inst(19 DOWNTO 12) & Inst(20) & Inst(30 DOWNTO 21) & "0"));
                DestRegNo <= Inst(11 DOWNTO 7);

                PCNext <= STD_LOGIC_VECTOR(signed(PC) + 4);
                Jump <= '1';
                JumpRel <= '1';
                DestWrEn <= '1';
                AESEncrypt <= '0';
                AESDecrypt <= '0';

                Funct <= (OTHERS => '-');
                SrcRegNo1 <= (OTHERS => '-');
                SrcRegNo2 <= (OTHERS => '-');
                Aux <= '-';
                SelSrc2 <= '-';
                Imm <= (OTHERS => '-');
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
                Set7Seg <= '0';
            WHEN opcode_JALR =>
                -- I-Type instruction
                Imm <= STD_LOGIC_VECTOR(resize(signed(Inst(31 DOWNTO 20)), 32));
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                DestRegNo <= Inst(11 DOWNTO 7);

                PCNext <= STD_LOGIC_VECTOR(signed(PC) + 4);

                Jump <= '1';
                JumpRel <= '0';
                SelSrc2 <= '0';
                Funct <= funct_ADD;
                Aux <= '0';
                DestWrEn <= '1';
                AESEncrypt <= '0';
                AESDecrypt <= '0';

                SrcRegNo2 <= (OTHERS => '-');
                JumpTarget <= (OTHERS => '-');
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
                Set7Seg <= '0';
            WHEN opcode_BRANCH =>
                -- B-Type Instruction
                JumpTarget <= STD_LOGIC_VECTOR(signed(PC) + signed(Inst(31) & Inst(7) & Inst(30 DOWNTO 25) & Inst(11 DOWNTO 8) & "0"));
                SrcRegNo2 <= Inst(24 DOWNTO 20);
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                Funct <= Inst(14 DOWNTO 12);

                Jump <= '0';
                JumpRel <= '1';
                AESEncrypt <= '0';
                AESDecrypt <= '0';

                DestWrEn <= '0';
                DestRegNo <= (OTHERS => '-');
                Aux <= '-';
                SelSrc2 <= '1';
                PCNext <= (OTHERS => '-');
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
                Imm <= (OTHERS => '-');
                Set7Seg <= '0';
            WHEN opcode_LOAD =>
                -- I-Type Instruction
                Imm <= STD_LOGIC_VECTOR(resize(signed(Inst(31 DOWNTO 20)), 32));
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                Funct <= Inst(14 DOWNTO 12);
                DestRegNo <= Inst(11 DOWNTO 7);

                SelSrc2 <= '0';
                MemAccess <= '1';
                MemWrEn <= '0';
                DestWrEn <= '1';
                InterlockO <= '1';
                AESEncrypt <= '0';
                AESDecrypt <= '0';

                Jump <= '0';
                JumpRel <= '0';
                JumpTarget <= (OTHERS => '-');
                SrcRegNo2 <= (OTHERS => '-');
                PCNext <= (OTHERS => '-');
                Aux <= '-';
                Set7Seg <= '0';
            WHEN opcode_STORE =>
                -- S-Type Instruction
                Imm <= STD_LOGIC_VECTOR(resize(signed(Inst(31 DOWNTO 25) & Inst(11 DOWNTO 7)), 32));
                SrcRegNo2 <= Inst(24 DOWNTO 20);
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                Funct <= Inst(14 DOWNTO 12);

                MemAccess <= '1';
                MemWrEn <= '1';
                AESEncrypt <= '0';
                AESDecrypt <= '0';

                DestRegNo <= (OTHERS => '-');

                DestWrEn <= '0';
                Jump <= '0';
                JumpRel <= '0';
                JumpTarget <= (OTHERS => '-');
                SelSrc2 <= '0';
                PCNext <= (OTHERS => '-');
                Aux <= '-';
                InterlockO <= '0';
                Set7Seg <= '0';
            WHEN opcode_SYSTEM =>
                IF Inst(31 DOWNTO 20) = x"788" AND Inst(14 DOWNTO 12) = "001" AND Inst(11 DOWNTO 7) = "00000" THEN
                    SrcRegNo1 <= Inst(19 DOWNTO 15);
                    Set7Seg <= '1';

                ELSE
                    SrcRegNo1 <= (OTHERS => '-');
                    Set7Seg <= '0';
                END IF;

                DestWrEn <= '0';
                MemWrEn <= '0';
                MemAccess <= '0';
                InterlockO <= '0';
                Jump <= '0';
                JumpRel <= '0';
                AESEncrypt <= '0';
                AESDecrypt <= '0';

                Funct <= (OTHERS => '-');
                SrcRegNo2 <= (OTHERS => '-');
                DestRegNo <= (OTHERS => '-');
                Aux <= '-';
                Imm <= (OTHERS => '-');
                SelSrc2 <= '-';
                JumpTarget <= (OTHERS => '-');
                PCNext <= (OTHERS => '-');

            WHEN opcode_AES =>
                -- I-Type-Instruction
                SrcRegNo1 <= Inst(19 DOWNTO 15);
                DestRegNo <= Inst(11 DOWNTO 7);
                DestWrEn <= '1';

                AESEncrypt <= '1';
                AESDecrypt <= '0';

                SelSrc2 <= '0';
                MemAccess <= '0';
                MemWrEn <= '0';
                InterlockO <= '0';
                Jump <= '0';
                JumpRel <= '0';
                JumpTarget <= (OTHERS => '-');
                SrcRegNo2 <= (OTHERS => '-');
                PCNext <= (OTHERS => '-');
                Aux <= '-';
                Set7Seg <= '0';

            WHEN OTHERS =>
                DestWrEn <= '0';
                MemWrEn <= '0';
                MemAccess <= '0';
                InterlockO <= '0';
                Jump <= '0';
                JumpRel <= '0';
                Set7Seg <= '0';
                AESEncrypt <= '0';
                AESDecrypt <= '0';

                Funct <= (OTHERS => '-');
                SrcRegNo1 <= (OTHERS => '-');
                SrcRegNo2 <= (OTHERS => '-');
                DestRegNo <= (OTHERS => '-');
                Aux <= '-';
                Imm <= (OTHERS => '-');
                SelSrc2 <= '-';
                JumpTarget <= (OTHERS => '-');
                PCNext <= (OTHERS => '-');
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