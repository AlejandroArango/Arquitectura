library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU22 is
    Port ( Data22 : in  STD_LOGIC_VECTOR (21 downto 0);
           Data32 : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end SEU22;

architecture Behavioral of SEU22 is

begin

	process(Data22)
	begin
	
		if(Data22(21) = '1') then
			Data32(31 downto 22) <= (others => '1');
		else
			Data32(31 downto 22) <= (others => '0');
		end if;
		Data32(21 downto 0) <= Data22;
		
	end process;

end Behavioral;

