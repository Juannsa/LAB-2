library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity FF_D is
        Port (
            clk,rst: in std_logic;
            D: in std_logic_vector(7 downto 0);
            Q: out std_logic_vector(7 downto 0));
end FF_D;

architecture Behavioral of FF_D is

--signal intD: std_logic;
constant rst_act_value: std_logic:= '1';
begin

process(clk)
begin
    if (rst = rst_act_value) then
        Q <= (others => '0');
    elsif (rising_edge(clk)) then
       
        Q <= D;
    end if;
end process;


end Behavioral;
