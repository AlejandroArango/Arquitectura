library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ControlUnit is
	Port (

	  	op : in  STD_LOGIC_VECTOR (1 downto 0);
		op2 : in STD_LOGIC_VECTOR (2 downto 0);
		op3 : in  STD_LOGIC_VECTOR (5 downto 0);
		icc : in STD_LOGIC_VECTOR (3 downto 0);
		cond : in STD_LOGIC_VECTOR (3 downto 0);

		rfs : out STD_LOGIC_VECTOR (1 downto 0) := "00";
		rfd : out STD_LOGIC := '0';
		PCs : out STD_LOGIC_VECTOR (1 downto 0) := "00";
		DMwen : out STD_LOGIC := '0';
		DMren : out STD_LOGIC := '0';
		RFwen : out STD_LOGIC := '0';
		--CLK : in STD_LOGIC;

           aluop : out  STD_LOGIC_VECTOR (5 downto 0) := (others => '1'));
end ControlUnit;

architecture Behavioral of ControlUnit is

begin

	process(op,op2,op3,icc,cond)	
	begin 
		--if rising_edge(CLK) then
		case (op) is
		
			when "00" =>
				rfs <= "11";
				rfd <= '0';
				DMwen <= '0';
				DMren <= '0';
				RFwen <= '0';
				aluop <= "111111";
				if (op2 = "010") then			
					case(cond)is
						when "1000" => -- BA -- 1
							PCs <= "01";
						when "0000" => -- BN -- 0
						
						when "1001" => -- BNE -- not Z
							if (icc(2) = '0') then 
								PCs <= "01";
							else 
								PCs <= "10";
							end if;
						when "0001" => -- BE -- Z
							if (icc(2) = '1') then 
								PCs <= "01";
							else 
								PCs <= "10";
							end if;
						when "1010" => -- BG -- not (Z or (N xor V))
							if ((icc(2) or (icc(3) xor icc(1))) = '0') then 
								PCs <= "01";
							else 
								PCs <= "10";
							end if;
						when "0010" => -- BLE -- Z or (N xor V)
							if ((icc(2) or (icc(3) xor icc(1))) = '1') then 
								PCs <= "01";
							else 
								PCs <= "10";
							end if;
						when "1011" => -- BGE -- not (N xor V)
							if ((icc(3) xor icc(1)) = '0') then 
								PCs <= "01";
							else 
								PCs <= "10";
							end if;
						when "0011" => -- BL -- N xor V
							if ((icc(3) xor icc(1)) = '1') then 
								PCs <= "01";
							else 
								PCs <= "10";
							end if;
						when "1100" => -- BGU -- not (C or Z)
							if ((icc(0) or icc(2)) = '0') then 
								PCs <= "01";
							else 
								PCs <= "10";
							end if;
						when "0100" => -- BLEU -- (C or Z)
							if ((icc(0) or icc(2)) = '1') then 
								PCs <= "01";
							else 
								PCs <= "10";
							end if;
						when "1101" => -- BCC -- not C
							if (icc(0) = '0') then 
								PCs <= "01";
							else 
								PCs <= "10";
							end if;
						when "0101" => -- BCS -- C
							if (icc(0) = '1') then 
								PCs <= "01";
							else 
								PCs <= "10";
							end if;
						when "1110" => -- BPOS -- not N
							if (icc(3) = '0') then 
								PCs <= "01";
							else 
								PCs <= "10";
							end if;
						when "0110" => -- BNEG -- N
							if (icc(3) = '1') then 
								PCs <= "01";
							else 
								PCs <= "10";
							end if;
						when "1111" => -- BVC -- not V
							if (icc(1) = '0') then 
								PCs <= "01";
							else 
								PCs <= "10";
							end if;
						when "0111" => -- BVS -- V
							if (icc(1) = '1') then 
								PCs <= "01";
							else 
								PCs <= "10";
							end if;
						when others =>
					end case;	
				else
					PCs <= "10";
				end if;
				
			when "01" =>
				rfs <= "10";
				rfd <= '1';
				PCs <= "00";
				DMwen <= '0';
				DMren <= '0';
				RFwen <= '1';
				aluop <= "111111";
		
			when "10" =>	
				rfd <= '0';
				DMwen <= '0';
				DMren <= '0';
				RFwen <= '1';
				case (op3) is
					when "000000" =>  -- Add
						aluop <= "000000";	
						PCs <= "10";
						rfs <= "01";
					when "010000" =>  -- Addcc
						aluop <= "010000";
						PCs <= "10";
						rfs <= "01";
					when "001000" =>  -- AddX
						aluop <= "001000";
						PCs <= "10";
						rfs <= "01";
					when "011000" =>  -- AddXcc
						aluop <= "011000";
						PCs <= "10";
						rfs <= "01";
					----------------------------
					when "000100" =>  -- Sub
						aluop <= "000100"; 
						PCs <= "10";
						rfs <= "01";
					when "010100" =>  -- Subcc
						aluop <= "010100";
						PCs <= "10";
						rfs <= "01";
					when "001100" =>  -- SubX
						aluop <= "001100";
						PCs <= "10";
						rfs <= "01";
					when "011100" =>  -- SubXcc
						aluop <= "011100";
						PCs <= "10";
						rfs <= "01";
					----------------------------
					when "000001" =>  -- And
						aluop <= "000001";
						PCs <= "10";
						rfs <= "01";
					when "010001" =>  -- Andcc
						aluop <= "010001";
						PCs <= "10";
						rfs <= "01";
					----------------------------
					when "000101" =>  -- AndN
						aluop <= "000101";
						PCs <= "10";
						rfs <= "01";
					when "010101" =>  -- AndNcc
						aluop <= "010101";
						PCs <= "10";
						rfs <= "01";
					----------------------------
					when "000010" =>  -- Or
						aluop <= "000010";
						PCs <= "10";
						rfs <= "01";
					when "010010" =>  -- Orcc
						aluop <= "010010";
						PCs <= "10";
						rfs <= "01";
					----------------------------
					when "000110" =>  -- OrN
						aluop <= "000110";
						PCs <= "10";	
						rfs <= "01";						
					when "010110" =>  -- OrNcc
						aluop <= "010110";
						PCs <= "10";
						rfs <= "01";
					----------------------------
					when "000011" =>  -- Xor
						aluop <= "000011";
						PCs <= "10";
						rfs <= "01";
					when "010011" =>  -- Xorcc
						aluop <= "010011";
						PCs <= "10";
						rfs <= "01";
					----------------------------
					when "000111" =>  -- XNor
						aluop <= "000111"; 
						PCs <= "10";
						rfs <= "01";
					when "010111" =>  -- XNorcc
						aluop <= "010111";	
						PCs <= "10";
						rfs <= "01";
					----------------------------
					when "100101" =>  -- Sll
						aluop <= "100101";
						PCs <= "10";
						rfs <= "01";
					when "100110" =>  -- Srl
						aluop <= "100110";
						PCs <= "10";
						rfs <= "01";
					----------------------------
					when "111100" =>  -- Save
						aluop <= "111100";
						PCs <= "10";
						rfs <= "01";
					when "111101" =>  -- Restore
						aluop <= "111101";
						PCs <= "10";
						rfs <= "01";
					----------------------------
					--nuevo--
					----------------------------
					when "111000" => -- JMPL
						aluop <= "000000";
						RFwen <= '0';
						rfs <= "10";
						PCs <= "11";
					----------------------------
					when others =>
						aluop <= "111111";
						rfs <= "11";
						PCs <= "10";
				end case;
				
			when "11" =>
				rfd <= '0';
				PCs <= "10";
				aluop <= "000000";
				case (op3) is
					when "000000" => -- Load
						rfs <= "00";
						DMwen <= '0';
						DMren <= '1';
						RFwen <= '1';
					----------------------------
					when "000100" => -- Store
						rfs <= "11";
						DMwen <= '1'; 
						DMren <= '1';
						RFwen <= '0';
					----------------------------
					when others =>
						rfs <= "11";
						DMwen <= '0';
						DMren <= '0';
						RFwen <= '0';
				end case;
				
			when others =>			
				rfs <= "11";
				rfd <= '0';
				PCs <= "10";
				DMwen <= '0';
				DMren <= '0';
				RFwen <= '0';
				aluop <= "111111";
				
		end case;
		--end if;
	
	end process;

end Behavioral;

