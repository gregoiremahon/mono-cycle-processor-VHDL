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
