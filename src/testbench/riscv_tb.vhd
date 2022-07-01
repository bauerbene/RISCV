LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY riscv_tb IS
END riscv_tb;
ARCHITECTURE TB OF riscv_tb IS

    COMPONENT design_riscv IS
        PORT (
            BTNL : IN STD_LOGIC;
            GCLK : IN STD_LOGIC
        );
    END COMPONENT design_riscv;

    SIGNAL BTNL : STD_LOGIC;
    SIGNAL GCLK : STD_LOGIC;
BEGIN

    DUT : COMPONENT design_riscv PORT MAP(
        BTNL => BTNL,
        GCLK => GCLK
    );

    PROCESS
    BEGIN
        GCLK <= '1';
        WAIT FOR 5 ns;
        GCLK <= '0';
        WAIT FOR 5 ns;
    END PROCESS;

    PROCESS
    BEGIN
        BTNL <= '0';
        WAIT FOR 10 ns;
        BTNL <= '1';
        WAIT;
    END PROCESS;
END TB;