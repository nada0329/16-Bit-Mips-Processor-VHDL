
-- VHDL Instantiation Created from source file ram_entity.vhd -- 20:54:01 04/11/2019
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT ram_entity
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		MemWrite : IN std_logic;
		MemRead : IN std_logic;
		Address : IN std_logic_vector(15 downto 0);
		WriteData : IN std_logic_vector(15 downto 0);          
		ReadData : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	Inst_ram_entity: ram_entity PORT MAP(
		clock => ,
		reset => ,
		MemWrite => ,
		MemRead => ,
		Address => ,
		WriteData => ,
		ReadData => 
	);


