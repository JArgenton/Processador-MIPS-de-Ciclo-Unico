library ieee;
use ieee.std_logic_1164.all;

entity SLT is
    port (
        A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);
        A_lt_B : out std_logic_vector(7 downto 0) 
    );
end SLT;

architecture behavioral of SLT is
    signal eq : std_logic_vector(7 downto 0); --igualdade bit a bit
    signal lt : std_logic_vector(7 downto 0); -- A < B em cada bit
begin

    eq(7) <= not(A(7) xor B(7)); -- A igualdade no bit mais significativo
    lt(7) <= (not A(7) and B(7)); -- A < B no bit mais significativo
	 
    eq(6) <= not(A(6) xor B(6)) and eq(6); -- os numeros permanecem iguais se A6, B6 e eq7 forem iguais
    lt(6) <= (not A(6) and B(6) and eq(7)) or lt(7); -- A continua menor que B se A6 < B6, e se A7 == B7 ou A7 < B7

    eq(5) <= not(A(5) xor B(5)) and eq(6); -- aqui se eq6 é verdadeiro, entao as pos 6 e 7 sao iguais, logo se A5 == b5, os numeros cont iguais
    lt(5) <= (not A(5) and B(5) and eq(6)) or lt(6); -- a mesma logica da anterior
	 
    eq(4) <= not(A(4) xor B(4)) and eq(5);
    lt(4) <= (not A(4) and B(4) and eq(5)) or lt(5);
	 
	  eq(3) <= not(A(3) xor B(3)) and eq(4);
    lt(3) <= (not A(3) and B(3) and eq(4)) or lt(4);
	 
	  eq(2) <= not(A(2) xor B(2)) and eq(3);
    lt(2) <= (not A(2) and B(2) and eq(3)) or lt(3);
	 
	  eq(1) <= not(A(1) xor B(1)) and eq(2);
    lt(1) <= (not A(1) and B(1) and eq(2)) or lt(2);
	 
	  eq(0) <= not(A(0) xor B(0)) and eq(1);
    lt(0) <= (not A(0) and B(0) and eq(1)) or lt(1);
	 
    -- Resultado final: A < B
	 
    A_lt_B <= (7 downto 1 => '0') & lt(0);
	 
end behavioral;
