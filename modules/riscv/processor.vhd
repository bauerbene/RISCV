LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Processor IS
    PORT (
        Clock : IN STD_LOGIC;
        Reset : IN STD_LOGIC
    );
END Processor;

ARCHITECTURE Behavioral OF Processor IS
    ATTRIBUTE debug : STRING;

    -- Instruction Address: Programm Counter -> Instruction Memory
    SIGNAL IAddr_PC_IMem : STD_LOGIC_VECTOR(9 DOWNTO 0);

    -- Instruction Word: Instruction Memory -> Decode
    SIGNAL Instruction_IMem_Decode : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- 3 Bit Funct code: Decode -> ALU
    SIGNAL Funct_Decode_ALU : STD_LOGIC_VECTOR(2 DOWNTO 0);

    -- DestWrEn: Decode -> ALU
    SIGNAL DestWrEn_Decode_ALU : STD_LOGIC;

    -- Destination Register Number: Decode -> ALU
    SIGNAL DestRegNo_Decode_ALU : STD_LOGIC_VECTOR(4 DOWNTO 0);

    -- Src Register 1: Decode -> Register Set
    SIGNAL SrcRegNo1_Decode_RegisterSet : STD_LOGIC_VECTOR(4 DOWNTO 0);
    -- Src Register 2: Decode -> Register Set
    SIGNAL SrcRegNo2_Decode_RegisterSet : STD_LOGIC_VECTOR(4 DOWNTO 0);

    -- Read Data of register number 1: Register Set -> ALU
    SIGNAL RdData1_RegisterSet_ALU : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- ALU Result Data: ALU -> Register Set
    SIGNAL Data_ALU_RegisterSet : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- Register number to write: ALU -> Register Set
    SIGNAL WrRegNo_ALU_RegisterSet : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL WrEn_ALU_RegisterSet : STD_LOGIC;

    -- Select Immediate: Decode -> MUX
    SIGNAL SelSrc2_Decode_MUX : STD_LOGIC;

    -- Immediate value: Decode -> MUX
    SIGNAL Imm_Decode_MUX : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- Read Data register 2: Register Set -> MUX
    SIGNAL RdData2_RegisterSet_MUX : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- TODO
    SIGNAL AUX_Decode_ALU : STD_LOGIC;

    -- TODO
    SIGNAL Data2_MUX_ALU : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

    PC : ENTITY work.Inc10Bit
        PORT MAP(
            -- in port mapping
            Clock => Clock,
            RESET => Reset,

            -- out port mapping
            O => IAddr_PC_IMem
        );

    IMEM : ENTITY work.Task27
        PORT MAP(
            -- in port mapping
            address => IAddr_PC_IMem,
            Clock   => Clock,
            -- out port mapping
            q => Instruction_IMem_Decode
        );

    DECODE : ENTITY work.Decode
        PORT MAP(
            -- in port mapping
            Inst => Instruction_IMem_Decode,

            -- out port mapping
            Funct     => Funct_Decode_ALU,
            DestWrEn  => DestWrEn_Decode_ALU,
            DestRegNo => DestRegNo_Decode_ALU,

            SrcRegNo1 => SrcRegNo1_Decode_RegisterSet,
            SrcRegNo2 => SrcRegNo2_Decode_RegisterSet,

            SelSrc2 => SelSrc2_Decode_MUX,
            Imm     => Imm_Decode_MUX,
            Aux     => AUX_Decode_ALU
        );

    ALU : ENTITY work.ALU
        PORT MAP(
            -- in port mapping
            Funct      => Funct_Decode_ALU,
            DestWrEnI  => DestWrEn_Decode_ALU,
            DestRegNoI => DestRegNo_Decode_ALU,

            A => RdData1_RegisterSet_ALU,
            B => Data2_MUX_ALU,

            Aux => AUX_Decode_ALU,
            -- out port mapping
            X          => Data_ALU_RegisterSet,
            DestRegNoO => WrRegNo_ALU_RegisterSet,
            DestWrEnO  => WrEn_ALU_RegisterSet
        );

    REGISTER_SET : ENTITY work.RegisterSet
        PORT MAP(
            -- in port mapping
            RdRegNo1 => SrcRegNo1_Decode_RegisterSet,
            RdRegNo2 => SrcRegNo2_Decode_RegisterSet,

            Clock => Clock,
            Reset => Reset,

            WrData  => Data_ALU_RegisterSet,
            WrEn    => WrEn_ALU_RegisterSet,
            WrRegNo => WrRegNo_ALU_RegisterSet,

            -- out port mapping
            RdData1 => RdData1_RegisterSet_ALU,
            RdData2 => RdData2_RegisterSet_MUX
        );

    MUX : ENTITY work.MUX
        PORT MAP(
            -- in port mapping
            In1 => Imm_Decode_MUX,
            In2 => RdData2_RegisterSet_MUX,
            Sel => SelSrc2_Decode_MUX,

            -- out port mapping
            O => Data2_MUX_ALU
        );
END Behavioral;