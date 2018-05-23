--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:07:59 04/19/2018
-- Design Name:   
-- Module Name:   C:/Users/Diego/Downloads/Activador auto pico/procesador1/processor/procesador_prueba.vhd
-- Project Name:  processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Procesador1
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
 
ENTITY procesador_prueba IS
END procesador_prueba;
 
ARCHITECTURE behavior OF procesador_prueba IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Procesador1
    PORT(
         CLK_D : IN  std_logic;
         RST_D : IN  std_logic;
         Procesador1_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_D : std_logic := '0';
   signal RST_D : std_logic := '0';

 	--Outputs
   signal Procesador1_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_D_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Procesador1 PORT MAP (
          CLK_D => CLK_D,
          RST_D => RST_D,
          Procesador1_out => Procesador1_out
        );

   -- Clock process definitions
   CLK_D_process :process
   begin
		CLK_D <= '0';
		wait for CLK_D_period/2;
		CLK_D <= '1';
		wait for CLK_D_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      RST_D <= '0';
      wait for 100 ns;	
		RST_D <= '1';
      wait for 100 ns;	
		RST_D <= '0';
      wait for 100 ns;	

      wait;
   end process;

END;
