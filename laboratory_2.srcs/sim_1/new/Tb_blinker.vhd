
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tb_blinker is
--  Port ( );
end Tb_blinker;

architecture Behavioral of Tb_blinker is

    component Blinker is
         Port ( 
           Do:     in  std_logic;
            clk: in std_logic;
           Stop:   in  std_logic;
           lblink: out std_logic);
    end component;
    
signal tbdo,tbstop,tblblink,tbclk: std_logic;
constant clk_period: time:= 10 ms;
begin

    UUT: Blinker port map (Do=>tbdo,Stop=>tbstop,lblink=>tblblink,clk=>tbclk);

    clkp:process
    begin
    tbclk<= '1';
    wait for clk_period/2;
    tbclk <= '0';
    wait for clk_period/2;
    end process clkp;
    
    process
    begin
    tbdo <= '0';
    tbstop <= '1';
    wait for 20 ms;
    tbstop <= '0';
    wait for 20 ms;
    tbdo <= '1';
    tbstop <= '0';
    wait for 20 ms;
    tbdo <= '1';
    wait for 50 ms;
    tbstop <= '1';
    wait for  15 ms;
    tbstop <= '0';
    wait;
    end process;

end Behavioral;
