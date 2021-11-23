library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;

entity pc_unit is
    Port ( i_clk : in  STD_LOGIC;
           i_npc : in  STD_LOGIC_VECTOR (15 downto 0);
           reset: in  STD_LOGIC;
           o_pc : out  STD_LOGIC_VECTOR (15 downto 0)
           );
end pc_unit;
architecture Behavioral of pc_unit is
  signal current_pc: std_logic_vector( 15 downto 0) := X"0000";
begin
 
  process (i_clk,reset)
  begin
    if(reset ='1') then
	  current_pc <= (others=>'0');
	  elsif (i_clk'event and i_clk='1') then
	    current_pc <= i_npc;
		 
		 end if;
		 end process;
	o_pc	 <=current_pc;
end behavioral;