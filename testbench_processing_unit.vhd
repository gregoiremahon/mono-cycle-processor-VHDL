Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity TB_ALU_and_registers is
end entity;

architecture arch_TB_ALU_and_registers of TB_ALU_and_registers is
signal 	RESET : std_logic;
signal  WE,CLK : std_logic :='0';
signal	OP : std_logic_vector(1 downto 0);
signal	RW,RA,RB : std_logic_vector(3 downto 0);
signal  busW : std_logic_vector(31 downto 0);
begin
--INIT:
RESET<='0';
CLK<='1' after 100 ps when CLK='0' else '0' after 100 ps when CLK='1';

--	Y=A	Y=A+B		 	Y=A+B			Y=A-B			Y=A-B
OP<=	"11",	"00" after 5 ns,	"00" after 10 ns,	"10" after 15 ns,	"10" after 20 ns;
--	A=R(15)	A=R(1)			A=R(1)			A=R(1)			A=R(7)
RA<=	"1111",	"0001" after 5 ns,	"0001" after 10 ns,	"0001" after 15 ns,	"0111" after 20 ns;
--	B=R(0)	B=R(15)			B=R(15)			B=R(15)			B=R(15)
RB<=	"0000",	"1111" after 5 ns,	"1111" after 10 ns,	"1111" after 15 ns,	"1111" after 20 ns;
--	W=R(1)	W=R(1)			W=R(2)			W=R(3)			W=R(5)
RW<=	"0001",	"0001" after 5 ns,	"0010" after 10 ns,	"0011" after 15 ns,	"0101" after 20 ns;


WE<='1' after 5 ns when WE='0' else '0' after 150 ps when WE='1';

E0:Entity work.Processing_Unit port map(WE,RESET,CLK,OP,RW,RA,RB,busW);

end architecture;