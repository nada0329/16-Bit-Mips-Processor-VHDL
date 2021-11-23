library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;
entity alu is 
port(
      alu_nibble0 : in  std_logic_vector(15 downto 0);
      alu_nibble1 : in  std_logic_vector(15 downto 0);
      alu_control : in  std_logic_vector(2  downto 0);
      zero_flag   : out std_logic                    ;
      result      : out std_logic_vector(15 downto 0)
    );
end alu;

architecture dataflow of alu is 

signal temp                    : std_logic_vector(15 downto 0);
signal x0,x1,x2,x3,x4,x5,x6,x7 : std_logic_vector(15 downto 0);

begin 
      x0  <= alu_nibble0 and  alu_nibble1  ;
      x1  <= alu_nibble0 or   alu_nibble1  ;
      x2  <= alu_nibble0 nor  alu_nibble1  ;
      x3  <= alu_nibble0 xor  alu_nibble1  ;
      x4  <= alu_nibble0  +   alu_nibble1  ;
      x5  <= (alu_nibble0 - alu_nibble1 )  ;
      x6  <= alu_nibble0(14 downto 0) & '0';
      x7  <= '0' & alu_nibble0(15 downto 1);
     
with alu_control select 
                            
						  temp<= x0  when  "010",
                           x1  when  "011",
                           x2  when  "100",
                           x3  when  "101",
                           x4  when  "000",
                           x5  when  "001",
                           x6  when  "110",
                           x7  when  "111";

 zero_flag <= '1' when(temp=x"0000")else 
              '0';
result <= temp;

end   dataflow;