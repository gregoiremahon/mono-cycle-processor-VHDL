library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory_tb is
end entity;

architecture sim of data_memory_tb is
    signal CLK: std_logic := '0';
    signal DataIn, DataOut: std_logic_vector(31 downto 0);
    signal Addr: std_logic_vector(5 downto 0);
    signal WrEn: std_logic;

    constant UNINITIALIZED_VALUE: std_logic_vector(31 downto 0) := (others => '0');

    component data_memory is
        port (
            CLK: in std_logic;
            DataIn: in std_logic_vector(31 downto 0);
            DataOut: out std_logic_vector(31 downto 0);
            Addr: in std_logic_vector(5 downto 0);
            WrEn: in std_logic
        );
    end component;

begin
    DUT: data_memory port map(CLK => CLK, DataIn => DataIn, DataOut => DataOut, Addr => Addr, WrEn => WrEn);

    -- Clock generation process
    process
    begin
        CLK <= not CLK;
        wait for 10 ns;
    end process;

    stimulus: process
    begin
        -- Test case 1: Write data to address 5 and read it back
        DataIn <= x"12345678";
        Addr <= "000101";
        WrEn <= '1';
        wait for 20 ns;

        WrEn <= '0';
        wait for 20 ns;

        Addr <= "000101";
        wait for 20 ns;
        assert DataOut = x"12345678" report "Test Case 1 failed" severity error;

        -- Test case 2: Write data to address 10 and read it back
        DataIn <= x"9ABCDEF0";
        Addr <= "001010";
        WrEn <= '1';
        wait for 20 ns;

        WrEn <= '0';
        wait for 20 ns;

        Addr <= "001010";
        wait for 20 ns;
        assert DataOut = x"9ABCDEF0" report "Test Case 2 failed" severity error;
    
        -- Test case 3: Read from address 63 (initial value)
        variable tmp : std_logic_vector(31 downto 0);
        tmp := (others => '0');

        Addr <= "111111";
        wait for 20 ns;

        assert DataOut = tmp report "Test Case 3 failed" severity error;




        -- Information note
        assert false report "End of testbench" severity note;

    end process;
    
end architecture sim;
