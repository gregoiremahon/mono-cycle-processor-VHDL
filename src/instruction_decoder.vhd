library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_decoder is
    port (
        instruction: in std_logic_vector(31 downto 0);
        PSR: in std_logic_vector(31 downto 0);
        nPCsel: out std_logic;
        PSR_we: out std_logic;
        RA, RB, RW: out std_logic_vector(3 downto 0);
        Reg_we: out std_logic;
        RegSel: out std_logic;
        OP: out std_logic_vector(1 downto 0);
        UALSrc: out std_logic;
        WrSrc: out std_logic;
        Data_we: out std_logic
    );
end entity instruction_decoder;

architecture behavior of instruction_decoder is
    type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);
    signal instr_courante: enum_instruction;

begin
    -- Process to determine the current instruction
    process (instruction)
    begin
        instr_courante <= MOV; -- Default case [TBD]
        case instruction(31 downto 20) is
            when "111000101000" => instr_courante <= ADDi;
            when "111000001000" => instr_courante <= ADDr;
            when "111000111010" => instr_courante <= MOV;
            when "111000110101" => instr_courante <= CMP;
            when "111001100001" => instr_courante <= LDR;
            when "111001100000" => instr_courante <= STR;
            
        end case;
        -- BAL and BLT instructions are only on 7 bits
        case instruction(31 downto 24) is
            when "11101010" => instr_courante <= BAL;
            when "10111010" => instr_courante <= BLT;
            
        end case;
    end process;

    -- Process to generate control signals for registers and operators
    process (instr_courante)
    begin
        case instr_courante is
            when MOV =>


            when ADDi =>


            when ADDr =>


            when CMP =>


            when LDR =>


            when STR =>


            when BAL =>


            when BLT =>

        end case;
    end process
end architecture behavior;
