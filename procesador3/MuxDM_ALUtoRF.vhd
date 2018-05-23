library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxDM_ALUtoRF is
    Port ( DM : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           RFs : in  STD_LOGIC_VECTOR (1 downto 0);
           Data : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end MuxDM_ALUtoRF;

architecture Behavioral of MuxDM_ALUtoRF is

begin
	
	process(DM, AluResult, PC, RFs)
	begin
		
		case(RFs)is
			when "00" => 
				Data <= DM;
			when "01" =>
				Data <= AluResult;
			when "10" => 
				Data <= PC;
			when "11" => 
				Data <= (others => '0');
			when others =>
		end case;
		
	end process;

end Behavioral;

