library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_register_file is
end entity testbench_register_file;

architecture behavior of testbench_register_file is
    -- Declaration and Initialization of 16x32-bit Register File
    type table is array (15 downto 0) of std_logic_vector(31 downto 0);
    function init_banc return table is
        variable result : table;
    begin
        for i in 14 downto 0 loop
            result(i) := (others => '0');
        end loop;
        result(15) := x"00000030";
        return result;
    end init_banc;
    signal banc : table := init_banc;
    
    -- Component Declaration for Register File
    component register_file is
        port (
            clk : in std_logic;
            w : in std_logic_vector(31 downto 0);
            ra, rb : in std_logic_vector(3 downto 0);
            rw : in std_logic_vector(3 downto 0);
            we : in std_logic;
            a, b : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Input and Output Signals
    signal clk : std_logic := '0';
    signal w : std_logic_vector(31 downto 0) := x"00000001";
    signal ra, rb, rw : std_logic_vector(3 downto 0) := "0000";
    signal we : std_logic := '0';
    signal a, b : std_logic_vector(31 downto 0);

begin
    -- Instantiate Register File
    reg_file : register_file port map (
        clk => clk,
        w => w,
        ra => ra,
        rb => rb,
        rw => rw,
        we => we,
        a => a,
        b => b
    );
    
    -- Clock Process
    process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    -- Test Case 1 : Write to register, read back, compare
    process
    begin
    we <= '1';
    rw <= "0001";
    w <= x"00000002";
    wait for 10 ns;
    we <= '0';
    ra <= "0001";
    rb <= "0000";
    wait for 10 ns;
    assert a = x"00000002" and b = x"00000001"
        report "Test case 1 failed" severity error;
        wait;
    end process;
    
    -- Test Case 2 : Write to register, read back, compare
    process
    begin
    we <= '1';
    rw <= "1001";
    w <= x"ffffffff";
    wait for 10 ns;
    we <= '0';
    ra <= "1001";
    rb <= "0000";
    wait for 10 ns;
    assert a = x"ffffffff" and b = x"00000001"
        report "Test case 2 failed" severity error;
    wait;
    end process;
    
    -- Test case 3 : Writing to a register
    process
    begin
    WE <= '1';
    RW <= "0000";
    W <= x"12345678";
    wait for 10 ns;
    WE <= '0';
    wait for 10 ns;
    assert A = x"00000000" and B = x"00000030" report "Test case 3 failed" severity error;
    wait;
    end process;

    -- Test case 4 : Reading from a register
    process
    begin
    RA <= "1111";
    RB <= "1110";
    wait for 10 ns;
    assert A = x"00000030" and B = x"12345678" report "Test case 4 failed" severity error;
    wait;
    end process;
    -- Test case 5 : Writing to another register
    process
    begin
    WE <= '1';
    RW <= "0001";
    W <= x"fedcba98";	
    wait for 10 ns;
    WE <= '0';
    wait for 10 ns;
    assert A = x"00000030" and B = x"12345678" report "Test case 5 failed" severity error;
    wait;
    end process;    

end architecture behavior;
