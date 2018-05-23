library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxCUtoPC is
    Port ( PC30 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC22 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           AluPC : in  STD_LOGIC_VECTOR (31 downto 0);
           PCs : in  STD_LOGIC_VECTOR (1 downto 0);
           nPC : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end MuxCUtoPC;

architecture Behavioral of MuxCUtoPC is

begin

	process(PC30, PC22, PC, AluPC, PCs)
	begin
	
		case(PCs)is
			when "00" => nPC <= PC30;
			when "01" => nPC <= PC22;
			when "10" => nPC <= PC;
			when "11" => nPC <= AluPC;
			when others =>
		end case;
	
	end process;

end Behavioral;

