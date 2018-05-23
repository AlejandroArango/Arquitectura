library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity RegisterFile is
    Port ( rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
           rst : in  STD_LOGIC;
           dwr : in  STD_LOGIC_VECTOR (31 downto 0);
			  wen : in STD_LOGIC;
			  --CLK : in std_logic;
           crs1 : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
           crs2 : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
			  crd : out STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end RegisterFile;

architecture Behavioral of RegisterFile is

	type ram_type is array (0 to 39) of std_logic_vector(31 downto 0);
	signal registers : ram_type := (others => x"00000000");

begin
	
	process(rs1,rs2,rd,rst,wen,dwr)
	begin
		--if rising_edge(CLK) then
		if( rst = '1') then
			registers <= (others => x"00000000");
		else
		
			if ((rd /= "000000")and(wen = '1')) then	
				registers(conv_integer(rd)) <= dwr;		
			end if;
			crs1 <= registers(conv_integer(rs1));
			crs2 <= registers(conv_integer(rs2));
			crd <= registers(conv_integer(rd));
	
		end if;
		
		--end if; 
		
	end process;
	
	
end Behavioral;

