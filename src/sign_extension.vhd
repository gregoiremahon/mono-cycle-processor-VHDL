-- __  __                                   _                                                     
--|  \/  |                                 | |                                                    
--| \  / | ___  _ __   ___   ___ _   _  ___| | ___   _ __  _ __ ___   ___ ___  ___ ___  ___  _ __ 
--| |\/| |/ _ \| '_ \ / _ \ / __| | | |/ __| |/ _ \ | '_ \| '__/ _ \ / __/ _ \/ __/ __|/ _ \| '__|
--| |  | | (_) | | | | (_) | (__| |_| | (__| |  __/ | |_) | | | (_) | (_|  __/\__ \__ \ (_) | |   
--|_|  |_|\___/|_| |_|\___/ \___|\__, |\___|_|\___| | .__/|_|  \___/ \___\___||___/___/\___/|_|   
--                                __/ |             | |                                           
--         

-- *******************************************************************************
-- Entity Name: sign_extension
-- Description: This entity represents a sign extension unit. 
-- It takes an N-bit input bit vector (E), where N is a generic positive integer defaulting to 16.
-- The sign extension unit extends the sign of the input E to a 32-bit output S.
-- If the most significant bit of E is '1' (representing a negative number), 
-- then S is assigned the value of E with 16 leading '1' bits.
-- If the most significant bit of E is '0' (representing a positive number), 
-- then S is assigned the value of E with 16 leading '0' bits.
-- Authors: MAHON and LELONG
-- *******************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extension is
    generic (N: positive := 16);
    port (
        E: in std_logic_vector(N-1 downto 0);
        S: out std_logic_vector(31 downto 0)
    );
end entity sign_extension;

architecture arch_sign_extension of sign_extension is
begin
    -- Process triggered by changes in input E
    process(E)
    begin
        -- Check the sign bit (most significant bit) of the input E
        if E(N-1) = '1' then
            -- If the sign bit is 1 (negative number), extend the sign by concatenating
            -- 16 leading '1' bits to the input E, then convert the result to a signed
            -- value and assign it to the output S
            S <= std_logic_vector(signed("1111111111111111" & E));
        else
            -- If the sign bit is 0 (positive number), extend the sign by concatenating
            -- 16 leading '0' bits to the input E, then convert the result to a signed
            -- value and assign it to the output S
            S <= std_logic_vector(signed("0000000000000000" & E));
        end if;
    end process;
end architecture arch_sign_extension;
