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

