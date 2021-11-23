
--Author	: Ramy Rabie
--Verion	: Kitkat
--Date		: 19Mars

-- Single-Port RAM in Read-First Mode Pin Descriptions
-- IO Pins Description:
-- clk Positive-Edge Clock
-- we Synchronous Write Enable (Active High)
-- en Clock Enable
-- addr Read/Write Address
-- di Data Input
-- do Data Output

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ram_entity is
	port (
clock	 			: in std_logic;
reset          : in std_logic;
MemWrite			: in std_logic;
MemRead			: in std_logic;
Address	 		: in std_logic_vector(15 downto 0);
WriteData		: in std_logic_vector(15 downto 0);
ReadData			: out std_logic_vector(15 downto 0));
end ram_entity;

architecture ram_arch of ram_entity is

type ram_type is array (0 to 4095) of std_logic_vector (15 downto 0);

--addr is the truncated signal.
signal RAM: ram_type;
signal addr: std_logic_vector(11 downto 0);

begin
addr <= Address(11 downto 0);

process (clock, MemWrite, MemRead,reset,RAM,addr)
begin

if(reset ='1') then
RAM <=(others=> (others=>'0'));

else
  if (clock'event and clock = '1') then
--

    if MemWrite = '1' then
      RAM(conv_integer(addr)) <= WriteData;
    end if;
--


  end if;
--
 if MemRead = '1'  then
 ReadData <= RAM(conv_integer(addr)) ;
 end if;
 
end if; 
--
end process;
end ram_arch;