-- __  __                                   _                                                     
--|  \/  |                                 | |                                                    
--| \  / | ___  _ __   ___   ___ _   _  ___| | ___   _ __  _ __ ___   ___ ___  ___ ___  ___  _ __ 
--| |\/| |/ _ \| '_ \ / _ \ / __| | | |/ __| |/ _ \ | '_ \| '__/ _ \ / __/ _ \/ __/ __|/ _ \| '__|
--| |  | | (_) | | | | (_) | (__| |_| | (__| |  __/ | |_) | | | (_) | (_|  __/\__ \__ \ (_) | |   
--|_|  |_|\___/|_| |_|\___/ \___|\__, |\___|_|\___| | .__/|_|  \___/ \___\___||___/___/\___/|_|   
--                                __/ |             | |                                           
--         

-- *******************************************************************************
-- Entity Name: banc_registres
-- Description: This entity represents a register bank. 
-- It takes a 32-bit input bit vector (w) for writing, 
-- three 4-bit address input bit vectors (ra, rb, rw), 
-- a clock signal (clk), a reset signal (rst), and a write enable signal (we).
-- Depending on the value of we, it performs a write operation to the register bank.
-- If we = '1', then the value of w is written to the register at the address specified by rw.
-- The values of the registers at the addresses specified by ra and rb are always output on a and b, respectively.
-- If rst = '1', then the register bank is reset to its initial state, 
-- with all registers set to 0 except for the last one (index 15) which is set to 0x00000030.
-- Authors: MAHON and LELONG
-- *******************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banc_registres is
    port (
        clk, rst: in std_logic;
        w: in std_logic_vector(31 downto 0); -- writing input
        ra, rb, rw: in std_logic_vector(3 downto 0); -- adress
        we: in std_logic; -- writing : '1', else : '0'
        a, b: out std_logic_vector(31 downto 0) -- outputs, reading a and b values from registers
    );
end entity banc_registres;

architecture behavior of banc_registres is

    -- init of the registers function [given by UPMC project subject]
    type table is array (15 downto 0) of std_logic_vector(31 downto 0);
    function init_banc return table is
        variable result : table;
    begin
        for i in result'range loop
            result(i) := (others => '0');
        end loop;

        result(15) := x"00000030";

        return result;
    end init_banc;

    -- Declaration and initialization of a 16x32 bits register file named Banc
    -- The register file is declared as a table of std_logic_vectors
    -- The initialization of the register file is done using the init_banc function, which sets all registers to 0 except for the last one (index 15) which is set to 0x00000030
    signal Banc : table := init_banc;


begin
    process (clk, rst)
    begin
		-- reset the register file using the function below when reset is HIGH
    if rst = '1' then 
    	banc <= init_banc; 
    elsif rising_edge(clk) then
        if we = '1' then
        	banc(to_integer(unsigned(rw))) <= w;
	end if;
    end if;
    end process;
           
    a <= banc(to_integer(unsigned(ra)));
    b <= banc(to_integer(unsigned(rb)));

end architecture behavior;