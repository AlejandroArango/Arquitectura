library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Psr is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           ncwp : in  STD_LOGIC;
           cwp : out  STD_LOGIC;
           c : out  STD_LOGIC);
			  --tener en cuenta icc
end Psr;

architecture Behavioral of Psr is

begin
process(nzvc,clk,rst,ncwp)
	begin
		if(rst = '1')then
			cwp <= '0';
			c <= '0';
		else
			if(rising_edge(clk))then
				cwp <= ncwp;
				c <= nzvc(0);
			end if;
		end if;
end process;

end Behavioral;

