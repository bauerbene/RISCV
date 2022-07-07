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
        Set7SegI    : IN STD_LOGIC;
        AESEncryptI : IN STD_LOGIC;
        AESDecryptI : IN STD_LOGIC;

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
        SelSrc2O    : OUT STD_LOGIC;
        Set7SegO    : OUT STD_LOGIC;
        AESEncryptO : OUT STD_LOGIC;
        AESDecryptO : OUT STD_LOGIC
    );
END ExecutionStage;

ARCHITECTURE Behavioral OF ExecutionStage IS
BEGIN
    PROCESS (Reset, Clock)
    BEGIN
        IF Reset = '0' THEN
            FunctO <= "000";
            SrcData1O <= x"00000000";
            SrcData2O <= x"00000000";
            DestWrEnO <= '0';
            DestRegNoO <= "00000";
            AuxO <= '0';
            PCNextO <= x"00000000";
            JumpO <= '0';
            JumpRelO <= '0';
            JumpTargetO <= x"00000000";
            MemAccessO <= '0';
            MemWrEnO <= '0';
            ImmO <= x"00000000";
            SelSrc2O <= '0';
            ClearO <= '0';
            Set7SegO <= '0';
            AESEncryptO <= '0';
            AESDecryptO <= '0';
        ELSIF rising_edge(Clock) THEN
            IF Stall = '0' THEN
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
                ClearO <= ClearI;
                Set7SegO <= Set7SegI;
                AESEncryptO <= AESEncryptI;
                AESDecryptO <= AESDecryptI;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;