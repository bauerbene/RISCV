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
    -- Instruction Address: Programm Counter -> Instruction Memory
    SIGNAL IAddr_PC_IMem : STD_LOGIC_VECTOR(9 DOWNTO 0);

    -- Instruction Word: Instruction Memory -> Decode
    SIGNAL Instruction_IMem_DecodeStage : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Instruction_DecodeStage_Decode : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- todo 
    SIGNAL Funct_Decode_ExStage : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL SrcData1_RegisterSet_ExStage : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SrcData2_MUX_ExStage : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL DestWrEn_Decode_ExStage : STD_LOGIC;
    SIGNAL DestRegNo_Decode_ExStage : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL Aux_Decode_ExStage : STD_LOGIC;
    SIGNAL SelSrc2_Decode_ExStage : STD_LOGIC;

    SIGNAL Funct_ExStage_ALU : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL SrcData1_ExStage_ALU : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SrcData2_ExStage_MUX : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL DestWrEn_ExStage_ALU : STD_LOGIC;
    SIGNAL DestRegNo_ExStage_ALU : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL Aux_ExStage_ALU : STD_LOGIC;
    SIGNAL Imm_ExStage_MUX : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SelSrc2_ExStage_MUX : STD_LOGIC;

    SIGNAL Data_ALU_MemStage : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL WrRegNo_ALU_MemStage : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL WrEn_ALU_MemStage : STD_LOGIC;
    SIGNAL WrData_MemStage_RegisterSet : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL WrEn_MemStage_RegisterSet : STD_LOGIC;
    SIGNAL WrRegNo_MemStage_RegisterSet : STD_LOGIC_VECTOR(4 DOWNTO 0);

    -- Src Register 1: Decode -> Register Set
    SIGNAL SrcRegNo1_Decode_RegisterSet : STD_LOGIC_VECTOR(4 DOWNTO 0);
    -- Src Register 2: Decode -> Register Set
    SIGNAL SrcRegNo2_Decode_RegisterSet : STD_LOGIC_VECTOR(4 DOWNTO 0);

    -- Immediate value: Decode -> MUX
    SIGNAL Imm_Decode_ExStage : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- TODO
    SIGNAL Data2_MUX_ALU : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

    -- done
    PC : ENTITY work.Inc10Bit
        PORT MAP(
            -- in port mapping
            Clock => Clock,
            RESET => Reset,

            -- out port mapping
            O => IAddr_PC_IMem
        );

    -- done
    IMEM : ENTITY work.SRA_SRL_Test
        PORT MAP(
            -- in port mapping
            address => IAddr_PC_IMem,
            Clock   => Clock,
            -- out port mapping
            q => Instruction_IMem_DecodeStage
        );

    -- done
    DECODE_STAGE : ENTITY work.DecodeStage
        PORT MAP(
            InstI => Instruction_IMem_DecodeStage,
            InstO => Instruction_DecodeStage_Decode
        );

    -- done
    DECODE : ENTITY work.Decode
        PORT MAP(
            -- in port mapping
            Inst => Instruction_DecodeStage_Decode,

            -- out port mapping
            Funct     => Funct_Decode_ExStage,
            DestWrEn  => DestWrEn_Decode_ExStage,
            DestRegNo => DestRegNo_Decode_ExStage,

            SrcRegNo1 => SrcRegNo1_Decode_RegisterSet,
            SrcRegNo2 => SrcRegNo2_Decode_RegisterSet,

            SelSrc2 => SelSrc2_Decode_ExStage,
            Imm     => Imm_Decode_ExStage,
            Aux     => Aux_Decode_ExStage
        );

    -- done
    EXECUTION_STAGE : ENTITY work.ExecutionStage
        PORT MAP(
            -- in port mappings
            FunctI     => Funct_Decode_ExStage,
            SrcData1I  => SrcData1_RegisterSet_ExStage,
            SrcData2I  => SrcData2_MUX_ExStage,
            DestWrEnI  => DestWrEn_Decode_ExStage,
            DestRegNoI => DestRegNo_Decode_ExStage,
            AuxI       => Aux_Decode_ExStage,
            ImmI       => Imm_Decode_ExStage,
            SelSrc2I   => SelSrc2_Decode_ExStage,

            -- out port mappings
            FunctO     => Funct_ExStage_ALU,
            SrcData1O  => SrcData1_ExStage_ALU,
            SrcData2O  => SrcData2_ExStage_MUX,
            DestWrEnO  => DestWrEn_ExStage_ALU,
            DestRegNoO => DestRegNo_ExStage_ALU,
            AuxO       => Aux_ExStage_ALU,
            ImmO       => Imm_ExStage_MUX,
            SelSrc2O   => SelSrc2_ExStage_MUX
        );
    -- done
    ALU : ENTITY work.ALU
        PORT MAP(
            -- in port mapping
            Funct      => Funct_ExStage_ALU,
            DestWrEnI  => DestWrEn_ExStage_ALU,
            DestRegNoI => DestRegNo_ExStage_ALU,

            A => SrcData1_ExStage_ALU,
            B => Data2_MUX_ALU,

            Aux => Aux_ExStage_ALU,

            -- out port mapping
            X          => Data_ALU_MemStage,
            DestRegNoO => WrRegNo_ALU_MemStage,
            DestWrEnO  => WrEn_ALU_MemStage
        );

    -- done
    MemStage : ENTITY work.MemStage
        PORT MAP(
            DestDataI  => Data_ALU_MemStage,
            DestWrEnI  => WrEn_ALU_MemStage,
            DestRegNoI => WrRegNo_ALU_MemStage,
            DestDataO  => WrData_MemStage_RegisterSet,
            DestWrEnO  => WrEn_MemStage_RegisterSet,
            DestRegNoO => WrRegNo_MemStage_RegisterSet
        );

    -- done
    REGISTER_SET : ENTITY work.RegisterSet
        PORT MAP(
            -- in port mapping
            RdRegNo1 => SrcRegNo1_Decode_RegisterSet,
            RdRegNo2 => SrcRegNo2_Decode_RegisterSet,

            Clock => Clock,
            Reset => Reset,

            WrData  => WrData_MemStage_RegisterSet,
            WrEn    => WrEn_MemStage_RegisterSet,
            WrRegNo => WrRegNo_MemStage_RegisterSet,

            -- out port mapping
            RdData1 => SrcData1_RegisterSet_ExStage,
            RdData2 => SrcData2_MUX_ExStage
        );

    -- done
    MUX : ENTITY work.MUX
        PORT MAP(
            -- in port mapping
            In1 => Imm_ExStage_MUX,
            In2 => SrcData2_ExStage_MUX,
            Sel => SelSrc2_ExStage_MUX,

            -- out port mapping
            O => Data2_MUX_ALU
        );
END Behavioral;