library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_multiplexeur is
end entity;

architecture arch_testbench_multiplexeur of testbench_multiplexeur is
    -- constant values
    constant N: positive := 8;
    
    -- signals
    signal A, B : std_logic_vector(N-1 downto 0);
    signal COM : std_logic;
    signal S : std_logic_vector(N-1 downto 0);
begin
    -- instantiate the DUT
    DUT: entity work.multiplexeur
    generic map (
        N => N
    )
    port map (
        A => A,
        B => B,
        COM => COM,
        S => S
    );

    -- test case 1: select input A
    tc1: process
    begin
        -- set input values
        A <= X"01";
        B <= X"FF";
        COM <= '0';
        wait for 10 ns;

        -- check output value
        assert S = X"01" report "Testcase 1 failed" severity error;

        -- wait before starting next testcase
        wait for 10 ns;
    end process;

    -- test case 2: select input B
    tc2: process
    begin
        -- set input values
        A <= X"01";
        B <= X"FF";
        COM <= '1';
        wait for 10 ns;

        -- check output value
        assert S = X"FF" report "Testcase 2 failed" severity error;

        -- wait before starting next testcase
        wait for 10 ns;
    end process;

end architecture;

