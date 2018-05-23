----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:48:15 10/19/2017 
-- Design Name: 
-- Module Name:    PsrModifier - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PsrModifier is
    Port ( rst : in  STD_LOGIC;
           crs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           outMux : in  STD_LOGIC_VECTOR (31 downto 0);
           aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           result : in  STD_LOGIC_VECTOR (31 downto 0);
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0));
end PsrModifier;

architecture Behavioral of PsrModifier is

begin
process(rst,crs1,outMux,aluop,result)
	begin
	
		if(rst ='1')then
			nzvc <= "0000";
		else
		
			--addcc y addxcc
			if((aluop="001000") or (aluop="010010")) then
				nzvc(3) <= result(31);
				if(result="00000000000000000000000000000000")then
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				if((crs1(31)='1' and outMux(31)='1') or (result(31)='0' and (crs1(31)='1' or outMux(31)='1')))then
					nzvc(0)<='1';
				end if;
			end if;
			
			--subcc y subxcc
			if((aluop="001001") or (aluop="010100")) then
				nzvc(3) <= '1';
				if(result="00000000000000000000000000000000")then
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				if((crs1(31)='1' and outMux(31)='0' and result(31)='0') or (crs1(31)='0' and outMux(31)='1' and result(31)='1')) then
					nzvc(1)<='1';
				end if;
				if((crs1(31)='0' and outMux(31)='1') or (result(31)='1' and (crs1(31)='0' or outMux(31)='1')))then
					nzvc(0)<='1';
				end if;
			end if;
			
			--andcc, andncc, orcc, orncc, xorcc, xnorcc
			if((aluop="001010") or (aluop="001011") or (aluop="001100") or (aluop="001101") or (aluop="010101") or (aluop="010101"))then
				nzvc(3) <='1';
				if(result="00000000000000000000000000000000")then
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1)<='0';
				nzvc(0)<='0';
			end if;
		end if;
end process;
end Behavioral;

