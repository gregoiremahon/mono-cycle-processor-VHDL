
Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Instruction_Decoder is
generic(N : positive :=32);
port(	Instruction, PSR : in std_logic_vector(N-1 downto 0);
	--Commande:
	nPCsel,RegWr,UALSrc,PSREn,MemWr,WrSrc,RegSel : out std_logic;
	OP : out std_logic_vector(1 downto 0);
	--Commande Registre:
	Rn,Rd,Rm : out std_logic_vector(3 downto 0));	
end entity;

Architecture arch_Instruction_Decoder of Instruction_Decoder is
    type enum_instruction is (MOV,ADDi,ADDr,CMP,LDR,STR,BAL,BLT);
    signal instr_courante : enum_instruction;

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
            when others => instr_courante <= MOV;
        end case;
        -- BAL and BLT instructions are only on 7 bits
        case instruction(31 downto 24) is
            when "11101010" => instr_courante <= BAL;
            when "10111010" => instr_courante <= BLT;
            when others => instr_courante <= MOV;
            
        end case;
    end process;

    -- Process to generate control signals for registers and operators
    process (instr_courante)
    begin
        case instr_courante is
                -- Still need to put correct values
            when MOV =>
                nPCsel <='1';
                --PSR <= '0';
                PSREn <= '0';
                RegWr <= '1';
                RegSel <= '0';
                OP <= "01";
                UALSrc <= '1';
                WrSrc <= '0';
                MemWr <= '0';

            when ADDi =>
                nPCsel <= '0';
                --PSR <= '0';
                PSREn <= '0';
                RegWr <= '1';
                RegSel <= '0';
                OP <= "00";
                UALSrc <= '1';
                WrSrc <= '0';
                MemWr <= '0';

            when ADDr =>
                nPCsel <= '0';
                --PSR <= '0';
                PSREn <= '0';
                RegWr <= '1';
                RegSel <= '0';
                OP <= "00";
                UALSrc <= '0';
                WrSrc <= '0';
                MemWr <= '0';

            when CMP =>
                nPCsel <= '0';
                --PSR <= '1';
                PSREn <= '1';
                RegWr <= '1';
                RegSel <= '0';
                OP <= "10";
                UALSrc <= '1';
                WrSrc <= '0';
                MemWr <= '0';

            when LDR =>
                nPCsel <= '1';
                --PSR <= '0';
                PSREn <= '0';
                RegWr <= '1';
                RegSel <= '0';
                OP <= "00";
                UALSrc <= '0';
                WrSrc <= '1';
                MemWr <= '0';

            when STR =>
                nPCsel <= '1';
                --PSR <= '0';
                PSREn <= '0';
                RegWr <= '0';
                RegSel <= '1';
                OP <= "10";
                UALSrc <= '0';
                WrSrc <= '1';
                MemWr <= '1';

            when BAL =>
                nPCsel <= '1';
                --PSR <= '0';
                PSREn <= '0';
                RegWr <= '0';
                RegSel <= '0';
                OP <= "--";
                UALSrc <= '0';
                WrSrc <= '0';
                MemWr <= '0';

            when BLT =>
                nPCsel <= PSR(0); -- First PSR bit
                --PSR <= '0';
                PSREn <= '0';
                RegWr <= '0';
                RegSel <= '0';
                OP <= "--";
                UALSrc <= '0';
                WrSrc <= '0';
                MemWr <= '0';
        end case;
    end process;
end architecture;
