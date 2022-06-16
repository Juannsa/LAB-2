

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Tb_Reg is
--  Port ( );
end Tb_Reg;

architecture Behavioral of Tb_Reg is

    component Reg is 
        
      generic (Do: natural := 8;
               Qo: natural := 9);
      Port    (
               D: in std_logic_vector(Do -1 downto 0);
               clk,oe: in std_logic;
               Q: out std_logic_vector(Qo -1 downto 0));
     end component;

signal tbclk,tboe: std_logic;
signal tbD: std_logic_vector(7 downto 0);
signal tb1D: std_logic_vector(7 downto 0);

signal tbQ: std_logic_vector(8 downto 0);
signal tb1q: std_logic_vector(9 downto 0);

constant clk_period: time := 10 ms;
begin

UUT1: Reg generic map (Do => 8,Qo => 10)
          port map (d=>tb1d,q=>tb1q,clk=>tbclk,oe=>tboe);
          
UUT2: Reg port map (d=> tbD,q=>tbq,clk =>tbclk,oe=>tboe);
        
      clkP:process
           begin
           tbclk <= '0';
           wait for clk_period/2;
           tbclk <= '1';
           wait for clk_period/2;
           end process;
           
       data:process
            begin
            tb1d <= "00000001";
            tbd <= "00000100";
            wait for 50 ms;
            tboe <= '1';
            wait for 40 ms;
            tbd <= "11111111";
            wait for clk_period*3;
            tb1d <= "00001111";
            wait;
            end process data;
end Behavioral;
