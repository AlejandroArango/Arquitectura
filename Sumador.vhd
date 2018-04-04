----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:30:22 04/04/2018 
-- Design Name: 
-- Module Name:    Sumador - Behavioral 
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
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sumador is
    Port ( a : in  STD_LOGIC_VECTOR (32 downto 0);
           b : in  STD_LOGIC_VECTOR (32 downto 0);
           c : out  STD_LOGIC_VECTOR (32 downto 0));
end Sumador;

architecture Behavioral of Sumador is

begin
	process (a,b) IS
	begin
		c<= std_logic_vector(UNSIGNED(a)+ UNSIGNED(b));
	END PROCESS;
end Behavioral;

