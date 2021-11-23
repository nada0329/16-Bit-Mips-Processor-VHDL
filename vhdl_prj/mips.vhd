library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mips is
port(
       INPUT_PORT : in std_logic_vector(2 downto 0);
       rest,clok :in std_logic;		 
       OUT_PORT: out std_logic_vector(15 downto 0)

);
end mips;

architecture Behavioral of mips is
signal  branch,branchneq,brancheq,alusrc,memwrite,jump,jr,regwrite,zf,reset,clk: std_logic;
signal alucont,aluop,rs,rt,rd,func,wreg:std_logic_vector(2 downto 0);
signal memtoreg,regdst : std_logic_vector(1 downto 0);
signal opcode : std_logic_vector(3 downto 0);
signal imm:std_logic_vector(5 downto 0);
signal target:std_logic_vector(11 downto 0);
signal pc_nxt,pc_current,pc_inc,instr,writedata,sign,alurest,datamem,inp,
rdata1,rdata2,jaddress,j1address,baddress,branchaddress,alus2 :std_logic_vector(15 downto 0);
signal ir_add :std_logic_vector(11 downto 0);  --depends on the size of assembly

component alu is
port( 
      alu_nibble0 : in  std_logic_vector(15 downto 0);
      alu_nibble1 : in  std_logic_vector(15 downto 0);
      alu_control : in  std_logic_vector(2  downto 0);
      zero_flag   : out std_logic                    ;
      result      : out std_logic_vector(15 downto 0)
    );
end component;

component IR_mem is

     generic (add_size :integer :=12) ;  --need the real size of the application !!!!!!
	  
Port ( address     : in   STD_LOGIC_VECTOR (add_size-1 downto 0);
       instruction : out  STD_LOGIC_VECTOR (15 downto 0)
		);
		 
end component;

component alu_controller2 is
Port ( 
       aluop : in  STD_LOGIC_VECTOR (2 downto 0);
           func : in  STD_LOGIC_VECTOR (2 downto 0);
           alu_control  : out  STD_LOGIC_VECTOR (2 downto 0)
		);
end component;

component reg is
 generic ( reg_width :integer:=16;
           add_width :integer:=3
			 );

 port (
         wr,reset         : in  std_logic                             ;  -- two read enables and one write enable
         rreg1,rreg2,wreg : in  std_logic_vector(add_width-1 downto 0);
         rdata            : in  std_logic_vector(reg_width-1 downto 0);
         clk              : in  std_logic                             ;
         rd1,rd2          : out std_logic_vector(reg_width-1  downto 0)
		);
end component;



component control_unit is
Port (					 
        opcode     : in   STD_LOGIC_VECTOR (3 downto 0);                 --to deal with normal instructions
        alu_op     : out  STD_LOGIC_VECTOR (2 downto 0);                 --signal will be sent to alu_control 
        regDst     : out  STD_LOGIC_vector (1 downto 0);                 --signal to the mux of RD in reg_file      
	     jump       : out  STD_LOGIC                    ;                 --signal to the mux of jump target before pc
		  jr         : out  STD_LOGIC                    ;                 --signal to the mux of jump reg before pc
	     branch_eq  : out  STD_LOGIC                    ;                 --signal to the and gate to check equality
		  branch_neq : out  STD_LOGIC                    ;
		--  memread    : out  STD_LOGIC                    ;                 --signal to the data memory
		  memwrite   : out  STD_LOGIC                    ;                 --signal to the data memory
		  memtoreg   : out  STD_LOGIC_vector (1 downto 0);                 --signal to the mux to write in reg_file
		  alusrc     : out  STD_LOGIC                    ;                 --signal to the mux of alu second parameter
		  regwrite   : out  STD_LOGIC                                      --signal to the write data in reg_file
      );
end component;

component pc_unit is
    Port ( i_clk : in  STD_LOGIC;
           i_npc : in  STD_LOGIC_VECTOR (15 downto 0);
           reset: in  STD_LOGIC;
           o_pc : out  STD_LOGIC_VECTOR (15 downto 0)
           );
end component;
component Sign_Extension_Entity is
port(
		 Sign_Extension_Input	:in std_logic_vector	(5 downto 0)    ; 
		 Sign_Extension_Output	:out std_logic_vector	(15 downto 0)
	  );
end component;
component mux_2to1 is
    Port ( s : in  STD_LOGIC;
           i0 : in  STD_LOGIC_vector (15 downto 0);
           i1 : in  STD_LOGIC_vector (15 downto 0);
           y : out  STD_LOGIC_vector (15 downto 0)
		);
end component;
component mux3bit is
    Port ( s : in  STD_LOGIC_vector (1 downto 0);
           i0 : in  STD_LOGIC_vector (2 downto 0);
           i1 : in  STD_LOGIC_vector (2 downto 0);
			  i2 : in  STD_LOGIC_vector (2 downto 0);
			  i3 : in  STD_LOGIC_vector (2 downto 0);
           y : out  STD_LOGIC_vector (2 downto 0)
			);
end component;
component mux_4to1 is
    Port ( s : in  STD_LOGIC_VECTOR (1 downto 0);
           i0 : in  STD_LOGIC_VECTOR (15 downto 0);
           i1 : in  STD_LOGIC_VECTOR (15 downto 0);
           i2 : in  STD_LOGIC_VECTOR (15 downto 0);
           i3 : in  STD_LOGIC_VECTOR (15 downto 0);
           y : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
end component;
component ram_entity is
	port (
clock		: in std_logic;
MemWrite			: in std_logic;
--MemRead			: in std_logic;
Address	 		: in std_logic_vector(11 downto 0);
WriteData		: in std_logic_vector(15 downto 0);
ReadData			: out std_logic_vector(15 downto 0)
         );
end component;

begin
branch <= (brancheq and zf)or(branchneq and (not zf));
branchaddress <= sign + pc_inc;
jaddress <= pc_current(15 downto 12) & target;
ir_add <= pc_current(11 downto 0) ;   --will be replaced
opcode <= instr(15 downto 12);
rs<= instr(11 downto 9);
rt<=instr(8 downto 6);
rd<= instr(5 downto 3);
imm<= instr(5 downto 0);
target<= instr(11 downto 0);
func<= instr(2 downto 0);
pc_inc <= "0000000000000001" +pc_current;
OUT_PORT <= rdata1;
reset<=rest;
inp<="0000000000000"&INPUT_PORT;

u1: alu port map(
      alu_nibble0=>rdata1,
      alu_nibble1 =>alus2,
      alu_control => alucont,
      zero_flag   =>zf,           
      result  => alurest    );
u2: IR_mem port map(
      address =>ir_add  ,
      instruction  =>  instr  );	
u3: alu_controller2 port map(
      aluop =>aluop ,
           func=>func ,
           alu_control=>alucont 
                            );		
u4: reg port map(
    wr =>    regwrite,
	 reset =>  reset , 
    rreg1=>  rs   ,
	 rreg2=>  rt  ,
	 wreg =>    wreg  ,     --was wreg => rd     
   rdata =>    writedata  ,      
	clk =>  clok      ,   
   rd1=>      rdata1  ,
	rd2=>  rdata2
                         );
u5:  control_unit		port map(
        opcode   => opcode,
        alu_op   =>   aluop,
        regDst   =>    regdst,
	     jump    => jump,
		  jr   =>  jr,
	     branch_eq  => brancheq,
		  branch_neq  => branchneq,
		--  memread    =>  memread,
		  memwrite   => memwrite,
		  memtoreg   => memtoreg,
		  alusrc    => alusrc,
		  regwrite =>regwrite
                              );					 
u6: pc_unit port map(
    i_clk => clok,
           i_npc =>pc_nxt,
           reset=>reset,
           o_pc => pc_current
                       );								 
u7 : Sign_Extension_Entity port map(
		 Sign_Extension_Input	=> imm   , 
		 Sign_Extension_Output	=>  sign 
		                              );						 
u8: mux_2to1 port map(
       s=>alusrc,
       i0=>rdata2,
       i1=>sign,
       y=>alus2		 
			 );								 
u9: mux_2to1 port map(
       s=>branch,
       i0=>pc_inc,
       i1=>branchaddress,
       y=>baddress	 
			 );									 
u10: mux_2to1 port map(
       s=>jump,
       i0=>baddress,
       i1=>jaddress,
       y=>j1address	 
			 );	
u11: mux_2to1 port map(
       s=>jr,
       i0=>j1address,
       i1=>rdata1,
       y=>pc_nxt		 
			 );	
u12: mux3bit port map(
       s => regdst,
		 i0 => rt,
		 i1=>rd,
		 i2=> "111",
		 i3=> "000",
		 y=> wreg
          );
u13: mux_4to1 port map(
        s => memtoreg,
		  i0 => datamem,
		  i1 =>alurest,
		  i2=> inp,
		  i3=> pc_inc,
		  y=> writedata
       );

u14: ram_entity port map(
     clock	 => clok ,	
     MemWrite	=>	memwrite,	
   --  MemRead	=>	memread,
     Address	=> alurest(11 downto 0),
     WriteData	=> rdata2,
     ReadData	=>datamem
	 -- reset     =>reset
     ); 
								 
end Behavioral;

