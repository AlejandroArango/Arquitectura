library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc is
    Port ( pcaddres : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           pcout : out  STD_LOGIC_VECTOR (31 downto 0));
end pc;

architecture Behavioral of pc is

begin

	process (clk)
	begin
		if (rst = '1') then
			pcout <= "00000000000000000000000000000000";
		else
			if (rising_edge(clk)) then
				pcout <= pcaddres;
			end if;
		end if;
	end process;	

end Behavioral;

