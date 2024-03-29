library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity multiplexeur_tb is
end entity;

architecture sim of multiplexeur_tb is
    constant N: positive := 32;
    signal A, B, S: std_logic_vector(N-1 downto 0);
    signal COM: std_logic;
    
    component multiplexeur is
        generic(N: positive := 32);
        port(
            A, B: in std_logic_vector(N-1 downto 0);
            COM: in std_logic;
            S: out std_logic_vector(N-1 downto 0));
    end component;
begin
    DUT: multiplexeur generic map(N => N) port map(A => A, B => B, COM => COM, S => S);
    
    stimulus: process
    begin
        -- Test case 1
        A <= x"00000000";
        B <= x"FFFFFFFF";
        COM <= '0';
        wait for 100 ns;
        assert (S = A) report "Test Case 1 failed" severity error;

        -- Test case 2
        A <= x"00000000";
        B <= x"FFFFFFFF";
        COM <= '1';
        wait for 100 ns;
        assert (S = B) report "Test Case 2 failed" severity error;

        -- Test case 3
        A <= x"12345678";
        B <= x"9ABCDEF0";
        COM <= '0';
        wait for 100 ns;
        assert (S = A) report "Test Case 3 failed" severity error;

        -- Test case 4
        A <= x"12345678";
        B <= x"9ABCDEF0";
        COM <= '1';
        wait for 100 ns;
        assert (S = B) report "Test Case 4 failed" severity error;

        assert false report "End of testbench" severity note;

    end process;
    
end architecture sim;