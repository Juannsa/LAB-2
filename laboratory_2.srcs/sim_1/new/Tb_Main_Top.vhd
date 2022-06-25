library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Tb_Main_Top is
--  Port ( );
end Tb_Main_Top;

architecture Behavioral of Tb_Main_Top is


component Main_Top is
     Port ( 
            clk: in std_logic;
            rst: in std_logic;
            start: in std_logic;
            stop: in std_logic;
            pulse: out std_logic);
end component;

signal clk,rst,start,stop,pulse: std_logic:= '0';
constant clk_period: time := 10 ms;

begin

UUT: Main_Top port map (clk =>clk,rst=>rst,start=>start,stop=>stop,pulse=>pulse);

clkP:process
begin
clk <= '1';
wait for clk_period/2;
clk <= '0';
wait for clk_period/2;
end process;
        
        Dat:process
        begin
            start <= '0';
            wait for clk_period;
            start <= '1';
            wait for clk_period*20;
            wait;
        end process;



end Behavioral;
