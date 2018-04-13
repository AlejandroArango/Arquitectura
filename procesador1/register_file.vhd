library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity register_file is
    Port ( RS1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (4 downto 0);
           RD : in  STD_LOGIC_VECTOR (4 downto 0);
           DWR : in  STD_LOGIC_VECTOR (31 downto 0);
           RST : in  STD_LOGIC;
           CRS1 : out  STD_LOGIC_VECTOR (31 downto 0);
           CRS2 : out  STD_LOGIC_VECTOR (31 downto 0));
end register_file;

architecture Behavioral of register_file is

	type ram_type is array (0 to 31) of std_logic_vector (31 downto 0);
	signal registers : ram_type :=(others => x"00000000");

begin

	process(RS1, RS2, RD, DWR, RST)
	begin
	
	if( RST = '1')then
		CRS1 <= (others=> '0');
		CRS2 <= (others => '0');
		registers <= (others => x"00000000");
		
	else
		CRS1 <= registers(conv_integer(RS1));
		CRS2 <= registers(conv_integer(RS2));
		if (RD /= "00000") then
			registers(conv_integer(RD))<= DWR;
		end if;
		

	end if;
	end process;


end Behavioral;

