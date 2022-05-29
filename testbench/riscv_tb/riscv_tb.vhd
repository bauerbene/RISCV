LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY riscv_tb IS
END riscv_tb;

ARCHITECTURE testbench OF riscv_tb IS
    SIGNAL Clock : STD_LOGIC;
    SIGNAL Reset : STD_LOGIC;

BEGIN
    DUT : ENTITY work.Processor
        PORT MAP(
            Clock => Clock,
            Reset => Reset
        );

    PROCESS
    BEGIN
        Clock <= '1';
        WAIT FOR 5 ns;
        Clock <= '0';
        WAIT FOR 5 ns;
    END PROCESS;

    PROCESS
    BEGIN
        Reset <= '0';
        WAIT FOR 10 ns;
        Reset <= '1';
        WAIT;
    END PROCESS;
END testbench;