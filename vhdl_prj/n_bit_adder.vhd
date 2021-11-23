library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity n_bit_adder is
port(
        nibble_in1        : in  std_logic_vector(15 downto 0) ;
        nibble_in2        : in  std_logic_vector(15 downto 0) ;
        nibble_in_carry   : in  std_logic_vector(15 downto 0) ;
        nibble_out_sum    : out std_logic_vector(15 downto 0) ;
        nibble_out_carry  : out std_logic  
     );		  

end n_bit_adder;

architecture Behavioral of n_bit_adder is
signal temp : std_logic_vector(15 downto 0);

component fall_adder
port(
      nibble_in1        : in  std_logic_vector(15 downto 0) ;
      nibble_in2        : in  std_logic_vector(15 downto 0) ;	
      nibble_in_carry   : in  std_logic_vector(15 downto 0) ;
		nibble_out_sum    : out std_logic_vector(15 downto 0) ;
		nibble_out_carry  : out std_logic 
     );

end component;
           
begin
       L : for i in 0 to 14 generate
		 begin
              (F.A <= fall_adder port map ( nibble_in1(i),nibble_in2(i+1),temp(i),nibble_out_sum(i),nibble_out_carry(i+1)));
       end generate;
end Behavioral;

