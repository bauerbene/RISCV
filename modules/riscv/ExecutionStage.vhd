---------------------------
-- TODO add documentation
---------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ExecutionStage IS
    PORT (
        Clock       : IN STD_LOGIC;
        Reset       : IN STD_LOGIC;
        FunctI      : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        SrcData1I   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        SrcData2I   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DestWrEnI   : IN STD_LOGIC;
        DestRegNoI  : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        AuxI        : IN STD_LOGIC;
        PCNextI     : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        JumpI       : IN STD_LOGIC;
        JumpRelI    : IN STD_LOGIC;
        JumpTargetI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        MemAccessI  : IN STD_LOGIC;
        MemWrEnI    : IN STD_LOGIC;
        ClearI      : IN STD_LOGIC;
        ImmI        : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        SelSrc2I    : IN STD_LOGIC;
        Stall       : IN STD_LOGIC;

        FunctO      : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        SrcData1O   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        SrcData2O   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        DestWrEnO   : OUT STD_LOGIC;
        DestRegNoO  : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        AuxO        : OUT STD_LOGIC;
        PCNextO     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        JumpO       : OUT STD_LOGIC;
        JumpRelO    : OUT STD_LOGIC;
        JumpTargetO : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        MemAccessO  : OUT STD_LOGIC;
        MemWrEnO    : OUT STD_LOGIC;
        ClearO      : OUT STD_LOGIC;
        ImmO        : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        SelSrc2O    : OUT STD_LOGIC
    );
END ExecutionStage;

ARCHITECTURE Behavioral OF ExecutionStage IS
BEGIN
    PROCESS (Clock, Reset)
    BEGIN
        FunctO <= FunctI;
        SrcData1O <= SrcData1I;
        SrcData2O <= SrcData2I;
        DestWrEnO <= DestWrEnI;
        DestRegNoO <= DestRegNoI;
        AuxO <= AuxI;
        PCNextO <= PCNextI;
        JumpO <= JumpI;
        JumpRelO <= JumpRelI;
        JumpTargetO <= JumpTargetI;
        MemAccessO <= MemAccessI;
        MemWrEnO <= MemWrEnI;
        ImmO <= ImmI;
        SelSrc2O <= SelSrc2I;
    END PROCESS;
END Behavioral;