library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ULA is
    port (
        A    : in std_logic_vector(7 downto 0);   -- Operando A
        B    : in std_logic_vector(7 downto 0);   -- Operando B
        Op   : in std_logic_vector(2 downto 0);   -- Seleção da operação (3 bits)
        Y    : buffer  std_logic_vector(7 downto 0);  -- Resultado
        overflow : out std_logic;                -- Flag de overflow
        negative : out std_logic;                -- Flag de valor negativo
        Zero : out std_logic                     -- Flag de zero
    );
end ULA;

architecture behavioral of ULA is
    -- Sinais internos
    signal op_Soma       : std_logic_vector(7 downto 0);
    signal op_Subtracao  : std_logic_vector(7 downto 0);
    signal op_And        : std_logic_vector(7 downto 0);
    signal op_Or         : std_logic_vector(7 downto 0);
    signal op_SLT        : std_logic_vector(7 downto 0);
    signal aux_overflow  : std_logic;
    signal aux_negative  : std_logic;
begin

    --------------------------- SOMADOR ----------------------------------
    somador : entity work.somador_8bits
        port map (
            A => A,
            B => B,
            Ci => '0',
            Cout => aux_overflow,
            S => op_Soma
        );

    --------------------------- SUBTRATOR --------------------------------
    subtrator : entity work.subtrator_8bits
        port map (
            A => A,
            B => B,
            D => op_Subtracao,
            Bout => aux_negative
        );

    --------------------------- OPERAÇÃO AND -----------------------------
    op_And <= A and B;

    --------------------------- OPERAÇÃO OR ------------------------------
    op_Or <= A or B;

    --------------------------- OPERAÇÃO SLT -----------------------------
    slt: entity work.SLT
        port map (
            A => A,
            B => B,
            A_lt_B => op_SLT
        );

    --------------------------- PROCESSO PRINCIPAL -----------------------
    process (Op, op_Soma, op_Subtracao, op_And, op_Or, op_SLT)
    begin
        case Op is
            when "010" =>  -- Soma
                Y <= op_Soma;
                overflow <= aux_overflow;
					 negative <= '0';

            when "110" =>  -- Subtração
                Y <= op_Subtracao;
                negative <= op_Subtracao(7) and not aux_negative; -- NAO SEI SE ISSO FUNCIONA

            when "000" =>  -- AND
                Y <= op_And;
                overflow <= '0';
					 negative <= '0';


            when "001" =>  -- OR
                Y <= op_Or;
                overflow <= '0';
					 negative <= '0';
            when "111" =>  -- SLT
                Y <= op_SLT;
                overflow <= '0';
					 negative <= '0';

            when others =>  -- Caso inválido
                Y <= (others => '0');
                overflow <= '0';
					 negative <= '0';

        end case;
    end process;

    --------------------------- FLAG ZERO --------------------------------
	Zero <= '1' when (Y = "00000000") else '0';

end behavioral;
