library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity principal is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           outprincipal : out  STD_LOGIC_VECTOR (31 downto 0));
end principal;

architecture Behavioral of principal is

begin
		process(clk,rst)
		begin 
			
end Behavioral;

