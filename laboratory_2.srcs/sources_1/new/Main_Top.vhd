library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Main_Top is
     Port ( 
            clk: in std_logic;
            rst: in std_logic;
            start: in std_logic;
            stop: in std_logic;
            pulse: out std_logic);
end Main_Top;

architecture Behavioral of Main_Top is

component I_ROM is
        Generic (data_length: natural := 8;
              addr_length: natural := 3);
              
     Port    ( 
              clk:      in  std_logic;
              address:  in  std_logic_vector (addr_length -1 downto 0);
              data_out: out std_logic_vector (data_length -1 downto 0));
end component I_ROM;

COMPONENT IP_Core_ROM
  PORT (
    a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    clk : IN STD_LOGIC;
    qspo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

component Reg is
     generic (Do: natural := 8;
               Qo: natural := 8);
      Port    (
               D: in std_logic_vector(Do -1 downto 0);
               clk,oe: in std_logic;
               Q: out std_logic_vector(Qo -1 downto 0));
end component Reg;

component Adder is
        Generic (La: natural := 8;
                 Lb: natural := 8;
                 Lo: natural := 9);
        
        Port    (
                 dataA: in  std_logic_vector(La - 1 downto 0);
                 dataB: in  std_logic_vector(Lb - 1 downto 0);
                 Add  : out std_logic_vector(Lo - 1 downto 0));
end component Adder;

component true_dp_bram is
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
end component true_dp_bram;

component TrueValues_ROM is
        Generic (data_length: natural := 10;
              addr_length: natural := 3);
              
     Port    ( 
              clk:      in  std_logic;
              address:  in  std_logic_vector (addr_length -1 downto 0);
              data_out: out std_logic_vector (data_length -1 downto 0));
end component TrueValues_ROM;

component Comparator is
        Generic (DA: natural :=10;
                 DB: natural :=10;
                 DO: natural :=10);
        Port    (
                 dataA:  in  std_logic_vector(DA -1 downto 0);
                 dataB:  in  std_logic_vector(DB -1 downto 0);
                 ctrl:   in  std_logic;
                 rst:    in  std_logic;
                 led:    out std_logic);
end component Comparator;

component Blinker
    Port ( 
           Do:     in  std_logic;
           clk: in std_logic;
           Stop:   in  std_logic;
           lblink: out std_logic);
end component Blinker;

component FF_D is
     Port (
            clk,rst: in std_logic;
            D: in std_logic_vector(7 downto 0);
            Q: out std_logic_vector(7 downto 0));
end component FF_D;
-- signals for ROM, Reg and ADDER.
signal ROM1toReg1: std_logic_vector(7 downto 0);
signal ROM2toReg2: std_logic_vector(7 downto 0);
signal ROM3toReg3: std_logic_vector(7 downto 0);
signal int_addrROM1: std_logic_vector(2 downto 0);
signal int_addr_IPROM: std_logic_vector(3 downto 0);
signal oe1,oe2,oe3,oe4,oe5,oe6,oe7: std_logic := '0';
signal add1,add2,add3: std_logic_vector(7 downto 0);
signal addout1: std_logic_vector(8 downto 0);
signal addout2: std_logic_vector(9 downto 0);
signal Final_Add: std_logic_vector (9 downto 0);

--signals for tdp bram
signal addT: std_logic_vector(3 downto 0);
signal wea,web,ena,enb: std_logic;
signal outA,outB: std_logic_vector(9 downto 0);
signal REGA,REGB: std_logic_vector(9 downto 0);

--signals true values
signal true_addr: std_logic_vector(2 downto 0);
signal true_data: std_logic_vector(9 downto 0);
signal tmp: std_logic_vector(9 downto 0);

--signals comparator
signal ctrl,led: std_logic;
signal midFF1,midFF2: std_logic_vector(7 downto 0);

--FSM 
type fsm_states is (idle,busca,suma,suma2,captura,grabo,grabo2,guardoE,guardoE2,Sumi,
                    COMP1);
signal next_state,state: fsm_states;

constant rsr_act_value: std_logic:= '1';

signal i: natural := 0;
signal I8: std_logic;
signal iprima: unsigned (2 downto 0);
signal addFirst: unsigned (2 downto 0) := unsigned(int_addrROM1);
signal flag: std_logic;
type bookaddres is array (7 downto 0) of std_logic_vector (2 downto 0);
constant book: bookaddres := (0 =>"000",1=>"001",2=>"010",3=>"011",
                                4=>"100",5=>"101",6=>"110",7=>"111");      

begin

--current logic

 current: process(clk,rst)
 begin
        if (rst = rsr_act_value ) then
            state <= idle;
        elsif (rising_edge(clk)) then
            state <= next_state;
        end if;
 end process current;
 
--next state
 nextP: process (state,start)
 begin
 case state is
        when idle =>
                    if (start = '0') then
                        next_state <= idle;
                    else
                        next_state <= busca;
                    end if;
          when busca => 
                       
                        if (I8 = '1') then
                        next_state <= COMP1;
                        else
                        next_state <= suma;
                        end if;
          when suma =>
                        next_state <= suma2;
          when suma2 =>
                        next_state <= captura;
          when captura =>
                        next_state <= grabo;
                        
          when grabo =>
                        
                        
                        next_state <= grabo2;
           when grabo2 =>
                        next_state <= guardoE;
           when guardoE =>
                            next_state <= guardoE2;
           when guardoE2 =>
                           next_state <= Sumi;
           when Sumi =>
                         next_state <= busca;
                           
            when others =>  next_state <= idle;
 end case;
 end process;
-- output logic
 outputlogic: process(clk,rst)
 begin
    oe1 <= '0'; oe2 <= '0';oe3 <= '0'; oe4 <= '0'; oe5 <= '0'; oe6 <= '0';oe7 <= '0';
    pulse <= '0'; I8<= '0';
    wea <= '0';web <='0';ena <= '0'; enb <= '0';flag <= '0';
          --if (rst = rst_act_value) then
      case state is
      
        when idle =>
                    int_addrROM1 <= "000";
                    pulse <= '0';
                    i <= 0;
        when busca =>
            
            int_addrROM1 <= book(i);
          --  iprima <=to_unsigned(i,iprima'length);
           -- addFirst <= addFirst + (iprima);
           -- int_addrROM1 <= std_logic_vector(addFirst);
            flag <= '1';
            
        
        when suma => 
                    oe1 <= '1';oe2 <= '1';oe3 <= '1';
        when suma2 =>
        oe1 <= '1';oe2 <= '1';oe3 <= '1';
                    
        when captura =>
                    oe4 <= '1';
                    
        when grabo =>
                ena <= '1';
                wea <= '1';
                oe4 <= '0';
        when grabo2 =>
                ena <= '1';
                wea <= '1';
                oe4 <= '0';
        when guardoE =>
                  
                  enb <= '1';
                  web <= '1';
                  oe7 <= '1';
        when guardoE2 =>
                    enb <= '1';
                  web <= '1';
                  oe7 <= '1';
        when Sumi =>
               
                if (i = 8) then
                    I8 <= '1';
                else
                 i <= i + 1;
                 end if;
        
          when others => null;      
                    
            
            
            
           
                        
      
                 
                       
        
 end case;
 end process;
--singlas Blinker

int_addr_IPROM <= '0' & int_addrROM1;

ROM1: I_ROM port map (clk => clk, address => int_addrROM1,data_out =>ROM1toReg1);

REG1: Reg port map (clk=>clk, D=>midFF1,oe =>oe1,Q=> add1);


FF1: FF_D port map (clk => clk, rst=>rst, D=>ROM1toReg1,Q =>midFF1);

ROM2: I_ROM port map (clk => clk, address => int_addrROM1,data_out =>ROM2toReg2);

REG2: Reg port map (clk=>clk, D=>midFF2,oe =>oe2,Q=> add2);

FF2: FF_D port map (clk => clk, rst=>rst, D=>ROM2toReg2,Q =>midFF2);

IP_ROM3: IP_Core_ROM port map (clk => clk, a => int_addr_IPROM,qspo =>ROM3toReg3);

REG3: Reg port map (clk=>clk, D=>ROM3toReg3,oe =>oe3,Q=> add3);

AdderOne: Adder port map (dataA => add1,dataB=>add2,Add =>addout1);

AdderTtwo: Adder 
    generic map (La => 8, Lb => 9,Lo =>10)
    port map (dataA => add3,dataB=>addout1,Add =>addout2);
    
REG4: Reg 
    generic map (Do=>10,Qo=>10)
    port map (clk=>clk, D=>addout2,oe =>oe4,Q=> Final_Add);
    
TDP_BRAM: true_dp_bram port map (clk_a=>clk,clk_b=>clk,
                                 addr_a => int_addr_IPROM,we_a =>wea,
                                  en_a => ena,data_a =>Final_Add,
                                  q_a =>outA,
                                  addr_b => int_addr_IPROM,we_b =>web,
                                  en_b => enb,data_b =>true_data,
                                  q_b =>outB);
REG5: Reg
    generic map (Do=>10,Qo=>10)
    port map (clk=>clk, D=>OutA,oe =>oe5,Q=> REGA);   
    
REG6: Reg
    generic map (Do=>10,Qo=>10)
    port map (clk=>clk, D=>OUTB,oe =>oe6,Q=> REGB);                                 

TrueV: TrueValues_ROM port map 
                            (clk=>clk,address=>int_addrROM1,data_out=>tmp);

REG7: Reg
    generic map (Do=>10,Qo=>10)
    port map (clk=>clk, D=>tmp,oe =>oe7,Q=> true_data);

Comp: Comparator port map                                              
                        (dataA=>REGA,dataB=>REGB,rst=>rst,ctrl=>ctrl,led=>led);

Blink: Blinker port map (Do=>led,clk=>clk,Stop=>Stop,lblink=>pulse);
end Behavioral;
