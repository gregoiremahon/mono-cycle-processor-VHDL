library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processingUnit is
    port (
        clk, rst: in std_logic;
        instruction: in std_logic_vector(31 downto 0);
        dataOut: out std_logic_vector(31 downto 0)
    );
end entity processingUnit;

architecture behavior of processingUnit is

    -- Components
    component banc_registres is
        port (
            clk, rst: in std_logic;
            w: in std_logic_vector(31 downto 0);
            ra, rb, rw: in std_logic_vector(3 downto 0);
            we: in std_logic;
            a, b: out std_logic_vector(31 downto 0)
        );
    end component banc_registres;

    component ual is
        port (
            op : in std_logic_vector(1 downto 0);
            a, b : in std_logic_vector(31 downto 0);
            s : out std_logic_vector(31 downto 0);
            n : out std_logic
        );
    end component ual;

    -- Internal signals
    signal op : std_logic_vector(1 downto 0);
    signal rs, rt, rd : std_logic_vector(3 downto 0);
    signal regA, regB, regOut : std_logic_vector(31 downto 0);

begin

    -- Banc Registres instantiation
    BR : banc_registres port map(
        clk => clk,
        rst => rst,
        w => regOut,
        ra => rs,
        rb => rt,
        rw => rd,
        we => op /= "01",
        a => regA,
        b => regB
    );

    -- UAL instantiation
    U : ual port map(
        op => op,
        a => regA,
        b => regB,
        s => regOut,
        n => open -- not used
    );

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                regA <= (others => '0');
                regB <= (others => '0');
                regOut <= (others => '0');
            else
                -- Set the op signal to the appropriate value
                op <= instruction(5 downto 4);

                -- Set the rs and rt signals to the appropriate values
                rs <= instruction(25 downto 21);
                rt <= instruction(20 downto 16);

                -- Write to the register file if the op signal is not 01
                if op /= "01" then
                    rd <= instruction(15 downto 11);
                    regA <= regOut;
                end if;
            end if;
        end if;
    end process;

    -- Output the data from the processing unit
    dataOut <= regOut;

end architecture behavior;
