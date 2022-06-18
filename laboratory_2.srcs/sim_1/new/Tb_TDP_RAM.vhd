library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Tb_TDP_RAM is
--  Port ( );
end Tb_TDP_RAM;

architecture Behavioral of Tb_TDP_RAM is

Component true_dp_ram is
    
    generic 
	(
		DATA_WIDTH : natural := 10;
		ADDR_WIDTH : natural := 4
	);

	port 
	(
        -- Port A --
		clk_a	: in std_logic;
        addr_a	: in std_logic_vector(2**ADDR_WIDTH - 1 downto 0);
		we_a	: in std_logic;
        en_a	: in std_logic;
		data_a	: in std_logic_vector((DATA_WIDTH-1) downto 0);
		q_a		: out std_logic_vector((DATA_WIDTH -1) downto 0);
		
		-- Port B -- 
        clk_b	: in std_logic;
        addr_b	: in std_logic_vector(2**ADDR_WIDTH - 1 downto 0);
        we_b	: in std_logic;
        en_b	: in std_logic;		
        data_b	: in std_logic_vector((DATA_WIDTH-1) downto 0);		
		q_b		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
	
end component;

signal tbclk,tbwea,tbweb,tbena,tbenb: std_logic;
signal tbaddra,tbaddrb: std_logic_vector(3 downto 0);
signal tbdataa,tbdatab,tbqa,tbqb: std_logic_vector(9 downto 0);


begin


end Behavioral;
