library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8 is
port(
  d0     : in  std_logic_vector(7 downto 0);
  d1     : in  std_logic_vector(7 downto 0);
  d2     : in  std_logic_vector(7 downto 0);
  d3     : in  std_logic_vector(7 downto 0);
  d4     : in  std_logic_vector(7 downto 0);
  d5     : in  std_logic_vector(7 downto 0);
  d6     : in  std_logic_vector(7 downto 0);
  d7     : in  std_logic_vector(7 downto 0);
  addres      : in  std_logic_vector(2 downto 0);  
  mux      : out std_logic_vector(7 downto 0)
);
end mux8;
architecture rtl of mux8 is
 --cara, tava com real dificuldade de implementar isso e pesquisei online
 --isso saiu desse site aq: https://surf-vhdl.com/how-to-implement-digital-mux-in-vhdl/#:~:text=The%20digital%20MUX%20is%20one
 --é LINDO.
type t_array_mux is array (0 to 7) of std_logic_vector(7 downto 0);
signal array_mux  : t_array_mux;

begin

  array_mux(0)  <= d0;
  array_mux(1)  <= d1;
  array_mux(2)  <= d2;
  array_mux(3)  <= d3;
  array_mux(4)  <= d4;
  array_mux(5)  <= d5;
  array_mux(6)  <= d6;
  array_mux(7)  <= d7;

  mux <= array_mux(to_integer(unsigned(addres)));

end rtl;
