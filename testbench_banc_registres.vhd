library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity banc_registres_tb is
end entity banc_registres_tb;

architecture behavior of banc_registres_tb is
    -- Inputs
    signal clk, rst, we : std_logic;
    signal w, ra, rb, rw : std_logic_vector(31 downto 0);

    -- Outputs
    signal a, b : std_logic_vector(31 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut : entity work.banc_registres
        port map (
            clk => clk,
            rst => rst,
            we => we,
            w => w,
            ra => ra(3 downto 0), -- Tronque la taille à 4 bits pour les adresses
            rb => rb(3 downto 0), -- Tronque la taille à 4 bits pour les adresses
            rw => rw(3 downto 0), -- Tronque la taille à 4 bits pour les adresses
            a => a,
            b => b
        );

    -- Clock generation
    clk_gen : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Reset generation
    rst_gen : process
    begin
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait;
    end process;

    -- Stimulus process
    stim_proc : process
    begin
        -- Write to register 0 with value x"00000001"
        we <= '1';
        w <= x"00000001";
        ra <= x"00000000";
        rb <= x"00000000";
        rw <= x"00000000";
        wait for 10 ns;

        -- Write to register 1 with value x"00000002"
        we <= '1';
        w <= x"00000002";
        ra <= x"00000001";
        rb <= x"00000001";
        rw <= x"00000001";
        wait for 10 ns;

        -- Read from register 0 and 1
        we <= '0';
        ra <= x"00000000";
        rb <= x"00000001";
        rw <= x"00000000";
        wait for 10 ns;

        -- Assert that the output a is equal to x"00000001"
        assert a = x"00000001" report "Error: a value is not correct" severity error;

        -- Assert that the output b is equal to x"00000002"
        assert b = x"00000002" report "Error: b value is not correct" severity error;

        -- Write to register 3 with value x"00000003"
        we <= '1';
        w <= x"00000003";
        ra <= x"00000011";
        rb <= x"00000011";
        rw <= x"00000011";
        wait for 10 ns;

        -- Read from register 3 and 15
        we <= '0';
        ra <= x"00000011";
        rb <= x"00001111";
        rw <= x"00000000";
        wait for 10 ns;

    -- Assert that the output a is equal to x"00000003"
    assert a = x"00000003" report "Error: a value is not correct" severity error;

    -- Assert that the output b is equal to x"00000030"
    assert b = x"00000030" report "Error: b value is not correct" severity error;

    wait;
end process;
end architecture behavior;

