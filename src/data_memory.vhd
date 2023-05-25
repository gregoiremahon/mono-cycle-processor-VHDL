-- __  __                                   _                                                     
--|  \/  |                                 | |                                                    
--| \  / | ___  _ __   ___   ___ _   _  ___| | ___   _ __  _ __ ___   ___ ___  ___ ___  ___  _ __ 
--| |\/| |/ _ \| '_ \ / _ \ / __| | | |/ __| |/ _ \ | '_ \| '__/ _ \ / __/ _ \/ __/ __|/ _ \| '__|
--| |  | | (_) | | | | (_) | (__| |_| | (__| |  __/ | |_) | | | (_) | (_|  __/\__ \__ \ (_) | |   
--|_|  |_|\___/|_| |_|\___/ \___|\__, |\___|_|\___| | .__/|_|  \___/ \___\___||___/___/\___/|_|   
--                                __/ |             | |                                           
--         

-- *******************************************************************************
-- Entity Name: data_memory
-- Description: This entity represents a data memory module. 
-- It can store and load 64 words of 32 bits.
-- It takes a 32-bit input bit vector (DataIn) for writing, a 6-bit address input bit vector (Addr) for both reading and writing,
-- a clock signal (CLK), and a write enable signal (WrEn).
-- Depending on the value of WrEn, it performs a write operation to the memory.
-- If WrEn = '1', then the value of DataIn is written to the memory at the address specified by Addr.
-- The value of the memory at the address specified by Addr is always output on DataOut.
-- Authors: MAHON and LELONG
-- *******************************************************************************
-- Gregoire Mahon & Armand Lelong 16/03/2023

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
