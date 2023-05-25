-- __  __                                   _                                                     
--|  \/  |                                 | |                                                    
--| \  / | ___  _ __   ___   ___ _   _  ___| | ___   _ __  _ __ ___   ___ ___  ___ ___  ___  _ __ 
--| |\/| |/ _ \| '_ \ / _ \ / __| | | |/ __| |/ _ \ | '_ \| '__/ _ \ / __/ _ \/ __/ __|/ _ \| '__|
--| |  | | (_) | | | | (_) | (__| |_| | (__| |  __/ | |_) | | | (_) | (_|  __/\__ \__ \ (_) | |   
--|_|  |_|\___/|_| |_|\___/ \___|\__, |\___|_|\___| | .__/|_|  \___/ \___\___||___/___/\___/|_|   
--                                __/ |             | |                                           
--         

-- *******************************************************************************
-- Entity Name: Processing_Unit
-- Description: This entity represents the processing unit of the mono-cycle processor.
-- It is composed of an Arithmetic Logic Unit (UAL) and a register bank (banc_registres).
-- The UAL performs arithmetic and logical operations based on the operation code (OP) and the inputs A and B.
-- The result is outputted to W and the negative flag N is set if the result is negative.
-- The register bank manages the reading and writing of data to the registers.
-- It takes in the write enable signal (WE), the reset signal (RESET), the clock signal (CLK),
-- the write data (W), and the addresses of the registers to read from (RA and RB) and write to (RW).
-- The data read from the registers are outputted to A and B.
-- Authors: MAHON and LELONG
-- *******************************************************************************

Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Processing_Unit is
port(	WE,RESET,CLK : in std_logic;
	OP : in std_logic_vector(1 downto 0);
	RW,RA,RB : in std_logic_vector(3 downto 0);
	busW : out std_logic_vector(31 downto 0));
end entity;

architecture arch_Processing_Unit of Processing_Unit is
	signal A,B,W : std_logic_vector(31 downto 0);
	signal N : std_logic;
begin
	E0:Entity work.UAL port map(OP, A, B, W, N);
	E1:Entity work.banc_registres port map(CLK, RESET, W, RA, RB, RW, WE, A, B);
	busW <= W;

end architecture;
