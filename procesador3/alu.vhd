library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.all;

entity ArithmeticLogicUnit is
    Port ( aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           op_a : in  STD_LOGIC_VECTOR (31 downto 0);
           op_b : in  STD_LOGIC_VECTOR (31 downto 0);
			  carry : in STD_LOGIC;
           result : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end ArithmeticLogicUnit;

architecture Behavioral of ArithmeticLogicUnit is

begin

	process(aluop, op_a, op_b, carry)
	begin
	
		case (aluop) is
			when "000000" =>  -- Add
				result <= op_a + op_b;		
			when "010000" =>  -- Addcc
				result <= op_a + op_b;
			when "001000" =>  -- AddX
				result <= op_a + op_b + carry;
			when "011000" =>  -- AddXcc
				result <= op_a + op_b + carry;
			----------------------------
			when "000100" =>  -- Sub
				result <= op_a - op_b; 
			when "010100" =>  -- Subcc
				result <= op_a - op_b; 
			when "001100" =>  -- SubX
				result <= op_a - op_b - carry; 
			when "011100" =>  -- SubXcc
				result <= op_a - op_b - carry; 
			----------------------------
			when "000001" =>  -- And
				result <= op_a and op_b;
			when "010001" =>  -- Andcc
				result <= op_a and op_b;
			----------------------------
			when "000101" =>  -- AndN
				result <= op_a and (not op_b); 
			when "010101" =>  -- AndNcc
				result <= op_a and (not op_b); 
			----------------------------
			when "000010" =>  -- Or
				result <= op_a or op_b;
			when "010010" =>  -- Orcc
				result <= op_a or op_b;
			----------------------------
			when "000110" =>  -- OrN
				result <= op_a or (not op_b); 
			when "010110" =>  -- OrNcc
				result <= op_a or (not op_b); 
			----------------------------
			when "000011" =>  -- Xor
				result <= op_a xor op_b;
			when "010011" =>  -- Xorcc
				result <= op_a xor op_b;
			----------------------------
			when "000111" =>  -- XNor
				result <= op_a xnor op_b; 
			when "010111" =>  -- XNorcc
				result <= op_a xnor op_b;
			----------------------------
			when "100101" =>  -- Sll
				result <= to_stdlogicvector(to_bitvector(op_a) sll conv_integer(op_b));
			when "100110" =>  -- Srl
				result <= to_stdlogicvector(to_bitvector(op_a) srl conv_integer(op_b));
			----------------------------
			when "111100" =>  -- Save
				result <= op_a + op_b;
			when "111101" =>  -- Restore
				result <= op_a + op_b;
			----------------------------
			when others =>
				result <= (others=>'0');
			
		end case;
		
	end process;

end Behavioral;

