library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pc is
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           pcout : out  STD_LOGIC_VECTOR (31 downto 0));
end pc;

architecture Behavioral of pc is

begin

	PROCESS (rst,clk) IS
		BEGIN 	
	if rst = '1' then
		pcout <= x"00000000";
	
	else
		if rising_edge(clk)then
			pcout <= address;
		end if;
	end if;
end process;


end Behavioral;

