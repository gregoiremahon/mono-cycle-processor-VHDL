-- __  __                                   _                                                     
--|  \/  |                                 | |                                                    
--| \  / | ___  _ __   ___   ___ _   _  ___| | ___   _ __  _ __ ___   ___ ___  ___ ___  ___  _ __ 
--| |\/| |/ _ \| '_ \ / _ \ / __| | | |/ __| |/ _ \ | '_ \| '__/ _ \ / __/ _ \/ __/ __|/ _ \| '__|
--| |  | | (_) | | | | (_) | (__| |_| | (__| |  __/ | |_) | | | (_) | (_|  __/\__ \__ \ (_) | |   
--|_|  |_|\___/|_| |_|\___/ \___|\__, |\___|_|\___| | .__/|_|  \___/ \___\___||___/___/\___/|_|   
--                                __/ |             | |                                           
--         

-- *******************************************************************************
-- Entity Name: traitement_unit
-- Description: This entity represents a processing unit. 
-- It takes several inputs including a clock signal (CLK), write enable signals (We, WrEn), control signals (COM1, COM2), a reset signal (RESET),
-- an 8-bit immediate input bit vector (imm), and 4-bit address input bit vectors (RW, RA, RB), and a 2-bit operation code (OP).
-- The processing unit includes a register bank, an ALU, a data memory, a sign extension unit, and two multiplexers.
-- The register bank (E1) takes inputs from Bus_W, RA, RB, RW, and WE, and outputs Bus_A and Bus_B.
-- The ALU (E2) takes inputs from OP, Bus_A, and Mux_F_OUT, and outputs ALU_OUT and flag.
-- The data memory (E3) takes inputs from CLK, Bus_B, ALU_OUT, and WrEn, and outputs Data_OUT.
-- The sign extension unit (E4) takes input from imm, and outputs EXS_OUT.
-- The first multiplexer (E5) takes inputs from Bus_B, EXS_OUT, and COM1, and outputs Mux_F_OUT.
-- The second multiplexer (E6) takes inputs from ALU_OUT, Data_OUT, and COM2, and outputs Bus_W.
-- Authors: MAHON and LELONG
-- *******************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traitement_unit is
    generic (
        N : positive := 32;
        J : positive := 8
    );
    port (
        CLK, We, WrEn, COM1, COM2, RESET : in std_logic;
        imm : in std_logic_vector(J-1 downto 0);
        RW, RA, RB : in std_logic_vector(3 downto 0);
        OP : in std_logic_vector(1 downto 0);
        flag : out std_logic;
        BusW : out std_logic_vector(31 downto 0)
    );
end entity traitement_unit;

architecture arch_traitement_unit of traitement_unit is
    signal Bus_W, Bus_A, Bus_B, EXS_OUT, Mux_F_OUT, ALU_OUT, Data_OUT : std_logic_vector(31 downto 0);

begin

    BusW <= Bus_W; 

    E1: entity work.banc_registres port map (CLK, RESET, Bus_W, RA, RB, RW, WE, Bus_A, Bus_B);

    E2: entity work.ual port map (OP, Bus_A, Mux_F_OUT, ALU_OUT, flag);

    E3: entity work.data_memory port map (CLK, Bus_B, Data_OUT, ALU_OUT(5 downto 0), WrEn);

    E4: entity work.sign_extension port map (imm, EXS_OUT);

    E5: entity work.multiplexeur generic map (N) port map (Bus_B, EXS_OUT, COM1, Mux_F_OUT);

    E6: entity work.multiplexeur generic map (N) port map (ALU_OUT, Data_OUT, COM2, Bus_W);
    
end architecture arch_traitement_unit;

