library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processing_unit_tb is
end processing_unit_tb;

architecture sim of processing_unit_tb is

    -- Component declaration for the DUT
    component processing_unit is
        port (
            -- General signals
            clk, rst : in std_logic;

            -- Register bank signals
            reg_w : in std_logic_vector(31 downto 0);
            reg_ra, reg_rb, reg_rw : in std_logic_vector(3 downto 0);
            reg_we : in std_logic;
            reg_a, reg_b : out std_logic_vector(31 downto 0);

            -- UAL signals
            ual_op : in std_logic_vector(1 downto 0);
            ual_a, ual_b : in std_logic_vector(31 downto 0);
            ual_s : out std_logic_vector(31 downto 0);
            ual_n : out std_logic
        );
    end component;

    -- Signals
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal reg_w : std_logic_vector(31 downto 0) := (others => '0');
    signal reg_ra : std_logic_vector(3 downto 0) := (others => '0');
    signal reg_rb : std_logic_vector(3 downto 0) := (others => '0');
    signal reg_rw : std_logic_vector(3 downto 0) := (others => '0');
    signal reg_we : std_logic := '0';
    signal reg_a : std_logic_vector(31 downto 0);
    signal reg_b : std_logic_vector(31 downto 0);
    signal ual_op : std_logic_vector(1 downto 0);
    signal ual_a : std_logic_vector(31 downto 0);
    signal ual_b : std_logic_vector(31 downto 0);
    signal ual_s : std_logic_vector(31 downto 0);
    signal ual_n : std_logic;

begin

    -- Instantiate the DUT
    dut: processing_unit port map (
            clk => clk,
            rst => rst,
            reg_w => reg_w,
            reg_ra => reg_ra,
            reg_rb => reg_rb,
            reg_rw => reg_rw,
            reg_we => reg_we,
            reg_a => reg_a,
            reg_b => reg_b,
            ual_op => ual_op,
            ual_a => ual_a,
            ual_b => ual_b,
            ual_s => ual_s,
            ual_n => ual_n
        );

    -- Clock process
    clk_process :process
    begin
        while now < 2000 ns loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process clk_process;

    -- Reset process
    rst_process : process
    begin
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait;
    end process rst_process;

    -- Stimulus process
    stimulus: process
    begin

        -- R(1) = R(15)
        reg_ra <= "0001";
        reg_rb <= "1111";
        reg_we <= '0';
        wait for 10 ns;
        assert reg_a = reg_b
            report "Error: R(1) != R(15)" severity error;

           -- R(1) = R(1) + R(15)
    reg_ra <= "0001";
    reg_rb <= "1111";
    reg_we <= '1';
    reg_w <= std_logic_vector(unsigned(reg_a) + unsigned(reg_b));
    wait for 10 ns;
    assert reg_a = std_logic_vector(unsigned(reg_a) + unsigned(reg_b))
        report "Error: R(1) != R(1) + R(15)" severity error;

    -- R(2) = R(1) + R(15)
    reg_ra <= "0001";
    reg_rb <= "1111";
    reg_rw <= "0010";
    reg_we <= '1';
    reg_w <= std_logic_vector(unsigned(reg_a) + unsigned(reg_b));
    wait for 10 ns;
    assert reg_a = std_logic_vector(unsigned(reg_a) + unsigned(reg_b))
        report "Error: R(2) != R(1) + R(15)" severity error;

    -- R(3) = R(1) - R(15)
    reg_ra <= "0001";
    reg_rb <= "1111";
    reg_rw <= "0011";
    reg_we <= '1';
    reg_w <= std_logic_vector(unsigned(reg_a) - unsigned(reg_b));
    wait for 10 ns;
    assert reg_a = std_logic_vector(unsigned(reg_a) - unsigned(reg_b))
        report "Error: R(3) != R(1) - R(15)" severity error;

    -- R(5) = R(7) - R(15)
    reg_ra <= "0111";
    reg_rb <= "1111";
    reg_rw <= "0101";
    reg_we <= '1';
    reg_w <= std_logic_vector(unsigned(reg_a) - unsigned(reg_b));
    wait for 10 ns;
    assert reg_a = std_logic_vector(unsigned(reg_a) - unsigned(reg_b))
        report "Error: R(5) != R(7) - R(15)" severity error;

    wait;
end process stimulus;
end sim;
