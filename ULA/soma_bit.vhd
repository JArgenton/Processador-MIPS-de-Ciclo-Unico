Library IEEE;
use ieee.std_logic_1164.all;

entity soma_bit is 
port(
        inputs : in std_logic_vector(2 downto 0); -- A(2), B(1), Ci(0)
        S : out std_logic;
        Cout : out std_logic
    );
end soma_bit;
	 
architecture Soma of soma_bit is 

 signal A, B, Ci : std_logic; --declara vars para colocar no vetor, sao apenas auxiliares 
 --signal nao representa entrada nem saida, mas apenas um transportador de valores para facilitar compreencao
 
begin
    A <= inputs(2);
    B <= inputs(1);
    Ci <= inputs(0);
	 
	 S <= (A and not B and not Ci) or 
         (not A and B and not Ci) or 
         (not A and not B and Ci) or 
         (A and B and Ci);
	Cout <= (A and B) or (A and Ci) or (B and Ci);
	
	end Soma;