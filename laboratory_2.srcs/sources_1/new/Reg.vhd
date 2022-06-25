library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity Reg is
      generic (Do: natural := 8;
               Qo: natural := 9);
      Port    (
               D: in std_logic_vector(Do -1 downto 0);
               clk,oe: in std_logic;
               Q: out std_logic_vector(Qo -1 downto 0));
               
end Reg;

architecture Behavioral of Reg is

signal qin,qold: std_logic_vector(Qo -1 downto 0);
signal Din: unsigned(Qo -1 downto 0);
signal Dlp: unsigned (Do -1 downto 0);
begin
Dlp <= unsigned (D);
Din <= resize(Dlp,Din'length);
process(clk)
begin
        if(rising_edge(clk)) then
                qold <= qin;
                qin <= std_logic_vector(Din);
        end if;
        
end process;

q <= qin when (oe = '1'); 

end Behavioral;
