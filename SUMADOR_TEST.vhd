--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:34:39 04/04/2018
-- Design Name:   
-- Module Name:   C:/Users/utp/arquitectura_procesador1/SUMADOR_TEST.vhd
-- Project Name:  arquitectura_procesador1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Sumador
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY SUMADOR_TEST IS
END SUMADOR_TEST;
 
ARCHITECTURE behavior OF SUMADOR_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sumador
    PORT(
         a : IN  std_logic_vector(32 downto 0);
         b : IN  std_logic_vector(32 downto 0);
         c : OUT  std_logic_vector(32 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(32 downto 0) := (others => '0');
   signal b : std_logic_vector(32 downto 0) := (others => '0');

 	--Outputs
   signal c : std_logic_vector(32 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  -- constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sumador PORT MAP (
          a => a,
          b => b,
          c => c
        );
		  
	a<= '00000000000000001111111111111111' after 20 ns,
		 '00000000000000001111111111111110' after 40 ns,
		 '00000111111100000011110001111111' after 60 ns,
	b<= '00000111111100000011110001111111' after 20 ns,
		 '00000000000000001111111111111110' after 40 ns,
		 '00000000000000001111111111111111' after 60 ns,
END;
