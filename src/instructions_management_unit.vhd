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

    function init_instruction_memory return instruction_memory_array is
        variable result : instruction_memory_array;
    begin
        for i in 62 downto 9 loop
           result(i) := (others => '0');
        end loop;

        -- Memory signal declaration (memory array) init with func init_memory
        
        -- Initializing memory to test the final processor
        -- R1 <= 0x20;
        result(0) := "11100011101000000001000000010100";

        -- R2 <= 0x0;
        result(1) := "11100011101000000010000000000000";

        -- R0 <= DATA_MEM[R1];
        result(2) := "11100110000100010000000000000000";

        -- R2 <= R2 + R0;
        result(3) := "11100000100000100010000000000000";

        -- R1 <= R1 + 1;
        result(4) := "11100000100000010001000000000001";

        -- ? R1 = 0x2A;
        result(5) := "11100011010100010000000000101010";

        -- Branchement à _loop (0x02) si R1 inferieur a 0x2A;
        result(6) := "10111010000000000000000000000010";

        -- DATA_MEM[R1] <= R2;
        result(7) := "11100110000000010010000000000000";

        -- Branchement à _main (0x0);
        result(8) := "11101010000000000000000000000000";


        return result;
    end init_instruction_memory;

    signal instruction_memory: instruction_memory_array:=init_instruction_memory;

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
        