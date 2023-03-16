library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is
    port (
        CLK: in std_logic;
        DataIn: in std_logic_vector(31 downto 0);
        DataOut: out std_logic_vector(31 downto 0);
        Addr: in std_logic_vector(5 downto 0);
        WrEn: in std_logic
    );
end entity data_memory;

architecture behavior of data_memory is
    type memory_array is array (63 downto 0) of std_logic_vector(31 downto 0);

    signal memory: memory_array;

begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if WrEn = '1' then
                memory(to_integer(unsigned(Addr))) <= DataIn;
            end if;
        end if;
    end process;

    DataOut <= memory(to_integer(unsigned(Addr)));

end architecture behavior;
