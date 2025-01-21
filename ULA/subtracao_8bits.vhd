library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity subtrator_8bits is
    port (
        A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0); 
        D : out std_logic_vector(7 downto 0); 
        Bout : out std_logic
    );
end subtrator_8bits;

architecture behavioral of subtrator_8bits is
    signal B_complemento : std_logic_vector(7 downto 0);
    signal carry_out : std_logic;                         
begin
    B_complemento <= NOT B;

    somador_8bits_inst: entity work.somador_8bits
        port map (
            A => A,
            B => B_complemento,
            Ci => '1',
            Cout => carry_out,  -- pelo q eu entendi, é meio inutil
            S => D             
        );

    Bout <= carry_out;

end behavioral;
