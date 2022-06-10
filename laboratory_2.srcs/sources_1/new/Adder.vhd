

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Adder is

        Generic (La: natural := 8;
                 Lb: natural := 8;
                 Lo: natural := 10);
        
        Port    (
                 dataA: in  std_logic_vector(La - 1 downto 0);
                 dataB: in  std_logic_vector(Lb - 1 downto 0);
                 Add  : out std_logic_vector(Lo - 1 downto 0));
end Adder;

architecture Behavioral of Adder is

signal int_add: unsigned(Lo - 1 downto 0) := (others => '0');
signal dA: unsigned (La - 1 downto 0) ;
signal dB: unsigned (Lb - 1 downto 0);
signal fuller: unsigned((Lo-Lb)-1 downto 0) := (others => '0');
begin

--int_add <= (fuller & dA) +(fuller & dB);
process(dataA,dataB)
begin
dA <= unsigned(dataA);
dB <= unsigned (dataB);
end process;

int_add <= resize(dA,int_add'length) + resize(dB,int_add'length);

Add <= std_logic_vector(int_add);
end Behavioral;
