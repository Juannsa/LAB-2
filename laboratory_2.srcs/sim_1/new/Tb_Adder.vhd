
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity Tb_Adder is
--  Port ( );
end Tb_Adder;

architecture Behavioral of Tb_Adder is

    component Adder is
        
        Generic (La: natural := 8;
                 Lb: natural := 8;
                 Lo: natural := 9);
        
        Port    (
                 dataA: in  std_logic_vector(La - 1 downto 0);
                 dataB: in  std_logic_vector(Lb - 1 downto 0);
                 Add  : out std_logic_vector(Lo - 1 downto 0));
    end component;

signal tb_da: std_logic_vector(7 downto 0);
signal tb_db: std_logic_vector(7 downto 0);
signal tb_add: std_logic_vector(8 downto 0);

constant clk: time  := 100 ms;

begin

    UUT: Adder port map(dataA => tb_da,dataB=>tb_db,Add=> tb_add);
        process
        begin
        tb_da <= "11111111";
        tb_db <= "11111111";
        wait for 200 ms;
        tb_da <= "00000000";
        tb_db <= "00001111";
        wait for 200 ms;
        tb_da <= "00000000";
        tb_db <= "00000001";
        wait;
        
        end process;



end Behavioral;
