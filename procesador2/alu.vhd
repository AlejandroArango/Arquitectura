
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

----------------------------------------------------------------------------------


entity alu is
    Port ( op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Aluop : in  STD_LOGIC_VECTOR (5 downto 0);
			  c: in std_logic;
           result : out  STD_LOGIC_VECTOR (31 downto 0));
			  
end alu;

----------------------------------------------------------------------------------

architecture Behavioral of alu is
----------------------------------------------------------------------------------

begin
	process (Aluop,op1,op2, c)
		begin 
		
			case Aluop is
		when "000000" =>
			result <= std_logic_vector(unsigned(op1) + unsigned(op2))  ;  --ADD
		when "000001" =>
			result <= op1 AND op2;		                                   --AND
		when "000010" =>
			result <= op1 OR op2;				                             --OR
		when "000011" =>
			result <= op1 XOR op2;				                             --XOR
		when "000100" =>
			result <= std_logic_vector(unsigned(op1) - unsigned(op2)) ;	  --SUB
		when "000101" =>
			result <= op1 AND NOT op2;				                          --NAND
		when "000110" =>
			result <= op1 OR NOT op2;		                                --NOR
		when "000111" =>
			result <= op1 XNOR op2 ;				                          --XNOR	
		when "100101" => 
			result <= to_stdlogicvector(to_bitvector(op1) SLL conv_integer(op2));
		when "100110" =>
			result <= to_stdlogicvector(to_bitvector(op1) SRL conv_integer(op2));
		when "010000" => 
			result <= std_logic_vector((op1) + (op2)); 						  --ADDcc
		when "010100" => 
			result <= std_logic_vector((op1) - (op2)); 						  --SUBcc
		when "010001" => 
			result <= std_logic_vector((op1) and (op2)); 					  --ANDcc
		when "010101" => 
			result <= std_logic_vector((op1)and (not(op2))); 				  --ANDNcc
		when "010010" => 
			result <= std_logic_vector((op1) or (op2)); 						  --ORcc
		when "010110" => 
			result <= std_logic_vector((op1) or (not(op2))); 			     --ORNcc
		when "010011" => 
			result <= std_logic_vector((op1) xor (op2)); 					  --XORcc
		when "010111" => 
			result <= std_logic_vector((op1) xnor (op2)); 				     --XNORcc
		when "001000" => 
			result <= std_logic_vector((op1) + (op2)+c); 					  --ADDX
		when "001100" => 
			result <= std_logic_vector((op1) - (op2)-c); 					  --SUBx
		when "011000" => 
			result <= std_logic_vector((op1) + (op2)+c); 					  --ADDxcc
		when "011100" => 
			result <= std_logic_vector((op1) - (op2)-c); 					  --SUBxcc

		when "111100" =>                                                 --save
		   result <= op1 + op2;
						
		when "111101" =>                                                 --restore
         result <= op1 + op2;	
	 when others =>
	  result <="00000000000000000000000000000000";

	 
	end case;
	end process;
end Behavioral;

----------------------------------------------------------------------------------
