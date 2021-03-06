LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY imem_age_in_months IS PORT (
    address : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    Clock   : IN STD_LOGIC;
    q       : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END imem_age_in_months;
ARCHITECTURE SYN OF imem_age_in_months IS
    TYPE TMem IS ARRAY(0 TO 11) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Mem : TMem := (
        x"00C00113",
        x"00B00593",
        x"40B10133",
        x"7E500213",
        x"7CC00513",
        x"40A20333",
        x"00131393",
        x"00231313",
        x"00730333",
        x"00131313",
        x"00530313",
        x"00610133"
    );
BEGIN
    PROCESS (Clock)
    BEGIN
        IF RISING_EDGE(Clock) THEN
            q <= Mem(TO_INTEGER(UNSIGNED(address)));
        END IF;
    END PROCESS;
END;