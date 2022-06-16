library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register is
      generic (Do: natural := 8;
               Qo: natural := 9);
      Port    (
               D: in std_logic_vector(Do -1 downto 0);
               clk,oe: in std_logic;
               Q: out std_logic_vector(Qo -1 downto 0));
               
end Register;

architecture Behavioral of Register is

begin


end Behavioral;
