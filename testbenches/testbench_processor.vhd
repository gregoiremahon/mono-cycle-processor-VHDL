-- *******************************************************************************
-- Testbench Name: processor_tb
-- Description: This testbench is designed to test the functionality of the processor entity.
-- It simulates the operation of the processor with a series of instructions specified in the instruction_unit entity.
-- Each instruction is tested individually with an assertion to verify that the result is correct.
-- If an assertion fails, an error message is displayed.
-- The test ends when all instructions have been tested.
-- The testbench includes a clock process to simulate the clock signal and a test process to simulate the instructions.
-- Authors: MAHON and LELONG
-- *******************************************************************************


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_tb is
end entity processor_tb;

architecture arch_processor_tb of processor_tb is
    signal clock, reset, nPCsel, WE : std_logic := '0';
    signal Instruction : std_logic_vector(31 downto 0) := (others => '0');
    signal PSR : std_logic_vector(31 downto 0) := (others => '0');
    signal DATAIN : std_logic_vector(31 downto 0) := (others => '0');
    signal DATAOUT : std_logic_vector(31 downto 0);
    signal offset : std_logic_vector(23 downto 0) := (others => '0');

begin
    -- Instantiate the processor
    proc: entity work.processor
        port map (
            clock => clock,
            reset => reset,
            Instruction => Instruction,
            PSR => PSR,
            DATAIN => DATAIN,
            DATAOUT => DATAOUT,
            WE => WE
        );

    -- Instantiate the instruction unit
    inst_unit: entity work.instruction_unit
        port map (
            CLK => clock,
            RESET => reset,
            nPCsel => nPCsel,
            offset => offset,
            instruction_out => Instruction
        );

    -- Clock process
    clock_process : process
    begin
        clock <= '0';
        wait for 10 ns;
        clock <= '1';
        wait for 10 ns;
    end process;

    -- Test process
    test_process : process
    begin
        -- Reset the processor
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Test the MOV instruction
        -- R1 <= 0x20;
        wait for 20 ns;
        assert PSR = "00000000000000000000000000100000"
        report "MOV instruction failed"
        severity error;

        -- Test the ADDi instruction
        -- R2 <= 0x0;
        wait for 20 ns;
        assert PSR = "00000000000000000000000000000000"
        report "ADDi instruction failed"
        severity error;

        -- Test the LDR instruction
        -- R0 <= DATA_MEM[R1];
        wait for 20 ns;
        assert PSR = "00000000000000000000000000000000"
        report "LDR instruction failed"
        severity error;

        -- Test the ADDr instruction
        -- R2 <= R2 + R0;
        wait for 20 ns;
        assert PSR = "00000000000000000000000000000000"
        report "ADDR instruction failed"
        severity error;

        -- Test the CMP instruction
        -- ? R1 = 0x2A;
        wait for 20 ns;
        assert PSR = "00000000000000000000000000101010"
        report "CMP instruction failed"
        severity error;

        -- Test the STR instruction
        -- DATA_MEM[R1] <= R2;
        wait for 20 ns;
        assert PSR = "00000000000000000000000000000000"
        report "STR instruction failed"
        severity error;

        -- Test the BAL instruction
        -- Branchement à _main (0x0);
        wait for 20 ns;
        assert PSR = "00000000000000000000000000000000"
        -- Test the BAL instruction
        -- Branchement à _main (0x0);
        wait for 20 ns;
        assert PSR = "00000000000000000000000000000000"
        report "BAL instruction failed"
        severity error;

        -- Test the BNE instruction
        -- Branchement à _loop (0x02) si R1 inferieur a 0x2A;
        wait for 20 ns;
        assert PSR = "00000000000000000000000000000010"
        report "BNE instruction failed"
        severity error;

        -- End of test
        assert false
        report "End of test reached"
        severity note;
        wait;
    end process;
end architecture arch_processor_tb;
