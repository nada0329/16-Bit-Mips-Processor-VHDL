library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Sign_Extension_Entity is
port(
		 Sign_Extension_Input	:in std_logic_vector	(5 downto 0)    ; 
		 Sign_Extension_Output	:out std_logic_vector	(15 downto 0)
	  );
end Sign_Extension_Entity;


architecture Sign_Extension_Arch of Sign_Extension_Entity is
	
-- We Want for 6 bit input , 16 bit output
begin
    Sign_Extension_Output <= std_logic_vector(resize(signed(Sign_Extension_Input), Sign_Extension_Output'length));

end Sign_Extension_Arch;