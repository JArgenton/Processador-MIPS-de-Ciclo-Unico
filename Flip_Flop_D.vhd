library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Flip_Flop_D is
    Port (
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        WRITE_ENABLE : in STD_LOGIC;
        D : in STD_LOGIC;
        Q_out : out STD_LOGIC
    );
end Flip_Flop_D;

architecture Behavioral of Flip_Flop_D is
	-- unico jeito que eu consegui fzr isso funcionar em VHDL 
	-- tentei eliminar todos os if, mas para o clock nn teve jeito
	-- funcionamento: flip flop D padrao com Wr enable:
	-- D_latch escreve no ffp quando a entrada é 1
	-- o operador or em Q_internal é para o caso onde a entrada e´0
	-- poderiamos resumir tudo e remover Q_internal, mas achei a leitura melhor assim
	-- nao achei que iria usar, mas por padrao coloquei um outro if para reset

    signal Q_internal : STD_LOGIC := '0';
    signal D_latch : STD_LOGIC;
begin

    D_latch <= D and WRITE_ENABLE;

    process(CLK, RESET)
    begin
        if RESET = '1' then
		  
            Q_internal <= '0';
				
        elsif rising_edge(CLK) then
		  
            Q_internal <= D_latch or (not WRITE_ENABLE and Q_internal);
				
        end if;
    end process;

    Q_out <= Q_internal;

end Behavioral;
