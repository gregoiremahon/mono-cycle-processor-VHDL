library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_processingUnit is
end entity testbench_processingUnit;

architecture default of testbench_processingUnit is
    signal clk, rst: std_logic;
    signal instruction: std_logic_vector(31 downto 0) := (others => '0');
    signal dataOut: std_logic_vector(31 downto 0);

begin
    DUT : entity work.processingUnit
        port map (
            clk => clk,
            rst => rst,
            instruction => instruction,
            dataOut => dataOut
        );

    clk_gen : process
    begin
        clk <= '1';
        wait for 2 ns;
        clk <= '0';
        wait for 2 ns;
    end process;

    test : process
    begin
        -- Initialize
        rst <= '1';
        wait for 4 ns;
        rst <= '0';

        -- Test R(1) = R(15)
        instruction <= x"00158020"; -- add R(1), R(1), R(0)
        wait for 10 ns;
        assert dataOut = x"00000000" report "Error: R(1) is not equal to R(15)" severity error;

        -- Test R(1) = R(1) + R(15)
        instruction <= x"015F8020"; -- add R(1), R(15), R(1)
        wait for 10 ns;
        assert dataOut = x"00000000" report "Error: R(1) is not equal to R(15)" severity error;

        -- Test R(2) = R(1) + R(15)
        instruction <= x"015F8022"; -- add R(2), R(15), R(1)
        wait for 10 ns;
        assert dataOut = x"00000000" report "Error: R(2) is not equal to R(1) + R(15)" severity error;

        -- Test R(3) = R(1) ? R(15)
        instruction <= x"015F8022"; -- add R(2), R(15), R(1)
        wait for 10 ns;
        instruction <= x"011F8023"; -- sub R(3), R(15), R(1)
        wait for 10 ns;
        assert dataOut = x"00000000" report "Error: R(3) is not equal to R(15) - R(1)" severity error;

        -- Test R(5) = R(7) ? R(15)
        instruction <= x"01BF8021"; -- addu R(7), R(15), R(31)
        wait for 10 ns;
        instruction <= x"015F882A"; -- slt R(5), R(7), R(15)
        wait for 10 ns;
        assert dataOut = x"FFFFFFFF" report "Error: R(5) is not equal to R(7) - R(15)" severity error;

        wait;
    end process;

end architecture;

