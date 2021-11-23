

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee .numeric_std .all;
--use ieee.std_logic_unsigned.all;
entity reg is
 generic ( reg_width :integer:=16;
           add_width :integer:=3);

 port (
  wr,reset: in std_logic;  -- two read enables and one write enable
  rreg1,rreg2,wreg: in std_logic_vector(add_width-1 downto 0);
  rdata:in std_logic_vector(reg_width-1 downto 0);
  clk:in std_logic;
  rd1,rd2: out std_logic_vector(reg_width-1  downto 0));
end reg;

architecture Behavioral of reg is
type registerfile is array(0 to 7) of std_logic_vector(reg_width-1 downto 0);
signal registers : registerfile ;
begin
-------write process----
process (wr,clk,reset)
begin 
 if (reset='1')then
  registers <= (others=> (others=>'0'));

 elsif(clk'event and clk='1'and wr='1') then 
     
    registers(to_integer(unsigned(wreg)))<=rdata;
      
end if;		
end process ;
----------read process------------
rd1 <= registers(to_integer(unsigned(rreg1)));
 
rd2 <= registers(to_integer(unsigned(rreg2)));

end Behavioral;