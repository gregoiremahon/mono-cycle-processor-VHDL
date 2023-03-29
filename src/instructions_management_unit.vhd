library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_unit is
    port (
        CLK, RESET, nPCsel : in std_logic;
        offset : in std_logic_vector(23 downto 0);
        instruction_out: out std_logic_vector(31 downto 0)
    );
end entity instruction_unit;

architecture arch_instruction_unit of instruction_unit is
    signal PC: unsigned(31 downto 0) := (others => '0');
    signal next_PC: unsigned(31 downto 0);
    signal sign_extended_offset: std_logic_vector(31 downto 0);

    type instruction_memory_array is array (63 downto 0) of std_logic_vector(31 downto 0);
    signal instruction_memory: instruction_memory_array;

begin

    E1: entity work.sign_extension
        generic map(24)
        port map (
            E => offset,
            S => sign_extended_offset
        );

    process (CLK, RESET)
        begin
            if RESET = '1' then
                PC <= (others => '0');
            elsif rising_edge(CLK) then
                PC <= next_PC;
                end if;
                end process;
        
    process (nPCsel, PC, sign_extended_offset)
        begin
            if nPCsel = '0' then
                next_PC <= PC + 1;
            else
                next_PC <= PC + 1 + unsigned(sign_extended_offset);
            end if;
        end process;
        
    instruction_out <= instruction_memory(to_integer(PC));
        
end architecture arch_instruction_unit;
        