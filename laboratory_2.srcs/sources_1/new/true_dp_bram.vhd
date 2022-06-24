-- -------------------------------------------------------------------- -- 
-- 								C7 Technology                           --   
-- -------------------------------------------------------------------- -- 
-- $Id:  $ 
-- NOTE : Log history is at end of file
-- -------------------------------------------------------------------- -- 
-- VHDL Code Name    : true_dp_bram_v1.vhd
-- Date Created      : 11/06/19
-- Author            : CAS 
-- Project           : Tutorial
-- -------------------------------------------------------------------- -- 
-- Description : 
-- * Read-during-write behavior 
-- * Wrtie Enable and Read Enable for ports A & B
-- * Independent clocks for port A and port B
-- * Important: During initialization output data is undefined 
--              until first write
-- -------------------------------------------------------------------- -- 

-- -------------------------------------------------------------------- --
-- Library Declarations
-- -------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- --------------------------------------------------------------------- -- 
-- Entity Declaration 
-- --------------------------------------------------------------------- -- 
entity true_dp_bram is

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
end true_dp_bram;

-- --------------------------------------------------------------------- -- 
-- Architecture Declaration 
-- --------------------------------------------------------------------- -- 

architecture rtl of true_dp_bram is

	-- Type declaration for building a 2-D array type for the RAM
	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;
	-- Declare the RAM 
	signal bram,bramb: memory_t;


-- --------------------------------------------------------------------- -- 
-- Memory functionality description
-- --------------------------------------------------------------------- --
begin
-- Port A
porta_pr: process(clk_a)
  begin
	if(rising_edge(clk_a)) then 
        if(en_a = '1') then 
		    if(we_a = '1') then
                bram(to_integer(unsigned(addr_a))) <= data_a;
                q_a <= data_a;
		    end if;
			q_a <= bram(to_integer(unsigned(addr_a)));
        end if;
	end if;
  end process porta_pr;

--Port B 
portb_pr: process(clk_b)
  begin
	if(rising_edge(clk_b)) then 
        if(en_b='1') then 
            if(we_b = '1') then
                bramb(to_integer(unsigned(addr_b))) <= data_b;
                q_b <= data_b;
            end if;
        	q_b <= bramb(to_integer(unsigned(addr_b)));
        end if;
    end if;
  end process portb_pr;
end rtl;
-- --------------------------------------------------------------------- -- 
-- 
-- --------------------------------------------------------------------- --