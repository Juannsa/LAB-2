library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity TB_I_ROM is
--  Port ( );
end TB_I_ROM;

architecture Behavioral of TB_I_ROM is

component I_ROM is
    Generic (data_length: natural := 8;
              addr_length: natural := 3);
              
     Port    ( 
              clk:      in  std_logic;
              address:  in  std_logic_vector (addr_length -1 downto 0);
              data_out: out std_logic_vector (data_length -1 downto 0));
end component;


signal tb_clk: std_logic;
signal tb_address: std_logic_vector(2 downto 0);
signal tb_dataout: std_logic_vector(7 downto 0);

constant clk_period: time := 10 ms;
begin

    UUT: I_ROM port map (clk => tb_clk, address =>tb_address,data_out =>tb_dataout);
    
    clkP: process
    begin
    tb_clk <= '1';
    wait for clk_period/2;
    tb_clk <= '0';
    wait for clk_period/2;
    end process;
    
    data: process
    begin
    tb_address <= "111";
    wait for clk_period*4;
    tb_address <= "011";
    wait for clk_period;
    tb_address <= "000";
    wait for clk_period;
    tb_address <= "100";
    wait;
    end process;
         

end Behavioral;
