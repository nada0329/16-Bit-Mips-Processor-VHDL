
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
                Port (					 
					       opcode   : in   STD_LOGIC_VECTOR (3 downto 0);       --to deal with normal instructions
                      alu_op   : out  STD_LOGIC_VECTOR (2 downto 0);       --signal will be sent to alu_control 
                      regDst   : out  STD_LOGIC_vector (1 downto 0);       --signal to the mux of RD in reg_file      
			             jump     : out  STD_LOGIC                    ;       --signal to the mux of jump target before pc
			             jr       : out  STD_LOGIC                    ;       --signal to the mux of jump reg before pc
			             branch_eq  : out  STD_LOGIC                    ;       --signal to the and gate to check equality
							 branch_neq  : out  STD_LOGIC                    ;
			           --  memread  : out  STD_LOGIC                    ;       --signal to the data memory
			             memwrite : out  STD_LOGIC                    ;       --signal to the data memory
			             memtoreg : out  STD_LOGIC_vector (1 downto 0);       --signal to the mux to write in reg_file
			             alusrc   : out  STD_LOGIC                    ;       --signal to the mux of alu second parameter
			             regwrite : out  STD_LOGIC                            --signal to the write data in reg_file
                     );
end control_unit;

architecture Behavioral of control_unit is

begin

process(opcode)

begin
       case opcode is
                
					 when "0000" =>             -- rd = rs (add sub and or nor xor sll srl) rt
                      alu_op <= "000"  ;   --alu control will send the func bits to the alu
                      regDst <= "01"   ;   --write in rd
			             jump <= '0'      ;
			             jr <= '0'        ;
			             branch_eq <= '0'    ;
							 branch_neq <= '0';
			          --   memread <= '0'   ;
			             memwrite <= '0'  ;
			             memtoreg <= "01" ;   --write in reg file from alu
			             alusrc <= '0'    ;   --read from reg file
			             regwrite <= '1'  ;
                
					 when "0100" =>             -- rt = rs + imm
                      alu_op <= "001"  ;   --alu control will send 000 to alu for add
                      regDst <= "00"   ;   --write in rt
			             jump <= '0'      ;
			             jr <= '0'        ;
			             branch_eq <= '0'    ;
							 branch_neq <= '0';
			         --    memread <= '0'   ;
			             memwrite <= '0'  ;
			             memtoreg <= "01" ;
			             alusrc <= '1'    ;
			             regwrite <= '1'  ; 
                
					 when "0101" =>             -- rt = rs (and) imm
                      alu_op <= "010"  ;      --alu control will send 010 to alu for and
                      regDst <= "00"   ;
			             jump <= '0'      ;
			             jr <= '0'        ;
			             branch_eq <= '0'    ;
							 branch_neq <= '0';
			      --       memread <= '0'   ;
			             memwrite <= '0'  ;
			             memtoreg <= "01" ;
			             alusrc <= '1'    ;
			             regwrite <= '1'  ; 
       
		          when "0110" =>           -- rt = rs (or) imm
                      alu_op <= "011"  ;   --alu control will send 011 to alu for or
                      regDst <= "00"   ;
			             jump <= '0'      ;
			             jr <= '0';
			             branch_eq <= '0'    ;
							 branch_neq <= '0';
			         --    memread <= '0';
			             memwrite <= '0';
			             memtoreg <= "01";
			             alusrc <= '1';
			             regwrite <= '1'; 
       
		          when "0111" =>           -- rt = M[ rs + imm ]
                      alu_op <= "001";   --alu control will send 000 to alu for add
                      regDst <= "00";
			             jump <= '0';
			             jr <= '0';			  
			             branch_eq <= '0'    ;
							 branch_neq <= '0';         
			           --  memread <= '1';
			             memwrite <= '0';
			             memtoreg <= "00";
			             alusrc <= '1';
			             regwrite <= '1'; 
       
		          when "1000" =>           -- M[ rs + imm ] = rt
                      alu_op <= "001";    --alu control will send 000 to alu for add
                      regDst <= "00";
			             jump <= '0';
			             jr <= '0';
			             branch_eq <= '0'    ;
							 branch_neq <= '0';
			          --   memread <= '0';
			             memwrite <= '1';
			             memtoreg <= "00";
			             alusrc <= '1';
			             regwrite <= '0'; 
       
		         when "1011" =>           -- jump
                      alu_op <= "000";
                      regDst <= "00";
			             jump <= '1';
			             jr <= '0';
			             branch_eq <= '0'    ;
							 branch_neq <= '0';
			        --     memread <= '0';
			             memwrite <= '0';
			             memtoreg <= "00";
			             alusrc <= '0';
			             regwrite <= '0'; 
       
		         when "1100" =>           -- jal      
                      alu_op <= "000";
                      regDst <= "10";      -- WILL GIVE THE ADD OF R7 DIRECTLY 
			             jump <= '1'; 
                      jr <= '0';			  
			             branch_eq <= '0'    ;
							 branch_neq <= '0';      
			          --   memread <= '0';     
			             memwrite <= '0';    
		 	             memtoreg <= "11";    
			             alusrc <= '0';      
			             regwrite <= '1';    
               when "0011" =>           -- jr     
                      alu_op <= "000";
                      regDst <= "00";
			             jump <= '0';
			             jr <= '1';
			             branch_eq <= '0'    ;
							 branch_neq <= '0';
			       --      memread <= '0';
			             memwrite <= '0';
			             memtoreg <= "00";
			             alusrc <= '0';
			             regwrite <= '0'; 
       
		          when "1001" =>           -- BEQ
                      alu_op <= "100";     --alu control will send 001 to alu for sub
                      regDst <= "00";
			             jump <= '0';
			             jr <= '0';
			             branch_eq <= '1'    ;
							 branch_neq <= '0';
			       --      memread <= '0';
			             memwrite <= '0';
			             memtoreg <= "00";
			             alusrc <= '0';
			             regwrite <= '0'; 
       
		          when "1010" =>           -- BNQ
                      alu_op <= "100";     --alu control will send 001 to alu for sub
                      regDst <= "00";
			             jump <= '0';
			             jr <= '0';
			             branch_eq <= '0'    ;
							 branch_neq <= '1';
			        --     memread <= '0';
			             memwrite <= '0';
			             memtoreg <= "00";
			             alusrc <= '0';
			             regwrite <= '0'; 
        
		          when "0001" =>           -- in rd
                      alu_op <= "000";     
                      regDst <= "01";
			             jump <= '0';
			             jr <= '0';
			             branch_eq <= '0'    ;
							 branch_neq <= '0';
			         --    memread <= '0';
			             memwrite <= '0';
			             memtoreg <= "10";   --TO STORE FROM IN PORT
			             alusrc <= '0';
			             regwrite <= '1';			  
      
		          when "0010" =>           -- out rs
                      alu_op <= "000";     
                      regDst <= "00";
			             jump <= '0';
			             jr <= '0';
			             branch_eq <= '0'    ;
							 branch_neq <= '0';
			          --   memread <= '0';
			             memwrite <= '0';
			             memtoreg <= "00";
			             alusrc <= '0';
			             regwrite <= '0';
       
		          when "1110" =>           -- NOP
                      alu_op <= "000";     
                      regDst <= "00";
			             jump <= '0';
			             jr <= '0';
			             branch_eq <= '0'    ;
							 branch_neq <= '0';
			          --   memread <= '0';
			             memwrite <= '0';
			             memtoreg <= "00";
			             alusrc <= '0';
			             regwrite <= '0';
       
		          when "1111" =>           -- HLT
                      alu_op <= "000";     
                      regDst <= "00";
			             jump <= '0';
			             jr <= '0';
			             branch_eq <= '0'    ;
							 branch_neq <= '0';
			      --       memread <= '0';
			             memwrite <= '0';
			             memtoreg <= "00";
			             alusrc <= '0';
			             regwrite <= '0';
          
			       when others =>           -- others
                      alu_op <= "000";     
                      regDst <= "00";
			             jump <= '0';
			             jr <= '0';
			             branch_eq <= '0'    ;
							 branch_neq <= '0';
			   --          memread <= '0';
			             memwrite <= '0';
			             memtoreg <= "00";
			             alusrc <= '0';
			             regwrite <= '0';
        end case; 

end process;

end Behavioral;

