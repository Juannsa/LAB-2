

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Blinker is
     Port ( 
           Do:     in  std_logic;
           clk: in std_logic;
           Stop:   in  std_logic;
           lblink: out std_logic);
end Blinker;

architecture Behavioral of Blinker is
constant act_v: std_logic:='1';
signal intblink: std_logic:= '0';
begin

    
    
    process(clk)
    begin
    if(rising_edge(clk))then
    
    if (stop = '1')then
       intblink <= '0';
    elsif(Do= act_v) then
    intblink <= not intblink;
   
    end if;
  end if;
    end process;
lblink <= intblink;
end Behavioral;
