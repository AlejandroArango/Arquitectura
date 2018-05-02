--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:40:40 04/13/2018
-- Design Name:   
-- Module Name:   C:/Users/utp/Xilinx/SysGen/14.7/datapath/adder_test.vhd
-- Project Name:  datapath
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: adder
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY adder_test IS
END adder_test;
 
ARCHITECTURE behavior OF adder_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder
    PORT(
         a : IN  std_logic_vector(31 downto 0);
         b : IN  std_logic_vector(31 downto 0);
         c : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(31 downto 0) := (others => '0');
   signal b : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal c : std_logic_vector(31 downto 0);
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder PORT MAP (
          a => a,
          b => b,
          c => c
        );

   stim_proc: process
   begin		
      a<="00000000000000000000000000000000";
		b<="00000000000000000000000000000000";
      wait for 100 ns;
		a<="00000000000000000000000000000001";
		b<="00000000000000000000000000000000";
      wait for 100 ns;
		a<="00000000000000000000000000000000";
		b<="00000000000000000000000000000001";
      wait for 100 ns;
		a<="00000000000000000000000000000001";
		b<="00000000000000000000000000000001";
      wait for 100 ns;
		a<="00000000000000000000000000000010";
		b<="00000000000000000000000000000000";
      wait for 100 ns;
		a<="00000000000000000000000000000000";
		b<="00000000000000000000000000000010";
      wait for 100 ns;
		a<="00000000000000000000000000000010";
		b<="00000000000000000000000000000010";
      wait for 100 ns;
		a<="00000000000000000000000000000011";
		b<="00000000000000000000000000000000";
      wait for 100 ns;
		a<="00000000000000000000000000000000";
		b<="00000000000000000000000000000011";
      wait for 100 ns;
		a<="00000000000000000000000000000011";
		b<="00000000000000000000000000000011";
      wait for 100 ns;
		a<="00000000000000000000000000000100";
		b<="00000000000000000000000000000000";
      wait for 100 ns;
		
   end process;

END;
