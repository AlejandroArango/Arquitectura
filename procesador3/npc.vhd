library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity npc is
    Port ( n_address : in  STD_LOGIC_VECTOR (31 downto 0);
           n_rst : in  STD_LOGIC;
           n_clk : in  STD_LOGIC;
           n_pcout : out  STD_LOGIC_VECTOR (31 downto 0));
end npc;

architecture Behavioral of npc is

begin

	PROCESS (n_rst,n_clk) IS
		BEGIN 	
	if n_rst = '1' then
		n_pcout <= x"00000000";
	
	else
		if rising_edge(n_clk)then
			n_pcout <= n_address;
		end if;
	end if;
end process;


end Behavioral;

