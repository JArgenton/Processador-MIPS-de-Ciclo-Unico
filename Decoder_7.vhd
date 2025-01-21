library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_0_to_7 is
    port(
        inp : in std_logic_vector (2 downto 0);
        outp : out std_logic_vector (7 downto 0)
    );
end decoder_0_to_7;

architecture Behavioral of decoder_0_to_7 is
    signal aux : std_logic_vector (7 downto 0);
    signal A, B, C : std_logic;
begin
    A <= inp(2);
    B <= inp(1);
    C <= inp(0);
    
    aux(0) <= (not A) and (not B) and (not C);
    aux(1) <= (not A) and (not B) and (C);
    aux(2) <= (not A) and (B) and (not C);
    aux(3) <= (not A) and (B) and (C);
    aux(4) <= (A) and (not B) and (not C);
    aux(5) <= (A) and (not B) and (C);
    aux(6) <= (A) and (B) and (not C);
    aux(7) <= (A) and (B) and (C);
    
    outp <= aux;
end Behavioral;
