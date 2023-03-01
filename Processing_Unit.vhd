library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processing_Unit is
    port (
        -- General signals
        clk, rst : in std_logic;

        -- Register bank signals
        reg_w : in std_logic_vector(31 downto 0);  -- Data to write to register bank
        reg_ra, reg_rb, reg_rw : in std_logic_vector(3 downto 0);  -- Register addresses for read operations
        reg_we : in std_logic;  -- Write enable for register bank
        reg_a, reg_b : out std_logic_vector(31 downto 0);  -- Data output from register bank

        -- UAL signals
        ual_op : in std_logic_vector(1 downto 0);  -- Operation code for UAL
        ual_a, ual_b : in std_logic_vector(31 downto 0);  -- Inputs to UAL
        ual_s : out std_logic_vector(31 downto 0);  -- Result output from UAL
        ual_n : out std_logic  -- Negative flag output from UAL
    );
end Processing_Unit;

architecture behavior of Processing_Unit is
    -- Internal signals
    signal reg_w_internal : std_logic_vector(31 downto 0);
    signal reg_ra_internal, reg_rb_internal, reg_rw_internal : std_logic_vector(3 downto 0);
    signal reg_we_internal : std_logic;
    signal reg_a_internal, reg_b_internal : std_logic_vector(31 downto 0);
    signal ual_s_internal : std_logic_vector(31 downto 0);
    signal ual_n_internal : std_logic;

    -- Component declarations
    component banc_registres is
        port (
            clk, rst : in std_logic;
            w : in std_logic_vector(31 downto 0);
            ra, rb, rw : in std_logic_vector(3 downto 0);
            we : in std_logic;
            a, b : out std_logic_vector(31 downto 0)
        );
    end component;

    component ual is
        port (
            op : in std_logic_vector(1 downto 0);
            a, b : in std_logic_vector(31 downto 0);
            s : out std_logic_vector(31 downto 0);
            n : out std_logic
        );
    end component;

begin
    -- Instantiate the register bank component
    REG_inst : banc_registres
        port map (
            clk => clk,
            rst => rst,
            w => reg_w_internal,
            ra => reg_ra_internal,
            rb => reg_rb_internal,
            rw => reg_rw_internal,
            we => reg_we_internal,
            a => reg_a_internal,
            b => reg_b_internal
        );

    -- Instantiate the UAL component
    UAL_inst : ual
        port map (
            op => ual_op,
            a => ual_a,
            b => ual_b,
            s => ual_s_internal,
            n => ual_n_internal
        );

    -- Assign internal signals to external signals
    reg_w_internal <= reg_w;
    reg_ra_internal <= reg_ra;
    reg_rb_internal <= reg_rb;
    reg_rw_internal <= reg_rw;
    reg_we_internal <= reg_we;
    reg_a <= reg_a_internal;
    reg_b <= reg_b_internal;
    ual_s <= ual_s_internal;
    ual_n <= ual_n_internal;
end behavior;

