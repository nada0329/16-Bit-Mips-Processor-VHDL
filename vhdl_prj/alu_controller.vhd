library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_controller2 is
    Port ( aluop : in  STD_LOGIC_VECTOR (2 downto 0);
           func : in  STD_LOGIC_VECTOR (2 downto 0);
           alu_control  : out  STD_LOGIC_VECTOR (2 downto 0));
end alu_controller2;

architecture Behavioral of alu_controller2 is

begin
process(aluop , func )
begin 
case(aluop) is

when "000" =>
alu_control <= func(2 downto 0);
when "001" => 
alu_control <= "000";
when "010" => 
alu_control <= "010";
when "011" => 
alu_control <= "011";
when "100" => 
alu_control <= "001";
when others => alu_control <= "000";
end case;
end process;

end Behavioral;

