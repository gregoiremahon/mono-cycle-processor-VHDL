-- __  __                                   _                                                     
--|  \/  |                                 | |                                                    
--| \  / | ___  _ __   ___   ___ _   _  ___| | ___   _ __  _ __ ___   ___ ___  ___ ___  ___  _ __ 
--| |\/| |/ _ \| '_ \ / _ \ / __| | | |/ __| |/ _ \ | '_ \| '__/ _ \ / __/ _ \/ __/ __|/ _ \| '__|
--| |  | | (_) | | | | (_) | (__| |_| | (__| |  __/ | |_) | | | (_) | (_|  __/\__ \__ \ (_) | |   
--|_|  |_|\___/|_| |_|\___/ \___|\__, |\___|_|\___| | .__/|_|  \___/ \___\___||___/___/\___/|_|   
--                                __/ |             | |                                           
--         

-- *******************************************************************************
-- Entity Name: ual
-- Description: This entity represents an Arithmetic Logic Unit (ALU). 
-- It takes two 32-bit input bit vectors (a, b) 
-- and a 2-bit input bit vector (op). Depending on the value of op, it performs 
-- an operation on a and b and passes the result to the output s.
-- If op = "00", then the sum of a and b is passed to s.
-- If op = "01", then b is passed to s.
-- If op = "10", then the difference of a and b is passed to s.
-- If op = "11", then a is passed to s.
-- In the case where op is some other value, no operation is defined.
-- The n output is set to '1' if the result is negative, and '0' otherwise.
-- Authors: MAHON and LELONG
-- *******************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ual is
    port (
        op : in std_logic_vector(1 downto 0);
        a, b : in std_logic_vector(31 downto 0);
        s : out std_logic_vector(31 downto 0);
        n : out std_logic
    );
end entity ual;

architecture behavior of ual is
begin
    process (op, a, b)
        variable temp : signed(31 downto 0);
        variable result : std_logic_vector(31 downto 0);
    begin
        case op is
            when "00" =>
                temp := signed(a) + signed(b);
                result := std_logic_vector(temp);
            when "01" =>
                result := b;
            when "10" =>
                temp := signed(a) - signed(b);
                result := std_logic_vector(temp);
            when "11" =>
                result := a;
	    when others =>
            	-- operation is not defined
            	null;
        end case;
        
        s <= result;
        
        if signed(result) < 0 then
            n <= '1';
        else
            n <= '0';
        end if;
    end process;
end architecture behavior;