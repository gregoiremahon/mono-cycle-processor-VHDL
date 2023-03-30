library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- gregoiremahon & Armand Lelong 16/03/2023

-- Data Memory Entity
-- This entity represents a memory module that can store and load 64 words of 32 bits.
-- It has the following inputs and outputs:
-- CLK: Clock input
-- DataIn: 32-bit data input for writing
-- DataOut: 32-bit data output for reading
-- Addr: 6-bit address input for both reading and writing
-- WrEn: Write Enable signal (1 bit)
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
    -- Memory array type definition (64 words of 32 bits)
    type memory_array is array (63 downto 0) of std_logic_vector(31 downto 0);

    -- Memory signal declaration (memory array)
    signal memory: memory_array;

begin
    -- Write process
    -- This process is triggered by the rising edge of the CLK signal
    -- When WrEn is '1', the DataIn value is written to the memory location specified by Addr
    process (CLK)
    begin
        if rising_edge(CLK) then
            if WrEn = '1' then
                memory(to_integer(unsigned(Addr))) <= DataIn;
            end if;
        end if;
    end process;

    -- Read process (combinatorial)
    -- The DataOut output is assigned the value from the memory location specified by Addr
    DataOut <= memory(to_integer(unsigned(Addr)));

end architecture behavior;
