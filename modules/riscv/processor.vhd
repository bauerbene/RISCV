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

    -- signals in IF
    SIGNAL InstrAddr_IF : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL Instr_IF_ID : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- signals in ID
    SIGNAL Instr_ID : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL Funct_ID_EX : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL DestWrEn_ID_EX : STD_LOGIC;
    SIGNAL DestRegNo_ID_EX : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL SrcRegNo1_ID_General, SrcRegNo2_ID_General : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL SelSrc2_ID_EX : STD_LOGIC;
    SIGNAL Imm_ID_EX : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Aux_ID_EX : STD_LOGIC;

    -- signals in General
    SIGNAL SrcData1_General, SrcData2_General : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SrcData1_General_EX, SrcData2_General_EX : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- signals in EX
    SIGNAL Funct_EX : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL SrcData1_EX, SrcData2_EX : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL DestWrEn_EX_General : STD_LOGIC;
    SIGNAL DestWrRegNo_EX_General : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL Aux_EX : STD_LOGIC;
    SIGNAL Imm_EX : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SelSrc2_EX : STD_LOGIC;
    SIGNAL ImmOrSrcData2_EX : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL DestWrData_EX_Mem_General : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL DestWrRegNo_EX_Mem : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL DestWrEn_EX_Mem : STD_LOGIC;

    -- signal in Mem
    SIGNAL DestWrData_Mem_General : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL DestWrEn_Mem_General : STD_LOGIC;
    SIGNAL DestWrRegNo_Mem_General : STD_LOGIC_VECTOR(4 DOWNTO 0);

BEGIN

    --------------------------------------------------------
    ------------------------ General -----------------------
    --------------------------------------------------------
    REGISTER_SET : ENTITY work.RegisterSet
        PORT MAP(
            -- in port mapping
            RdRegNo1 => SrcRegNo1_ID_General,
            RdRegNo2 => SrcRegNo2_ID_General,

            Clock => Clock,
            Reset => Reset,

            WrData  => DestWrData_Mem_General,
            WrEn    => DestWrEn_Mem_General,
            WrRegNo => DestWrRegNo_Mem_General,

            -- out port mapping
            RdData1 => SrcData1_General, RdData2 => SrcData2_General
        );

    Forward : ENTITY work.Forward
        PORT MAP(
            -- in port mapping
            SrcRegNo1 => SrcRegNo1_ID_General, SrcRegNo2 => SrcRegNo2_ID_General,
            SrcData1 => SrcData1_General, SrcData2 => SrcData2_General,
            DestWrEn_EX   => DestWrEn_EX_General,
            DestRegNo_EX  => DestWrRegNo_EX_General,
            DestData_EX   => DestWrData_EX_Mem_General,
            DestWrEn_MEM  => DestWrEn_Mem_General,
            DestRegNo_MEM => DestWrRegNo_Mem_General,
            DestData_MEM  => DestWrData_Mem_General,

            -- out port mapping
            FwdData1 => SrcData1_General_EX, FwdData2 => SrcData2_General_EX
        );

    --------------------------------------------------------
    -------------------------- IF --------------------------
    --------------------------------------------------------
    PC : ENTITY work.Inc10Bit
        PORT MAP(
            -- in port mapping
            Clock => Clock,
            RESET => Reset,
            -- out port mapping
            O => InstrAddr_IF
        );

    IMEM : ENTITY work.Task31
        PORT MAP(
            -- in port mapping
            Clock   => Clock,
            address => InstrAddr_IF,
            -- out port mapping
            q => Instr_IF_ID
        );

    --------------------------------------------------------
    -------------------------- ID --------------------------
    --------------------------------------------------------

    DECODE_STAGE : ENTITY work.DecodeStage
        PORT MAP(
            Clock => Clock,
            Reset => Reset,
            InstI => Instr_IF_ID,
            InstO => Instr_ID
        );

    DECODE : ENTITY work.Decode
        PORT MAP(
            -- in port mapping
            Inst => Instr_ID,

            -- out port mapping
            Funct     => Funct_ID_EX,
            DestWrEn  => DestWrEn_ID_EX,
            DestRegNo => DestRegNo_ID_EX,
            SrcRegNo1 => SrcRegNo1_ID_General, SrcRegNo2 => SrcRegNo2_ID_General,
            SelSrc2   => SelSrc2_ID_EX,
            Imm       => Imm_ID_EX,
            Aux       => Aux_ID_EX
        );

    --------------------------------------------------------
    -------------------------- EX --------------------------
    --------------------------------------------------------

    EXECUTION_STAGE : ENTITY work.ExecutionStage
        PORT MAP(
            -- in port mappings
            Clock      => Clock,
            Reset      => Reset,
            FunctI     => Funct_ID_EX,
            SrcData1I  => SrcData1_General_EX,
            SrcData2I  => SrcData2_General_EX,
            DestWrEnI  => DestWrEn_ID_EX,
            DestRegNoI => DestRegNo_ID_EX,
            AuxI       => Aux_ID_EX,
            ImmI       => Imm_ID_EX,
            SelSrc2I   => SelSrc2_ID_EX,

            -- out port mappings
            FunctO     => Funct_EX,
            SrcData1O => SrcData1_EX, SrcData2O => SrcData2_EX,
            DestWrEnO  => DestWrEn_EX_General,
            DestRegNoO => DestWrRegNo_EX_General,
            AuxO       => Aux_EX,
            ImmO       => Imm_EX,
            SelSrc2O   => SelSrc2_EX
        );

    MUX : ENTITY work.MUX
        PORT MAP(
            -- in port mapping
            In1 => Imm_EX,
            In2 => SrcData2_EX,
            Sel => SelSrc2_EX,

            -- out port mapping
            O => ImmOrSrcData2_EX
        );

    ALU : ENTITY work.ALU
        PORT MAP(
            -- in port mapping
            Funct      => Funct_EX,
            DestWrEnI  => DestWrEn_EX_General,
            DestRegNoI => DestWrRegNo_EX_General,

            A => SrcData1_EX,
            B => ImmOrSrcData2_EX,

            Aux => Aux_EX,

            -- out port mapping
            X          => DestWrData_EX_Mem_General,
            DestRegNoO => DestWrRegNo_EX_Mem,
            DestWrEnO  => DestWrEn_EX_Mem
        );

    --------------------------------------------------------
    -------------------------- Mem -------------------------
    --------------------------------------------------------

    MemStage : ENTITY work.MemStage
        PORT MAP(
            Clock      => Clock,
            Reset      => Reset,
            DestDataI  => DestWrData_EX_Mem_General,
            DestWrEnI  => DestWrEn_EX_Mem,
            DestRegNoI => DestWrRegNo_EX_Mem,
            DestDataO  => DestWrData_Mem_General,
            DestWrEnO  => DestWrEn_Mem_General,
            DestRegNoO => DestWrRegNo_Mem_General
        );

    --------------------------------------------------------
    -------------------------- WB --------------------------
    --------------------------------------------------------
END Behavioral;