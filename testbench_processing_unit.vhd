library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TestBench_ALU_and_registers is
end entity;

architecture arch_TestBench_ALU_and_registers of TestBench_ALU_and_registers is
    signal RESET : std_logic;
    signal WE, CLK : std_logic := '0';
    signal OP : std_logic_vector(1 downto 0);
    signal RW, RA, RB : std_logic_vector(3 downto 0);
    signal busW : std_logic_vector(31 downto 0);
    constant CLOCK_PERIOD : time := 10 ns;
begin
    -- Instantiate the DUT
    DUT: entity work.Processing_Unit
    port map (
        WE => WE,
        RESET => RESET,
        CLK => CLK,
        OP => OP,
        RW => RW,
        RA => RA,
        RB => RB,
        busW => busW
    );

    -- Clock generator process
    clk_gen: process
    begin
        while true loop
            CLK <= '0';
            wait for CLOCK_PERIOD / 2;
            CLK <= '1';
            wait for CLOCK_PERIOD / 2;
        end loop;
    end process;

    -- Reset process
    reset_proc: process
    begin
        RESET <= '1';
        wait for 100 ns;
        RESET <= '0';
        wait;
    end process;

    -- Testcase 1 : Y=A
    tc1: process
    begin
        -- Set input values
        WE <= '1'; -- write enable
        OP <= "11"; -- Y = A
        RW <= "0001"; 
        RA <= "1111";
        RB <= "0000";
        wait for 10 ns;
        WE <= '0';

        -- Check output value
        wait for 1 ns;
        assert busW = X"0000000F" report "Testcase 1 failed" severity error;

        -- Wait a few cycles before starting the next testcase
        wait for 10 ns;
    end process;

    -- Testcase 2 : Y=A+B
    tc2: process
    begin
        -- Set input values
        WE <= '1';
        OP <= "00";
        RW <= "0001";
        RA <= "0001";
        RB <= "1111";
        wait for 15 ns;
        WE <= '0';

        -- Check output value
        wait for 1 ns;
        assert busW = X"0000F0000" report "Testcase 2 failed" severity error;

        -- Wait a few cycles before starting the next testcase
        wait for 10 ns;

    tc3: process
    begin
        -- Set input values
        
        WE <= '1';
        OP <= "00";
        RW <= "0001";
        RA <= "0001";
        RB <= "1111";
        wait for 15 ns;
        WE <= '0';

        -- Check output value
        wait for 1 ns;
        assert busW = X"0000F0000" report "Testcase 2 failed" severity error;

    end process;
    end architecture;