
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity I_ROM is
     Generic (data_length: natural := 8;
              addr_length: natural := 3);
              
     Port    ( 
              clk:      in  std_logic;
              address:  in  std_logic_vector (addr_length -1 downto 0);
              data_out: out std_logic_vector (data_length -1 downto 0));
end I_ROM;

architecture Behavioral of I_ROM is

constant mem_size : natural := 2**addr_length;

type mem_type is array (mem_size -1 downto 0) of
                       std_logic_vector(data_length -1 downto 0);

constant mem: mem_type :=
                (0 => x"01",1=>x"05",2=>x"0A",3=>x"02",4=>x"0F",
                5=> x"00", 6=> x"05", 7=>x"FF");


begin

    rom: process (clk)
    begin
    
        if (rising_edge(clk)) then
                data_out <= mem (to_integer(unsigned(address)));
        end if;
    end process rom;

end Behavioral;
