library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU30 is
    Port ( Data30 : in  STD_LOGIC_VECTOR (29 downto 0);
           Data32 : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end SEU30;

architecture Behavioral of SEU30 is

begin
	process(Data30)
	begin
	
		if(Data30(29) = '1') then
			Data32(31 downto 30) <= (others => '1');
		else
			Data32(31 downto 30) <= (others => '0');
		end if;
		Data32(29 downto 0) <= Data30;
		
	end process;

end Behavioral;

