
-- __  __                                   _                                                     
--|  \/  |                                 | |                                                    
--| \  / | ___  _ __   ___   ___ _   _  ___| | ___   _ __  _ __ ___   ___ ___  ___ ___  ___  _ __ 
--| |\/| |/ _ \| '_ \ / _ \ / __| | | |/ __| |/ _ \ | '_ \| '__/ _ \ / __/ _ \/ __/ __|/ _ \| '__|
--| |  | | (_) | | | | (_) | (__| |_| | (__| |  __/ | |_) | | | (_) | (_|  __/\__ \__ \ (_) | |   
--|_|  |_|\___/|_| |_|\___/ \___|\__, |\___|_|\___| | .__/|_|  \___/ \___\___||___/___/\___/|_|   
--                                __/ |             | |                                           
--                               |___/              |_|                                           


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
    generic (N : positive := 32;
             J : positive := 24;
             I : positive := 8
            );
    port (clock, reset : in std_logic;
          Instruction : in std_logic_vector(N-1 downto 0);
          PSR : inout std_logic_vector(N-1 downto 0);
          DATAIN : in std_logic_vector(31 downto 0);
          DATAOUT : out std_logic_vector(31 downto 0);
          WE : in std_logic
          );
end entity processor;

architecture arch_processor of processor is
    -- Les signaux de contrôle pour l'instruction decoder
    signal nPCsel, RegWr, UALSrc, PSREn, MemWr, WrSrc, RegSel: std_logic;
    signal OP: std_logic_vector(1 downto 0);
    signal Rn, Rd, Rm: std_logic_vector(3 downto 0);
    signal Imm: std_logic_vector(I-1 downto 0);
    signal Offset: std_logic_vector(J-1 downto 0);
    signal a, b : std_logic_vector(31 downto 0);
    signal s : std_logic_vector(31 downto 0);
    begin
        -- Instruction Decoder
        inst_dec: entity work.Instruction_Decoder generic map(N => N, J => J, I => I)
            port map (
                Instruction => Instruction,
                PSR => PSR,
                nPCsel => nPCsel,
                RegWr => RegWr,
                UALSrc => UALSrc,
                PSREn => PSREn,
                MemWr => MemWr,
                WrSrc => WrSrc,
                RegSel => RegSel,
                OP => OP,
                Rn => Rn,
                Rd => Rd,
                Rm => Rm,
                Imm => Imm,
                Offset => Offset
            );

        -- Unité de traitement (UAL)
        ual: entity work.ual
            port map (
                OP => OP,
                a => a,
                b => b,
                s => s
            );

        -- Unité de contrôle (control_unit)
        ctrl_unit: entity work.control_unit
            port map (
                DATAIN => DATAIN,
                RST => reset,
                CLK => clock,
                WE => WE,
                DATAOUT => DATAOUT
            );

end architecture arch_processor;
