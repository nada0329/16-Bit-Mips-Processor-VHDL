library ieee;
use ieee.std_logic_1164.all;

entity multiplexertwo_entity is
port (
       mux_a, mux_b : in std_logic_vector(15 downto 0)  ;
       mux_s        : in std_logic                      ;
       mux_o        : out std_logic_vector(15 downto 0)
		);

end multiplexertwo_entity;

architecture muxtwo_archi of multiplexertwo_entity is

begin

process (mux_a, mux_b, mux_s)

begin
        case mux_s is
                     when '0' => mux_o <= mux_a;
                     when others => mux_o <= mux_b;
        end case;
end process;

end muxtwo_archi;