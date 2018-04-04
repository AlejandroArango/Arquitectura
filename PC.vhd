----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:25:40 04/04/2018 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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

entity PC is
    Port ( Adress : in  STD_LOGIC_VECTOR (32 downto 0);
           RST : in  STD_LOGIC_VECTOR (1 downto 0);
           CLK : in  STD_LOGIC_VECTOR (1 downto 0);
           PC_OUT : out  STD_LOGIC_VECTOR (32 downto 0));
end PC;

architecture Behavioral of PC is
begin
	process (CLK,RST)
	begin
		if(RST='1') then:
			PC_OUT<='0000000000000000000000000000000';
		end if;
		if rising_edge(CLK) then:
			PC_OUT<=Adress;
			end if;
end process;		
end Behavioral;

