-- __  __                                   _                                                     
--|  \/  |                                 | |                                                    
--| \  / | ___  _ __   ___   ___ _   _  ___| | ___   _ __  _ __ ___   ___ ___  ___ ___  ___  _ __ 
--| |\/| |/ _ \| '_ \ / _ \ / __| | | |/ __| |/ _ \ | '_ \| '__/ _ \ / __/ _ \/ __/ __|/ _ \| '__|
--| |  | | (_) | | | | (_) | (__| |_| | (__| |  __/ | |_) | | | (_) | (_|  __/\__ \__ \ (_) | |   
--|_|  |_|\___/|_| |_|\___/ \___|\__, |\___|_|\___| | .__/|_|  \___/ \___\___||___/___/\___/|_|   
--                                __/ |             | |                                           
--         

-- *******************************************************************************
-- Entity Name: control_unit
-- Description: This entity represents the control unit of the mono-cycle processor.
-- It manages the Processor State Register (PSR), which holds the current state of the processor.
-- The control unit takes a 32-bit input (DATAIN), a clock signal (CLK), a reset signal (RST),
-- and a write enable signal (WE).
-- At each rising edge of the clock, if the write enable signal is high, the contents of the PSR
-- are updated with the value of DATAIN. When the reset signal is active (high, or '1'), the PSR
-- is reset to 0. The current state of the PSR is outputted on DATAOUT.
-- Authors: MAHON and LELONG
-- *******************************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity control_unit is
    port (
        DATAIN: in std_logic_vector(31 downto 0);
        RST: in std_logic;
        CLK: in std_logic;
        WE: in std_logic;
        DATAOUT: out std_logic_vector(31 downto 0)
    );
end entity control_unit;

architecture behavior of control_unit is
    signal PSR: std_logic_vector(31 downto 0);  -- Processor State Register
begin
    process (CLK, RST)
    begin
        if RST = '1' then
            PSR <= (others => '0');
        elsif rising_edge(CLK) then
            if WE = '1' then
                PSR <= DATAIN;
            end if;
        end if;
    end process;

    DATAOUT <= PSR;

end architecture behavior;
