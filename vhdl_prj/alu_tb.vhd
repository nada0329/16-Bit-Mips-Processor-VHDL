LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY alu_tb IS
END alu_tb;
 
ARCHITECTURE behavior OF alu_tb IS 
 
COMPONENT alu                                                                      -- Component Declaration for the Unit Under Test (UUT)                                                        
          
			 PORT(
                 alu_nibble0 : IN  std_logic_vector(15 downto 0);
                 alu_nibble1 : IN  std_logic_vector(15 downto 0);
                 alu_control : IN  std_logic_vector(2  downto 0);
                 zero_flag   : OUT std_logic                    ;
                 result      : OUT std_logic_vector(15 downto 0)
        );
END COMPONENT;
    
signal alu_tb_nibble0  : std_logic_vector(15 downto 0) := (others => '0');          --Inputs       
signal alu_tb_nibble1  : std_logic_vector(15 downto 0) := (others => '0');
signal alu_tb_control  : std_logic_vector(2  downto 0) := (others => '0');

signal zero_flag_tb    : std_logic                                       ;          --Outputs
signal result_tb       : std_logic_vector(15 downto 0)                   ;
 
BEGIN
 
   uut: alu PORT MAP (                                                              -- Instantiate the Unit Under Test (UUT)
     							alu_nibble0 => alu_tb_nibble0 ,
                        alu_nibble1 => alu_tb_nibble1 ,
                        alu_control => alu_tb_control ,
                        zero_flag   => zero_flag_tb   ,
                        result      => result_tb 
                     );

stim_proc: process                                                                  -- Stimulus process
begin		
     alu_tb_nibble0 <= x"0007";
	  alu_tb_nibble1 <= x"0008";
	  
	  alu_tb_control <= "000"  ;
	  wait for 100ns           ;
	  
	  alu_tb_control <= "100"  ;
	  wait for 100ns           ;
	  
	  alu_tb_control <= "101"  ;
	  wait for 100ns           ;
		
	  assert false
	  report "end"
	  severity failure         ;
end process;

END;