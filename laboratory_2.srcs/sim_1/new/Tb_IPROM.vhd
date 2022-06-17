library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Tb_IPROM is
--  Port ( );
end Tb_IPROM;

architecture Behavioral of Tb_IPROM is

COMPONENT IP_Core_ROM
  PORT (
    a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    clk : IN STD_LOGIC;
    qspo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

signal tbclk: std_logic;
signal tbA: std_logic_vector(3 downto 0);
signal tbO: std_logic_vector(7 downto 0);

constant clk_period: time := 10 ms;
begin

 UUT: IP_Core_ROM port map (
  a => tbA,clk =>tbclk, qspo => tbO);


  clkP:process
  begin
  tbclk <= '1';
  wait for clk_period/2;
  tbclk <= '0';
  wait for clk_period/2;
  end process;
  
  
  da:process
  begin
  wait until falling_edge(tbclk);
  tbA <= "0000";
  wait for clk_period*3;
  wait until falling_edge(tbclk);
  tbA <= "0111";
   wait for clk_period*3;
   wait until falling_edge(tbclk);
  tbA <= "0010";
   wait for clk_period*3;
    wait until falling_edge(tbclk);
   tbA <= "0011";
   wait for clk_period*3;
   wait;
   end process;
   
end Behavioral;
