
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IR_mem is
 generic (add_size :integer :=12);    --need the real size of the application !!!!!!
    Port ( address : in  STD_LOGIC_VECTOR (add_size-1 downto 0);
           instruction : out  STD_LOGIC_VECTOR (15 downto 0));
end IR_mem;

architecture Behavioral of IR_mem is
type ROM is array(0 to ((2**add_size)-1)) of std_logic_vector(15 downto 0);  
constant IR_ROM :ROM :=(others=> (others=>'0')); --number of rows depends on the real size of the application
begin
instruction <= IR_ROM (TO_integer(unsigned(address)));

end Behavioral;

