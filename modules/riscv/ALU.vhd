LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.constants.ALL;

ENTITY ALU IS
    PORT (
        A           : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        B           : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Funct       : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Aux         : IN STD_LOGIC;
        PCNext      : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        JumpI       : IN STD_LOGIC;
        JumpRel     : IN STD_LOGIC;
        JumpTargetI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        MemAccessI  : IN STD_LOGIC;
        SrcData2    : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DestRegNoI  : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        DestWrEnI   : IN STD_LOGIC;
        Clear       : IN STD_LOGIC;
        MemWrEn     : IN STD_LOGIC;

        X           : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        JumpO       : OUT STD_LOGIC;
        JumpTargetO : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        DestRegNoO  : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        DestWrEnO   : OUT STD_LOGIC;
        MemAccessO  : OUT STD_LOGIC;
        MemWrData   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        MemByteEna  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        FunctO      : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ALU;

ARCHITECTURE Behavioral OF ALU IS

    -- TODO move this to a general file maybe
    FUNCTION BOOLEAN_TO_STDL(Input : BOOLEAN) RETURN STD_LOGIC IS
    BEGIN
        IF Input THEN
            RETURN '1';
        ELSE
            RETURN '0';
        END IF;
    END;

    FUNCTION ADD_SUB_FUNC(In1 : STD_LOGIC_VECTOR; In2 : STD_LOGIC_VECTOR; sub : STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        IF (sub = '0') THEN
            RETURN STD_LOGIC_VECTOR(unsigned(In1) + unsigned(In2));
        ELSE
            RETURN STD_LOGIC_VECTOR(unsigned(In1) - unsigned(In2));
        END IF;
    END;

    FUNCTION SLL_FUNC(In1 : STD_LOGIC_VECTOR; In2 : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        RETURN STD_LOGIC_VECTOR(shift_left(unsigned(In1), to_integer(unsigned(In2(4 DOWNTO 0)))));
    END;

    FUNCTION SLT_FUNC(In1 : STD_LOGIC_VECTOR; In2 : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        IF signed(In1) < signed(In2) THEN
            RETURN x"00000001";
        ELSE
            RETURN x"00000000";
        END IF;
    END;

    FUNCTION SLTU_FUNC(In1 : STD_LOGIC_VECTOR; In2 : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        IF unsigned(In1) < unsigned(In2) THEN
            RETURN x"00000001";
        ELSE
            RETURN x"00000000";
        END IF;
    END;

    FUNCTION SRL_SRA_FUNC(In1 : STD_LOGIC_VECTOR; In2 : STD_LOGIC_VECTOR; useSigned : STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        IF (useSigned = '0') THEN
            RETURN STD_LOGIC_VECTOR(shift_right(unsigned(In1), to_integer(unsigned(In2(4 DOWNTO 0)))));
        ELSE
            RETURN STD_LOGIC_VECTOR(shift_right(signed(In1), to_integer(unsigned(In2(4 DOWNTO 0)))));
        END IF;
    END;

    FUNCTION MemByteEna_SB(MemAddressLastTwo : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        IF MemAddressLastTwo = "00" THEN
            RETURN "0001";
        ELSIF MemAddressLastTwo = "01" THEN
            RETURN "0010";
        ELSIF MemAddressLastTwo = "10" THEN
            RETURN "0100";
        ELSE
            RETURN "1000";
        END IF;
    END;

    FUNCTION MemByteEna_SH(MemAddressLastTwo : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        IF MemAddressLastTwo = "00" THEN
            RETURN "0011";
        ELSE
            RETURN "1100";
        END IF;
    END;

BEGIN

    PROCESS (Funct, A, B, Aux, JumpI, PCNext, JumpTargetI, DestRegNoI, DestWrEnI, JumpRel, Clear, MemAccessI, SrcData2, MemWrEn)
        VARIABLE Result : STD_LOGIC_VECTOR(31 DOWNTO 0);
        VARIABLE Cond : BOOLEAN;
    BEGIN
        MemAccessO <= MemAccessI;
        MemWrData <= SrcData2;

        CASE Funct IS
            WHEN funct_ADD => Result := ADD_SUB_FUNC(A, B, Aux);
            WHEN funct_SLL => Result := SLL_FUNC(A, B);
            WHEN funct_SLT => Result := SLT_FUNC(A, B);
            WHEN funct_SLTU => Result := SLTU_FUNC(A, B);
            WHEN funct_XOR => Result := A XOR B;
            WHEN funct_SRL => Result := SRL_SRA_FUNC(A, B, Aux);
            WHEN funct_OR => Result := A OR B;
            WHEN funct_AND => Result := A AND B;
            WHEN OTHERS => NULL;
        END CASE;

        CASE Funct IS
            WHEN funct_BEQ => Cond := A = B;
            WHEN funct_BNE => Cond := A /= B;
            WHEN funct_BGE => Cond := signed(A) >= signed(B);
            WHEN funct_BGEU => Cond := unsigned(A) >= unsigned(B);
            WHEN funct_BLT => Cond := signed(A) < signed(B);
            WHEN funct_BLTU => Cond := unsigned(A) < unsigned(B);
            WHEN OTHERS => Cond := false;
        END CASE;

        JumpO <= JumpI;

        -- no branch or conditional branch
        IF JumpI = '0' THEN
            IF JumpRel = '1' THEN -- conditional branch
                JumpO <= BOOLEAN_TO_STDL(Cond);
                JumpTargetO <= JumpTargetI; -- for conditional branches the jumptarget is calculated in decode
            END IF;

            -- no branch
            x <= Result;
        ELSE
            -- unconditional branch
            x <= PCNext;
        END IF;

        IF JumpRel = '0' THEN
            JumpTargetO <= Result;
        ELSE
            JumpTargetO <= JumpTargetI;
        END IF;

        DestRegNoO <= DestRegNoI;
        DestWrEnO <= DestWrEnI;

        IF Clear = '1' THEN
            DestWrEnO <= '0';
            JumpO <= '0';
            MemAccessO <= '0';
            MemByteEna <= "0000";
        END IF;

        FunctO <= Funct;

        IF MemAccessI = '1' AND Clear = '0' THEN
            Result := ADD_SUB_FUNC(A, B, '0');
            X <= Result;
            IF MemWrEn = '1' THEN
                CASE Funct IS
                    WHEN funct_SB =>
                        MemByteEna <= MemByteEna_SB(Result(1 DOWNTO 0));
                        MemWrData <= STD_LOGIC_VECTOR(SrcData2(7 DOWNTO 0) & SrcData2(7 DOWNTO 0) & SrcData2(7 DOWNTO 0) & SrcData2(7 DOWNTO 0));
                    WHEN funct_SH =>
                        MemByteEna <= MemByteEna_SH(Result(1 DOWNTO 0));
                        MemWrData <= STD_LOGIC_VECTOR(SrcData2(15 DOWNTO 0) & SrcData2(15 DOWNTO 0));
                    WHEN funct_SW =>
                        MemByteEna <= "1111";
                        MemWrData <= SrcData2; -- not neccesary
                    WHEN OTHERS => MemByteEna <= "0000";
                END CASE;
            ELSE
                MemByteEna <= "0000";
            END IF;
        ELSE
            MemByteEna <= "0000";
        END IF;
    END PROCESS;

END Behavioral;