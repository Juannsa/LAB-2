
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity TrueValues_ROM is
     Generic (data_length: natural := 10;
              addr_length: natural := 3);
              
     Port    ( 
              clk:      in  std_logic;
              address:  in  std_logic_vector (addr_length -1 downto 0);
              data_out: out std_logic_vector (data_length -1 downto 0));
end TrueValues_ROM;

architecture Behavioral of TrueValues_ROM is

constant mem_size : natural := 2**addr_length;

type mem_type is array (7 downto 0) of
                       std_logic_vector(9 downto 0);

constant mem: mem_type :=
             (0 => "0000000011", 1=>"0000010010",2=>"0000010101",3=>"0000001110",4=>"0000100000",
             5=> "0000000101", 6=> "0000011001", 7=>"1011111100");


begin

    rom: process (clk)
    begin
    
        if (rising_edge(clk)) then
                data_out <= mem (to_integer(unsigned(address)));
        end if;
    end process rom;

end Behavioral;
