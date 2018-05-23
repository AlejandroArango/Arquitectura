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
		RS1 : IN std_logic_vector(5 downto 0);
		RS2 : IN std_logic_vector(5 downto 0);
		RD : IN std_logic_vector(5 downto 0);
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
		op1 : IN std_logic_vector(31 downto 0);
		op2 : IN std_logic_vector(31 downto 0);
		aluop : IN std_logic_vector(5 downto 0);
		c : in std_logic; 
		result : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

--------------------procesador 2	----------------------------
	
	component windowsManager 
   Port ( 
	 
			  rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  
           cwp : in  STD_LOGIC;
			  
		     ncwp: out std_logic;
           nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrd : out  STD_LOGIC_VECTOR (5 downto 0));
			  
end component;	
	
	
component Psr
    Port ( 
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           ncwp : in  STD_LOGIC;
			  
           cwp : out  STD_LOGIC;
           c : out  STD_LOGIC);
			  
end component;	
	

component PsrModifier 
    Port ( 
			  rst : in  STD_LOGIC;
           crs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           outMux : in  STD_LOGIC_VECTOR (31 downto 0);
           aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           result : in  STD_LOGIC_VECTOR (31 downto 0);
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0));
			  
end component;	
	
----------------------------------------------------------------------------------
signal aux: std_logic_vector(31 downto 0):="00000000000000000000000000000001";
signal C_s: std_logic_vector(31 downto 0);
signal npc_out: STD_LOGIC_VECTOR (31 downto 0);
signal c_out: STD_LOGIC_VECTOR (31 downto 0);
signal pc_out_s: STD_LOGIC_VECTOR (31 downto 0);
-----------------
signal outIM_s: STD_LOGIC_VECTOR (31 downto 0); --- base de todo
-----------------
signal SEU_s: STD_LOGIC_VECTOR(31 downto 0);
signal UC_s: STD_LOGIC_VECTOR(5 downto 0);

signal CRS1_s: STD_LOGIC_VECTOR(31 downto 0);
signal CRS2_s: STD_LOGIC_VECTOR(31 downto 0);
signal RESULT_s: STD_LOGIC_VECTOR(31 downto 0);


signal MUX_s: STD_LOGIC_VECTOR(31 downto 0);

----------------------------------------------------------------------------------
--procesador 2

signal señalnrs1: std_logic_vector(5 downto 0);
signal señalnrs2: std_logic_vector(5 downto 0);
signal señalnrd:  std_logic_vector(5 downto 0);

signal señalcwp:   std_logic;
signal señalncwp:  std_logic;

signal señalc: std_logic;

signal señalnzvc : STD_LOGIC_VECTOR(3 downto 0);

----------------------------------------------------------------------------------

begin
-- instanciando el pc 2
ventanero: windowsManager PORT MAP(
												rs1 => outIM_s (18 downto 14),
												rs2 => outIM_s ( 4 downto  0),
												rd  => outIM_s (29 downto 25),
												op  => outIM_s (31 downto 30),
												op3 => outIM_s (24 downto 19),
												
												cwp => señalcwp,
												
												ncwp =>señalncwp,
												nrs1 =>señalnrs1,
												nrs2 =>señalnrs2,
												nrd  =>señalnrd
												);

processorStateRegister: Psr port map (

			  clk => CLK_D,
           rst => RST_D,
           nzvc => señalnzvc,
           ncwp => señalncwp,
			  
           cwp => señalcwp,
           c => señalc
			  
			  );

processorStateRegisterModifier: PsrModifier port map (

			  rst => RST_D,
			  
           crs1 => CRS1_s,
           outMux => MUX_s,
           aluop => UC_s,
           result => RESULT_s,
			  
           nzvc => señalnzvc
			  );



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
								RS1 => señalnrs1,
								RS2 => señalnrs2,
								RD =>  señalnrd,
								
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
								op1 => CRS1_s,
								op2 => MUX_s,
								aluop => UC_s,
								RESULT => RESULT_s,
								c => señalc
								);

Procesador1_out <= RESULT_s;

end Behavioral;
----------------------------------------------------------------------------------

