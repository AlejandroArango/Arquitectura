library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    port ( crs2 : in  std_logic_vector (31 downto 0);
           seu_out : in  std_logic_vector (31 downto 0);
           i : in  std_logic;
           mux_out : out  std_logic_vector (31 downto 0));
end mux;

architecture behavioral of mux is

begin
	process(crs2, seu_out, i)
		begin 
			if (i = '1') then
				mux_out <= seu_out;
			else 
				mux_out <= crs2;
			end if;
	end process;

end Behavioral;

