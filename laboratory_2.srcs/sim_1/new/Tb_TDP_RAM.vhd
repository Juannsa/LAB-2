library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity Tb_TDP_RAM is
--  Port ( );
end Tb_TDP_RAM;

architecture Behavioral of Tb_TDP_RAM is

Component true_dp_bram is
    
    generic 
	(
		DATA_WIDTH : natural := 10;
		ADDR_WIDTH : natural := 4
	);

	port 
	(
        -- Port A --
		clk_a	: in std_logic;
        addr_a	: in std_logic_vector(ADDR_WIDTH - 1 downto 0);
		we_a	: in std_logic;
        en_a	: in std_logic;
		data_a	: in std_logic_vector((DATA_WIDTH-1) downto 0);
		q_a		: out std_logic_vector((DATA_WIDTH -1) downto 0);
		
		-- Port B -- 
        clk_b	: in std_logic;
        addr_b	: in std_logic_vector(ADDR_WIDTH - 1 downto 0);
        we_b	: in std_logic;
        en_b	: in std_logic;		
        data_b	: in std_logic_vector((DATA_WIDTH-1) downto 0);		
		q_b		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
	
end component;

signal tbclk,tbwea,tbweb,tbena,tbenb: std_logic:= '0';
signal tbaddra,tbaddrb: std_logic_vector(3 downto 0);
signal tbdataa,tbdatab,tbqa,tbqb: std_logic_vector(9 downto 0);
constant clk_period: time := 10 ms;

begin

    UUT: true_dp_bram port map (clk_a => tbclk,clk_b => tbclk,we_a =>tbwea,
                                en_a => tbena,addr_a => tbaddra,data_a =>tbdataa,
                                q_a =>tbqa,we_b =>tbweb,
                                en_b => tbenb,addr_b => tbaddrb,data_b =>tbdatab,
                                q_b =>tbqb);

    clkP: process
    begin
     tbclk <= '1';
     wait for clk_period/2;
     tbclk <= '0';
     wait for clk_period/2;
    end process clkP;
    
    dataStimulus: process
    begin
    
    --grabar un dato en port A
    tbena <= '1';
    tbwea <= '0';
    wait for clk_period;
    tbaddra <= "0101";
    wait for clk_period;
    tbdataa <= "1011111101";
    wait for clk_period*4;
    --Leo el dato grabado
    tbwea <= '1';
    wait for clk_period *2;
    tbwea <= '0';
    tbdataa <= "0000001111";
    tbaddra <= "0110";
    wait for clk_period;
    tbwea <= '1';
    wait for clk_period;
    tbwea <= '0';
    wait for clk_period;
    tbdataa <= "0000000001";
    tbaddra <= "0111";
    wait for clk_period;
    tbwea <= '1';
    wait for clk_period*2;
    tbwea <= '0';
    wait for clk_period;
     tbaddra <= "0101";
     wait for clk_period*2;
       tbaddra <= "0110";
   wait for clk_period*2;
    
    
    wait;
    

    
    end process;
end Behavioral;
