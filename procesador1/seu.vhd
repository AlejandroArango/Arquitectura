library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seu is
    Port ( imm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           out_seu : out  STD_LOGIC_VECTOR (31 downto 0));
end seu;

architecture Behavioral of seu is

begin
	process(imm13)
	begin
		if(imm13(12) = '1')then
			out_seu(12 downto 0) <= imm13;
			out_seu(31 downto 13) <= (others=>'1');
		else
			out_seu(12 downto 0) <= imm13;
			out_seu(31 downto 13) <= (others=>'0');
		end if;
	end process;

end Behavioral;

