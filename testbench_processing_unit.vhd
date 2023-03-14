library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TestBench_Processing_Unit is 
end entity;

architecture arch_TestBench_Processing_Unit of TestBench_Processing_Unit is

    signal WE, RESET, CLK : std_logic;
    signal OP : std_logic_vector(1 downto 0);
    signal RW, RA, RB : std_logic_vector(3 downto 0);
    signal busW : std_logic_vector(31 downto 0);

    constant CLOCK_PERIOD : time := 10 ns;

begin
        -- Testcase 1 : R(1) = R(15)
        -- Testcase 2 : R(1) = R(1) + R(15)
        -- Testcase 3 : R(2) = R(1) + R(15)
        -- Testcase 4 : R(3) = R(1) + R(15)
        -- Testcase 5 : R(5) = R(7) - R(15)

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
        wait for 100 ns;
        RESET <= '1';
        wait for 100 ns;
        RESET <= '0';
        wait;
    end process;

    -- Testcase 1 : R(1) = R(15)
    tc1: process
    begin
        -- Set input values
        WE <= '1';
        OP <= "00";
        RW <= "00" & "0001"; -- R(1)
        RA <= "00" & "1111"; -- R(15)
        RB <= (others => '0');
        wait for CLOCK_PERIOD;

        -- Check output value
        assert busW = std_logic_vector(unsigned(RB)) report "Testcase 1 failed" severity error;

        -- Wait a few cycles before starting the next testcase
        wait for 10 ns;
        WE <= '0';
        wait for 10 ns;
    end process;

    -- Testcase 2 : R(1) = R(1) + R(15)
    tc2: process
    begin
        -- Set input values
        WE <= '1';
        OP <= "01";
        RW <= "00" & "0001"; -- R(1)
        RA <= "00" & "0001"; -- R(1)
        RB <= "00" & "1111"; -- R(15)
        wait for CLOCK_PERIOD;

        -- Check output value
        assert busW = std_logic_vector(unsigned(RA) + unsigned(RB)) report "Testcase 2 failed" severity error;

        -- Wait a few cycles before starting the next testcase
        wait for 10 ns;
        WE <= '0';
        wait for 10 ns;
    end process;

    -- Testcase 3 : R(2) = R(1) + R(15)
    RA <= "0001";
    RB <= "1111";
    RW <= "0010";
    OP <= "01";
    WE <= '1';
    RESET <= '0';
    CLK <= '0';
    wait for 10 ns;
    assert busW = "00000000_00000000_00000000_00000000" report "Testcase 3 failed!" severity error;

    CLK <= '1';
    wait for 10 ns;
    assert busW = "00000000_00000000_00000000_00010001" report "Testcase 3 failed!" severity error;

    -- Testcase 4 : R(3) = R(1) + R(15)
    RA <= "0001";
    RB <= "1111";
    RW <= "0011";
    OP <= "01";
    WE <= '1';
    RESET <= '0';
    CLK <= '0';
    wait for 10 ns;
    assert busW = "00000000_00000000_00000000_00000000" report "Testcase 4 failed!" severity error;

    CLK <= '1';
    wait for 10 ns;
    assert busW = "00000000_00000000_00000000_00010001" report "Testcase 4 failed!" severity error;

    -- Testcase 5 : R(5) = R(7) - R(15)
    RA <= "0111";
    RB <= "1111";
    RW <= "0101";
    OP <= "10";
    WE <= '1';
    RESET <= '0';
    CLK <= '0';
    wait for 10 ns;
    assert busW = "00000000_00000000_00000000_00000000" report "Testcase 5 failed!" severity error;

    CLK <= '1';
    wait for 10 ns;
    assert busW = "11111111_11111111_11111111_11111001" report "Testcase 5 failed!" severity error;

    report "All testcases passed!";
    wait;

end architecture arch_TestBench_Processing_Unit;