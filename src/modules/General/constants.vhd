-- Include this package in your modules with: USE work.constants.all;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE constants IS

    CONSTANT opcode_LOAD : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000011";
    CONSTANT opcode_MISC_MEM : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0001111";
    CONSTANT opcode_regimm : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010011";
    CONSTANT opcode_OP_IMM : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010011";
    CONSTANT opcode_AUIPC : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010111";
    CONSTANT opcode_STORE : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0100011";
    CONSTANT opcode_regreg : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110011";
    CONSTANT opcode_OP : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110011";
    CONSTANT opcode_LUI : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110111";
    CONSTANT opcode_BRANCH : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1100011";
    CONSTANT opcode_JALR : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1100111";
    CONSTANT opcode_JAL : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1101111";
    CONSTANT opcode_SYSTEM : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1110011";

    CONSTANT opcode_CUSTOM : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1100001";

    CONSTANT funct_BEQ : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    CONSTANT funct_BNE : STD_LOGIC_VECTOR(2 DOWNTO 0) := "001";
    CONSTANT funct_BLT : STD_LOGIC_VECTOR(2 DOWNTO 0) := "100";
    CONSTANT funct_BGE : STD_LOGIC_VECTOR(2 DOWNTO 0) := "101";
    CONSTANT funct_BLTU : STD_LOGIC_VECTOR(2 DOWNTO 0) := "110";
    CONSTANT funct_BGEU : STD_LOGIC_VECTOR(2 DOWNTO 0) := "111";

    CONSTANT funct_ADD : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    CONSTANT funct_SLL : STD_LOGIC_VECTOR(2 DOWNTO 0) := "001";
    CONSTANT funct_SLT : STD_LOGIC_VECTOR(2 DOWNTO 0) := "010";
    CONSTANT funct_SLTU : STD_LOGIC_VECTOR(2 DOWNTO 0) := "011";
    CONSTANT funct_XOR : STD_LOGIC_VECTOR(2 DOWNTO 0) := "100";
    CONSTANT funct_SRL : STD_LOGIC_VECTOR(2 DOWNTO 0) := "101";
    CONSTANT funct_OR : STD_LOGIC_VECTOR(2 DOWNTO 0) := "110";
    CONSTANT funct_AND : STD_LOGIC_VECTOR(2 DOWNTO 0) := "111";
    CONSTANT funct_AESEncrypt : STD_LOGIC_VECTOR(2 DOWNTO 0) := "001";
    CONSTANT funct_AESDecrpyt : STD_LOGIC_VECTOR(2 DOWNTO 0) := "010";

    CONSTANT funct_SB : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    CONSTANT funct_SH : STD_LOGIC_VECTOR(2 DOWNTO 0) := "001";
    CONSTANT funct_SW : STD_LOGIC_VECTOR(2 DOWNTO 0) := "010";

    CONSTANT funct_LB : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    CONSTANT funct_LH : STD_LOGIC_VECTOR(2 DOWNTO 0) := "001";
    CONSTANT funct_LW : STD_LOGIC_VECTOR(2 DOWNTO 0) := "010";
    CONSTANT funct_LBU : STD_LOGIC_VECTOR(2 DOWNTO 0) := "100";
    CONSTANT funct_LHU : STD_LOGIC_VECTOR(2 DOWNTO 0) := "101";

    CONSTANT x0 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
    CONSTANT x1 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00001";
    CONSTANT x2 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00010";
    CONSTANT x3 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00011";
    CONSTANT x4 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00100";
    CONSTANT x5 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00101";
    CONSTANT x6 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00110";
    CONSTANT x7 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00111";
    CONSTANT x8 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01000";
    CONSTANT x9 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01001";
    CONSTANT x10 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01010";
    CONSTANT x11 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01011";
    CONSTANT x12 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01100";
    CONSTANT x13 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01101";
    CONSTANT x14 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01110";
    CONSTANT x15 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01111";
    CONSTANT x16 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10000";
    CONSTANT x17 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10001";
    CONSTANT x18 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10010";
    CONSTANT x19 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10011";
    CONSTANT x20 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10100";
    CONSTANT x21 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10101";
    CONSTANT x22 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10110";
    CONSTANT x23 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10111";
    CONSTANT x24 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11000";
    CONSTANT x25 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11001";
    CONSTANT x26 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11010";
    CONSTANT x27 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11011";
    CONSTANT x28 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11100";
    CONSTANT x29 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11101";
    CONSTANT x30 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11110";
    CONSTANT x31 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11111";

    CONSTANT ROM_DEPTH : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00001000";

END constants;