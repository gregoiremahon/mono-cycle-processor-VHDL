library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extension_tb is
end entity;

architecture sim of sign_extension_tb is
    constant N: positive := 16;
    signal E: std_logic_vector(N-1 downto 0);
    signal S: std_logic_vector(31 downto 0);
    
    component sign_extension is
        generic (N: positive := 16);
        port (
            E: in std_logic_vector(N-1 downto 0);
            S: out std_logic_vector(31 downto 0)
        );
    end component sign_extension;

begin
    DUT: sign_extension generic map(N => N) port map(E => E, S => S);
    
    stimulus: process
        variable S_expected: std_logic_vector(31 downto 0);
    begin
        -- Test case 1: Positive number
        E <= "0000000000010101";
        S_expected := "00000000000000000000000000010101";
        wait for 10 ns;
        assert (S = S_expected) report "Test Case 1 failed" severity error;

        -- Test case 2: Negative number
        E <= "1000000000010101";
        S_expected := "11111111111111111000000000010101";
        wait for 10 ns;
        assert (S = S_expected) report "Test Case 2 failed" severity error;

        -- Test case 3: Zero
        E <= "0000000000000000";
        S_expected := "00000000000000000000000000000000";
        wait for 10 ns;
        assert (S = S_expected) report "Test Case 3 failed" severity error;

        -- Test case 4: Maximum positive value
        E <= "0111111111111111";
        S_expected := "00000000000000000111111111111111";
        wait for 10 ns;
        assert (S = S_expected) report "Test Case 4 failed" severity error;

        -- Test case 5: Minimum negative value
        E <= "1000000000000000";
        S_expected := "11111111111111111000000000000000";
        wait for 10 ns;
        assert (S = S_expected) report "Test Case 5 failed" severity error;

        assert false report "End of testbench" severity note;
    end process;
    
end architecture sim;
