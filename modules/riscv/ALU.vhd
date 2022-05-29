----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2022 04:45:48 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

ENTITY ALU IS
    PORT (
        A     : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        B     : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Funct : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Aux   : IN STD_LOGIC;
        -- PCNext      : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        -- JumpI       : IN STD_LOGIC;
        -- JumpRel     : IN STD_LOGIC;
        -- JumpTargetI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        -- MemAccessI  : IN STD_LOGIC;
        -- SrcData2    : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DestRegNoI : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        DestWrEnI  : IN STD_LOGIC;
        -- Clear       : IN STD_LOGIC;
        -- Stall       : IN STD_LOGIC;
        X : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        -- JumpO       : OUT STD_LOGIC;
        -- JumpTargetO : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        DestRegNoO : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        DestWrEnO  : OUT STD_LOGIC
        -- MemAccessO  : OUT STD_LOGIC;
        -- MemWrData   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        -- MemByteEna  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ALU;

ARCHITECTURE Behavioral OF ALU IS

    FUNCTION ADD_SUB_FUNC(A : STD_LOGIC_VECTOR; B : STD_LOGIC_VECTOR; Aux : STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        IF (Aux = '0') THEN
            RETURN STD_LOGIC_VECTOR(unsigned(A) + unsigned(B));
        ELSE
            RETURN STD_LOGIC_VECTOR(unsigned(A) - unsigned(B));
        END IF;
    END;

    FUNCTION SLL_FUNC(A : STD_LOGIC_VECTOR; B : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        RETURN STD_LOGIC_VECTOR(shift_left(unsigned(A), to_integer(unsigned(B(4 DOWNTO 0)))));
    END;

    FUNCTION SLT_FUNC(A : STD_LOGIC_VECTOR; B : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        IF signed(A) < signed(B) THEN
            RETURN x"00000001";
        ELSE
            RETURN x"00000000";
        END IF;
    END;

    FUNCTION SLTU_FUNC(A : STD_LOGIC_VECTOR; B : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        IF unsigned(A) < unsigned(B) THEN
            RETURN x"00000001";
        ELSE
            RETURN x"00000000";
        END IF;
    END;

    FUNCTION SRL_SRA_FUNC(A : STD_LOGIC_VECTOR; B : STD_LOGIC_VECTOR; Aux : STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
    BEGIN
        IF (Aux = '1') THEN
            RETURN STD_LOGIC_VECTOR(shift_right(signed(A), to_integer(unsigned(B))));
        ELSE
            RETURN STD_LOGIC_VECTOR(shift_right(unsigned(A), to_integer(unsigned(B))));
        END IF;
    END;

BEGIN

    PROCESS (Funct, A, B)
    BEGIN
        DestRegNoO <= DestRegNoI;
        DestWrEnO <= DestWrEnI;
        CASE Funct IS
            WHEN funct_ADD => X <= ADD_SUB_FUNC(A, B, Aux);
            WHEN funct_SLL => X <= SLL_FUNC(A, B);
            WHEN funct_SLT => X <= SLT_FUNC(A, B);
            WHEN funct_SLTU => X <= SLTU_FUNC(A, B);
            WHEN funct_XOR => X <= A XOR B;
            WHEN funct_SRL => X <= SRL_SRA_FUNC(A, B, Aux);
            WHEN funct_OR => X <= A OR B;
            WHEN funct_AND => X <= A AND B;
            WHEN OTHERS => NULL;
        END CASE;
    END PROCESS;

END Behavioral;