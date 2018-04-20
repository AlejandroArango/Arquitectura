library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unidadControl is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           aluop : out  STD_LOGIC_VECTOR (5 downto 0));
end unidadControl;

architecture Behavioral of unidadControl is

begin
	process(op, op3)
	begin
		if(op = "10")then
			case op3 is
				when "000000" => ------> Add
				aluop <= "000000";
				when "000100" => ------> Sub
				aluop <= "000001";
				when "000001" => ------> And
				aluop <= "000010";
				when "000010" => ------> Or
				aluop <= "000011";
				when "000101" => ------> Andn
				aluop <= "000100";
				when "000110" => ------> Orn
				aluop <= "000101";
				when "000011" => ------> Xor
				aluop <= "000110";
				when "000111" => ------> Xnor
				aluop <= "000111";
				when others =>
				aluop <= "111111";
			end case;
		end if;

	end process;
end Behavioral;





--add 	10 000000
--sub 	10 000100
--and 	10 000001
--or 		10 000010
--andn 	10 000101
--orn 	10 000110
--xor 	10 000011
--xnor 	10 000111

