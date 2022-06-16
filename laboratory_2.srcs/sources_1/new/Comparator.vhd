library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Comparator is
        Generic (DA: natural :=10;
                 DB: natural :=10;
                 DO: natural :=10);
        Port    (
                 dataA:  in  std_logic_vector(DA -1 downto 0);
                 dataB:  in  std_logic_vector(DB -1 downto 0);
                 ctrl:   in  std_logic;
                 rst:    in  std_logic;
                 led:    out std_logic);
end Comparator;

architecture Behavioral of Comparator is

signal intA: unsigned (DA -1 downto 0);
signal intB: unsigned (DB -1 downto 0);
signal LintA: unsigned(DO -1 downto 0);
signal LintB: unsigned(DO -1 downto 0);
constant rst_actV: std_logic:= '1';
signal iled: std_logic;
signal equal: std_logic_vector(DO -1 downto 0);

begin
    
    

    intA <= unsigned (dataA);
    intB <= unsigned (dataB);
    LintA <= resize(intA,LintA'length); --permite usarlo para comparar datos de cualquier tamaño
    LintB <= resize (intB,LintB'length); --se da con DO el valor del mayor de los dos.
    
                    
    process(rst,ctrl,LintA,LintB) --ctrl dispara el proceso para comparar.
    begin
    
   if (rst = rst_actV or ctrl = '0') then
      led <= '0';
      
         elsif (ctrl='1') then
        if (LintA = LintB) then
        led <= '0';
    else
       led <= '1';
    end if;
    end if;
    end process;
   
   

end Behavioral;
