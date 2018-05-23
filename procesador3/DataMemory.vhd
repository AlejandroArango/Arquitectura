library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity DataMemory is
    Port ( cRD : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           WEn : in  STD_LOGIC;
           REn : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  CLK : in STD_LOGIC;
           Data : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end DataMemory;

architecture Behavioral of DataMemory is

	type ram_type is array (0 to 31) of std_logic_vector(31 downto 0);
	signal memory : ram_type := (others => x"00000000");

begin

	process(CLK)--cRD, AluResult, rst, REn)--CLK
	begin
	
		if rising_edge(CLK) then
		
			--if(REn = '1') then
			
				if(rst = '1')then
					memory <= (others => x"00000000");
					Data <= (others => '0');
				else
					
					if(WEn = '0')then
						Data <= memory(conv_integer(AluResult(4 downto 0)));
						
					--elsif(REn = '1')then
								
					else
						memory(conv_integer(AluResult(4 downto 0))) <= cRD;
						--Data <= (others => '0');
					end if;
					
				end if;
			
			--end if;
			
		end if;
	
	end process;
	--Data <= memory(conv_integer(AluResult(4 downto 0)));

end Behavioral;

