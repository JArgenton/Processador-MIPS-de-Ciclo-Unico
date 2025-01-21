library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity somador_8bits is
    port (
        A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);
        Ci : in std_logic;                   
        Cout : out std_logic;                
        S : out std_logic_vector(7 downto 0) 
    );
end somador_8bits;

architecture behavioral of somador_8bits is
    signal C : std_logic_vector(7 downto 0);
begin 

    SomaBit0: entity work.soma_bit
        port map (
            inputs => (A(0), B(0), Ci),
            S => S(0),
            Cout => C(0)
        );

    gen_soma: for index in 1 to 7 generate
        SomaBit: entity work.soma_bit
            port map (
                inputs => (A(index), B(index), C(index-1)),
                S => S(index),
                Cout => C(index)
            );
    end generate gen_soma; --temos que usar o generate para criar obj dinamicamente
									--daria só para ter copiado mais 7x a soma bit a bit, mas tava sem vontade pra isso K.

    Cout <= C(7);

end behavioral;
