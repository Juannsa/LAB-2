
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tb_Comparator is
--  Port ( );
end Tb_Comparator;

architecture Behavioral of Tb_Comparator is

component Comparator is
        Generic (DA: natural :=10;
                 DB: natural :=10;
                 DO: natural :=10);
        Port    (
                 dataA:  in  std_logic_vector(DA -1 downto 0);
                 dataB:  in  std_logic_vector(DB -1 downto 0);
                 ctrl:   in  std_logic;
                 rst:    in  std_logic;
                 led:    out std_logic);
                 
end component;

signal tbDA,tbDB: std_logic_vector(9 downto 0);
signal tbctrl,tbrst,tbled: std_logic;

begin

    UUT: Comparator port map (dataA => tbDA, dataB =>tbDB,
                              ctrl=>tbctrl,rst=>tbrst,led=>tbled);

       dS: process
       begin
       tbrst <= '1';
       wait for 40 ms;
       tbDA <= "0000000000";
       tbDB <= "0000000000";
       tbrst <= '0';
       wait for 20 ms;
      tbctrl <= '1';
       wait for 30 ms;
       tbctrl <= '0';
       tbDA <= "0000000001";
       tbDB <= "0000000010";
       wait for 40 ms;
       tbctrl <= '1';
       wait for 20 ms;
       tbDB <= "0000000011";
       wait for 10 ms;
       tbctrl <= '0';
       
       wait for 20 ms;
       tbDA <= "0000000011";
       wait for 10 ms;
       tbctrl <= '1';
       wait for 40 ms;
       tbctrl <= '0';
       wait for 10 ms;
       tbDA <= "0000000100";
       wait for 10 ms;
       tbctrl <= '1';
       wait for 20 ms;
       tbDB <= "0000000100";
       wait for 5 ms;
       tbDB <= "0000000101";
       wait for 10 ms;
       tbctrl <= '0';
       wait for 10 ms;
       
       tbDA <= "0000000101";
       wait ;
       end process;



end Behavioral;
