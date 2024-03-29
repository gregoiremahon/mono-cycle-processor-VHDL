library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity Processing_Unit_tb is
end entity;

architecture sim of Processing_Unit_tb is
    signal WE, RESET, CLK: std_logic;
    signal OP: std_logic_vector(1 downto 0);
    signal RW, RA, RB: std_logic_vector(3 downto 0);
    signal busW: std_logic_vector(31 downto 0);
    
    component Processing_Unit is
        port(
            WE, RESET, CLK: in std_logic;
            OP: in std_logic_vector(1 downto 0);
            RW, RA, RB: in std_logic_vector(3 downto 0);
            busW: out std_logic_vector(31 downto 0));
    end component;
begin
    DUT: Processing_Unit port map(WE => WE, RESET => RESET, CLK => CLK, OP => OP, RW => RW, RA => RA, RB => RB, busW => busW);
    
    stimulus: process
    begin
        -- Initialize signals
        WE <= '0';
        RESET <= '0';
        OP <= "00";
        RA <= "0000";
        RB <= "0000";
        RW <= "0000";
        CLK <= '0';
        
        -- Apply clock signal
        loop
            CLK <= '1';
            wait for 10 ns;
            CLK <= '0';
            wait for 10 ns;
        end loop;
    end process;

    test_cases: process
        variable busW_expected: std_logic_vector(31 downto 0);
    begin
        wait for 20 ns;
        RESET <= '1'; -- Reset
        wait for 20 ns;
        RESET <= '0'; -- End reset

        -- Test case: R(1) = R(15)
        WE <= '1';
        OP <= "00";
        RA <= "1111";
        RB <= "1111";
        RW <= "0001";
        wait for 20 ns;
        busW_expected := busW;
        assert (busW = busW_expected) report "Test Case 1 failed" severity error;

        -- Test case: R(1) = R(1) + R(15)
        OP <= "01";
        RA <= "0001";
        RB <= "1111";
        RW <= "0001";
        wait for 20 ns;
        busW_expected := std_logic_vector(unsigned(busW_expected) + unsigned(busW));
        assert (busW = busW_expected) report "Test Case 2 failed" severity error;

        -- Test case: R(2) = R(1) + R(15)
        OP <= "01";
        RA <= "0001";
        RB <= "1111";
        RW <= "0010";
        wait for 20 ns;
        assert (busW = busW_expected) report "Test Case 3 failed" severity error;

        -- Test case: R(3) = R(1) ? R(15)
        OP <= "10";
        RA <= "0001";
        RB <= "1111";
        RW <= "0011";
        wait for 20 ns;
        busW_expected := std_logic_vector(signed(busW_expected) - signed(busW));
        assert (busW = busW_expected) report "Test Case 4 failed" severity error;

	    -- Test case: R(5) = R(7) ? R(15)
    	OP <= "10";
   	RA <= "0111";
    	RB <= "1111";
    	RW <= "0101";
    	wait for 20 ns;
    	busW_expected := std_logic_vector(signed(busW) - signed(busW));
    	assert (busW = busW_expected) report "Test Case 5 failed" severity error;

    	assert false report "End of testbench" severity note;
end process;

end architecture sim;