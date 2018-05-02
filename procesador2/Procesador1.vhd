library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Procesador1 is
    Port ( CLK_D : in  STD_LOGIC;
           RST_D : in  STD_LOGIC;
           Procesador1_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Procesador1;

architecture Behavioral of Procesador1 is

---modulos

--##################################################
	COMPONENT pc
	PORT(
		address : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;
		clk : IN std_logic;          
		pcout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
--##################################################	
	COMPONENT sumador
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);          
		c : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
--##################################################	
	COMPONENT seu
	PORT(
		imm13 : IN std_logic_vector(12 downto 0);          
		out_seu : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
--##################################################
	COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
--##################################################	
	COMPONENT unidadControl
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		aluop : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
--##################################################
	COMPONENT register_file
	PORT(
		RS1 : IN std_logic_vector(4 downto 0);
		RS2 : IN std_logic_vector(4 downto 0);
		RD : IN std_logic_vector(4 downto 0);
		DWR : IN std_logic_vector(31 downto 0);
		RST : IN std_logic;          
		CRS1 : OUT std_logic_vector(31 downto 0);
		CRS2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT mux 
		PORT ( crs2 : in  std_logic_vector (31 downto 0);
			   seu_out : in  std_logic_vector (31 downto 0);
			   i : in  std_logic;
			   mux_out : out  std_logic_vector (31 downto 0));
	END COMPONENT;	
	
	COMPONENT alu
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);
		op : IN std_logic_vector(5 downto 0);          
		result : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
----------------------------------------------------------------------------------
signal aux: std_logic_vector(31 downto 0):="00000000000000000000000000000001";
signal C_s: std_logic_vector(31 downto 0);
signal npc_out: STD_LOGIC_VECTOR (31 downto 0);
signal c_out: STD_LOGIC_VECTOR (31 downto 0);
signal pc_out_s: STD_LOGIC_VECTOR (31 downto 0);

signal outIM_s: STD_LOGIC_VECTOR (31 downto 0); --- base de todo

signal SEU_s: STD_LOGIC_VECTOR(31 downto 0);
signal UC_s: STD_LOGIC_VECTOR(5 downto 0);

signal CRS1_s: STD_LOGIC_VECTOR(31 downto 0);
signal CRS2_s: STD_LOGIC_VECTOR(31 downto 0);
signal RESULT_s: STD_LOGIC_VECTOR(31 downto 0);


signal MUX_s: STD_LOGIC_VECTOR(31 downto 0);

----------------------------------------------------------------------------------

begin
-- instanciando el pc

adder: sumador PORT MAP(
								a => aux,
								b => npc_out,
								c => c_out
								);
			
npc: pc port map(
								address => c_out,
								rst => RST_D,
								clk => CLK_D,
								pcout => npc_out
								);
								
pc0: pc port map(
								address => npc_out,
								rst => RST_D,
								clk => CLK_D,
								pcout => pc_out_s
								);
								
im: instructionMemory PORT MAP(
								address => pc_out_s,
								reset => RST_D,
								outInstruction => outIM_s
								);
								
seu0: seu port map(
								imm13 => outIM_s(12 downto 0),
								out_seu => SEU_s
								);


uc: unidadControl PORT MAP(
								op => outIM_s(31 downto 30),
								op3 => outIM_s(24 downto 19),
								aluop => UC_s
								);

rf: register_file PORT MAP(
								RS1 => outIM_s(18 downto 14),
								RS2 => outIM_s(4 downto 0),
								RD => outIM_s(29 downto 25),
								DWR => RESULT_s,
								RST => RST_D,
								CRS1 => CRS1_s,
								CRS2 => CRS2_s
								);


mux0: mux PORT MAP(
								crs2 => CRS2_s,
								seu_out => SEU_s,
								i => outIM_s(13),
								mux_out => MUX_s
								);

alu0: alu PORT MAP(
								A => CRS1_s,
								B => MUX_s,
								OP => UC_s,
								RESULT => RESULT_s
								);

Procesador1_out <= RESULT_s;

end Behavioral;
----------------------------------------------------------------------------------

