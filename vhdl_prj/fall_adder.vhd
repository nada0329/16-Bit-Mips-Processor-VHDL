library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fall_adder is
port(
      nibble_in1        : in  std_logic_vector(15 downto 0) ;
      nibble_in2        : in  std_logic_vector(15 downto 0) ;	
      nibble_in_carry   : in  std_logic_vector(15 downto 0) ;
		nibble_out_sum    : out std_logic_vector(15 downto 0) ;
		nibble_out_carry  : out std_logic_vector(15 downto 0)  
     );

end fall_adder;

architecture Behavioral of fall_adder is

begin

nibble_out_sum   <= (nibble_in1) xor (nibble_in2) xor (nibble_in3)                                                          ;
nibble_out_carry <= ((nibble_in1) and (nibble_in2)) xor ((nibble_in2) and (nibble_in3)) xor ((nibble_in1) and (nibble_in3)) ;

end Behavioral;

