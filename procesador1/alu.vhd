
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

----------------------------------------------------------------------------------


entity alu is
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           op : in  STD_LOGIC_VECTOR (5 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0));
end alu;

----------------------------------------------------------------------------------

architecture Behavioral of alu is
----------------------------------------------------------------------------------

begin
	process (a, b, op)
		begin 
		
			case (op) is
				when "000000" => ---ADD
					result <= a + b;
				when "000100" => ---SUB
					result <= a - b;
				when "000001" =>---AND
					result <= a and b;
				when "000101" =>---ANDN
					result <= a nand b;
				when "000010" =>--- OR
					result <= a or b;
				when "000110" => ---ORN
					result <= a nor b; 
				when "000011" => ---XOR
					result <= a xor b;
				when "000111" => ---XORN
					result <= a xnor b;
				when others =>
					result <= "00000000000000000000000000000000";
			end case;
	end process;
end Behavioral;

----------------------------------------------------------------------------------
