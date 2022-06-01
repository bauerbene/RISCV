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
    SIGNAL IAddr__PC__IMem : STD_LOGIC_VECTOR(9 DOWNTO 0);

    -- Instruction Word: Instruction Memory -> Decode
    SIGNAL Instruction__IMem__DecodeStage : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Instruction__DecodeStage__Decode : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- todo 
    SIGNAL Funct__Decode__ExStage : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL SrcData1__RegisterSet__ExStage : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SrcData2__MUX__ExStage : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL DestWrEn__Decode__ExStage : STD_LOGIC;
    SIGNAL DestRegNo__Decode__ExStage : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL Aux__Decode__ExStage : STD_LOGIC;
    SIGNAL SelSrc2__Decode__ExStage : STD_LOGIC;

    SIGNAL Funct__ExStage__ALU : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL SrcData1__ExStage__ALU : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SrcData2__ExStage__MUX : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL DestWrEn__ExStage__ALU : STD_LOGIC;
    SIGNAL DestRegNo__ExStage__ALU : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL Aux__ExStage__ALU : STD_LOGIC;
    SIGNAL Imm__ExStage__MUX : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SelSrc2__ExStage__MUX : STD_LOGIC;

    SIGNAL Data__ALU__MemStage_Forward : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL WrRegNo__ALU__MemStage : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL WrEn__ALU_ExStage__MemStage_Forward_ALU : STD_LOGIC;
    SIGNAL WrData__MemStage__RegisterSet_Forward : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL WrEn__MemStage__RegisterSet_Forward : STD_LOGIC;
    SIGNAL WrRegNo__MemStage__RegisterSet_Forward : STD_LOGIC_VECTOR(4 DOWNTO 0);

    -- Src Register 1: Decode -> Register Set
    SIGNAL SrcRegNo1__Decode__RegisterSet_Forward : STD_LOGIC_VECTOR(4 DOWNTO 0);
    -- Src Register 2: Decode -> Register Set
    SIGNAL SrcRegNo2__Decode__RegisterSet_Forward : STD_LOGIC_VECTOR(4 DOWNTO 0);

    -- Immediate value: Decode -> MUX
    SIGNAL Imm__Decode__ExStage : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- TODO
    SIGNAL Data2__MUX__ALU : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- TODO Documentation
    SIGNAL SrcRegNo1__Decode__Forward : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL SrcRegNo2__Decode__Forward : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL SrcData1__RegisterSet__Forward : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SrcData2__RegisterSet__Forward : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL DestWrEn__ALU_ExStage__Forward : STD_LOGIC;
    SIGNAL DestRegNo__ALU_ExStage__Forward : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL DestData__ALU__Forward : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL DestWrEn__MemStage__Forward : STD_LOGIC;
    SIGNAL DestRegNo__MemStage__Forward : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL DestData__MemStage__Forward : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL FwdData1__Forward__ExStage : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL FwdData2__Forward__ExStage : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL WrRegNo__ALU_ExStage__MemStage_Forward_ALU : STD_LOGIC_VECTOR(4 DOWNTO 0);

BEGIN

    PC : ENTITY work.Inc10Bit
        PORT MAP(
            -- in port mapping
            Clock => Clock,
            RESET => Reset,

            -- out port mapping
            O => IAddr__PC__IMem
        );

    IMEM : ENTITY work.test02fwd
        PORT MAP(
            -- in port mapping
            address => IAddr__PC__IMem,
            Clock   => Clock,
            -- out port mapping
            q => Instruction__IMem__DecodeStage
        );

    DECODE_STAGE : ENTITY work.DecodeStage
        PORT MAP(
            Clock => Clock,
            Reset => Reset,
            InstI => Instruction__IMem__DecodeStage,
            InstO => Instruction__DecodeStage__Decode
        );

    DECODE : ENTITY work.Decode
        PORT MAP(
            -- in port mapping
            Inst => Instruction__DecodeStage__Decode,

            -- out port mapping
            Funct     => Funct__Decode__ExStage,
            DestWrEn  => DestWrEn__Decode__ExStage,
            DestRegNo => DestRegNo__Decode__ExStage,

            SrcRegNo1 => SrcRegNo1__Decode__RegisterSet_Forward,
            SrcRegNo2 => SrcRegNo2__Decode__RegisterSet_Forward,

            SelSrc2 => SelSrc2__Decode__ExStage,
            Imm     => Imm__Decode__ExStage,
            Aux     => Aux__Decode__ExStage
        );

    EXECUTION_STAGE : ENTITY work.ExecutionStage
        PORT MAP(
            -- in port mappings
            Clock      => Clock,
            Reset      => Reset,
            FunctI     => Funct__Decode__ExStage,
            SrcData1I  => FwdData1__Forward__ExStage,
            SrcData2I  => FwdData2__Forward__ExStage,
            DestWrEnI  => SrcData2__MUX__ExStage,
            DestRegNoI => SrcData2__MUX__ExStage,
            AuxI       => Aux__Decode__ExStage,
            ImmI       => Imm__Decode__ExStage,
            SelSrc2I   => SelSrc2__Decode__ExStage,

            -- out port mappings
            FunctO     => Funct__ExStage__ALU,
            SrcData1O  => SrcData1__ExStage__ALU,
            SrcData2O  => SrcData2__ExStage__MUX,
            DestWrEnO  => WrEn__ALU_ExStage__MemStage_Forward_ALU,
            DestRegNoO => WrRegNo__ALU_ExStage__MemStage_Forward_ALU,
            AuxO       => Aux__ExStage__ALU,
            ImmO       => Imm__ExStage__MUX,
            SelSrc2O   => SelSrc2__ExStage__MUX
        );

    ALU : ENTITY work.ALU
        PORT MAP(
            -- in port mapping
            Funct      => Funct__ExStage__ALU,
            DestWrEnI  => WrEn__ALU_ExStage__MemStage_Forward_ALU,
            DestRegNoI => WrRegNo__ALU_ExStage__MemStage_Forward_ALU,

            A => SrcData1__ExStage__ALU,
            B => Data2__MUX__ALU,

            Aux => Aux__ExStage__ALU,

            -- out port mapping
            X          => Data__ALU__MemStage_Forward,
            DestRegNoO => WrRegNo__ALU_ExStage__MemStage_Forward_ALU,
            DestWrEnO  => WrEn__ALU_ExStage__MemStage_Forward_ALU
        );

    MemStage : ENTITY work.MemStage
        PORT MAP(
            Clock      => Clock,
            Reset      => Reset,
            DestDataI  => Data__ALU__MemStage_Forward,
            DestWrEnI  => WrEn__ALU_ExStage__MemStage_Forward_ALU,
            DestRegNoI => WrRegNo__ALU_ExStage__MemStage_Forward_ALU,
            DestDataO  => WrData__MemStage__RegisterSet_Forward,
            DestWrEnO  => WrEn__MemStage__RegisterSet_Forward,
            DestRegNoO => WrRegNo__MemStage__RegisterSet_Forward
        );

    REGISTER_SET : ENTITY work.RegisterSet
        PORT MAP(
            -- in port mapping
            RdRegNo1 => SrcRegNo1__Decode__RegisterSet_Forward,
            RdRegNo2 => SrcRegNo2__Decode__RegisterSet_Forward,

            Clock => Clock,
            Reset => Reset,

            WrData  => WrData__MemStage__RegisterSet_Forward,
            WrEn    => WrEn__MemStage__RegisterSet_Forward,
            WrRegNo => WrRegNo__MemStage__RegisterSet_Forward,

            -- out port mapping
            RdData1 => SrcData1__RegisterSet__Forward,
            RdData2 => SrcData2__RegisterSet__Forward
        );

    MUX : ENTITY work.MUX
        PORT MAP(
            -- in port mapping
            In1 => Imm__ExStage__MUX,
            In2 => SrcData2__ExStage__MUX,
            Sel => Imm__ExStage__MUX,

            -- out port mapping
            O => Data2__MUX__ALU
        );

    Forward : ENTITY work.Forward
        PORT MAP(
            -- in port mapping
            SrcRegNo1     => SrcRegNo1__Decode__RegisterSet_Forward,
            SrcRegNo2     => SrcRegNo2__Decode__RegisterSet_Forward,
            SrcData1      => SrcData1__RegisterSet__Forward,
            SrcData2      => SrcData2__RegisterSet__Forward,
            DestWrEn_EX   => WrEn__ALU_ExStage__MemStage_Forward_ALU,
            DestRegNo_EX  => WrRegNo__ALU_ExStage__MemStage_Forward_ALU,
            DestData_EX   => Data__ALU__MemStage_Forward,
            DestWrEn_MEM  => WrEn__MemStage__RegisterSet_Forward,
            DestRegNo_MEM => WrRegNo__MemStage__RegisterSet_Forward,
            DestData_MEM  => WrData__MemStage__RegisterSet_Forward,

            -- out port mapping
            FwdData1 => FwdData1__Forward__ExStage,
            FwdData2 => FwdData2__Forward__ExStage
        );
END Behavioral;