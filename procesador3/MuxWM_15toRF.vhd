library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxWM_15toRF is
    Port ( rd : in  STD_LOGIC_VECTOR (5 downto 0);
           reg : in  STD_LOGIC_VECTOR (5 downto 0);
			  rfd : in STD_LOGIC;
           nrd : out  STD_LOGIC_VECTOR (5 downto 0) := "000000");
end MuxWM_15toRF;

architecture Behavioral of MuxWM_15toRF is

begin
	process(rd, reg, rfd)
	begin
		
		case(rfd)is
		when '0' => nrd <= rd;
		when '1' => nrd <= reg;
		when others =>
		end case;
		
	end process;

end Behavioral;

