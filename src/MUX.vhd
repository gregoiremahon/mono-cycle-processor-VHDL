-- __  __                                   _                                                     
--|  \/  |                                 | |                                                    
--| \  / | ___  _ __   ___   ___ _   _  ___| | ___   _ __  _ __ ___   ___ ___  ___ ___  ___  _ __ 
--| |\/| |/ _ \| '_ \ / _ \ / __| | | |/ __| |/ _ \ | '_ \| '__/ _ \ / __/ _ \/ __/ __|/ _ \| '__|
--| |  | | (_) | | | | (_) | (__| |_| | (__| |  __/ | |_) | | | (_) | (_|  __/\__ \__ \ (_) | |   
--|_|  |_|\___/|_| |_|\___/ \___|\__, |\___|_|\___| | .__/|_|  \___/ \___\___||___/___/\___/|_|   
--                                __/ |             | |                                           
--         

-- *******************************************************************************
-- Entity Name: multiplexeur
-- Description: This entity represents a multiplexer. 
-- It takes two N-bit input bit vectors (A, B), where N is a generic positive integer defaulting to 32, 
-- and a single-bit input (COM).
-- Depending on the value of COM, it passes one of the inputs to the output S.
-- If COM = '0', then A is passed to S.
-- If COM = '1', then B is passed to S.
-- Authors: MAHON and LELONG
-- *******************************************************************************

Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity multiplexeur is
    generic(N:positive :=32);
    Port(	
        A,B : in std_logic_vector(N-1 downto 0);
	    COM : in std_logic;
	    S : out std_logic_vector(N-1 downto 0));
end entity;

architecture arch_multiplexeur of multiplexeur is
begin
    S<=A when COM='0' 
        else B;
        
end architecture;