----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:31:07 03/17/2019 
-- Design Name: 
-- Module Name:    mux3bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux3bit is
    Port ( s : in  STD_LOGIC_vector (1 downto 0);
           i0 : in  STD_LOGIC_vector (2 downto 0);
           i1 : in  STD_LOGIC_vector (2 downto 0);
			  i2 : in  STD_LOGIC_vector (2 downto 0);
			  i3 : in  STD_LOGIC_vector (2 downto 0);
           y : out  STD_LOGIC_vector (2 downto 0));
end mux3bit;

architecture Behavioral of mux3bit is

begin
 with s select            --normal mux function
     y <=i0 when "00",
         i1 when "01",
			i2 when "10",
			i3 when "11",
			(others=>'0') when others;

end Behavioral;
