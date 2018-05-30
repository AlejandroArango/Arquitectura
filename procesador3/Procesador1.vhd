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
	
COMPONENT unidadControl is
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
end COMPONENT;

		
--##################################################
	COMPONENT register_file
	PORT(
				rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
           rst : in  STD_LOGIC;
           dwr : in  STD_LOGIC_VECTOR (31 downto 0);
			  wen : in STD_LOGIC;
			  --CLK : in std_logic;
           crs1 : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
           crs2 : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
			  crd : out STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
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
			  --tener encuenta el icc
			  
			  
			  
end component;	
	

component PsrModifier 
    Port ( 
			  rst : in  STD_LOGIC;--necesitamos rst???
           crs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           outMux : in  STD_LOGIC_VECTOR (31 downto 0);
           aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           result : in  STD_LOGIC_VECTOR (31 downto 0);
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0));
			  
end component;	
	
----------------------------------------------------------------------------------
	
component SEU22 is
    Port ( 
				Data22 : in  STD_LOGIC_VECTOR (21 downto 0);
            Data32 : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end component;	

component SEU30 is
    Port ( 
				Data30 : in  STD_LOGIC_VECTOR (29 downto 0);
				Data32 : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end component;

component MuxCUtoPC is
    Port ( 
				PC30 : in  STD_LOGIC_VECTOR (31 downto 0);
				PC22 : in  STD_LOGIC_VECTOR (31 downto 0);
				PC : in  STD_LOGIC_VECTOR (31 downto 0);
				AluPC : in  STD_LOGIC_VECTOR (31 downto 0);
				PCs : in  STD_LOGIC_VECTOR (1 downto 0);
				nPC : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end component;

component MuxDM_ALUtoRF is
    Port ( 
				DM : in  STD_LOGIC_VECTOR (31 downto 0);
				AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
				PC : in  STD_LOGIC_VECTOR (31 downto 0);
				RFs : in  STD_LOGIC_VECTOR (1 downto 0);
				Data : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end component;

component MuxWM_15toRF is
    Port ( 
				rd : in  STD_LOGIC_VECTOR (5 downto 0);
				reg : in  STD_LOGIC_VECTOR (5 downto 0);
				rfd : in STD_LOGIC;
				nrd : out  STD_LOGIC_VECTOR (5 downto 0) := "000000");
end component;

component DataMemory is
    Port ( 
				cRD : in  STD_LOGIC_VECTOR (31 downto 0);
				AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
				WEn : in  STD_LOGIC;
				REn : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				CLK : in STD_LOGIC;
				Data : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
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
signal señalnrd,Nrd:  std_logic_vector(5 downto 0);

signal señalcwp:   std_logic;
signal señalncwp:  std_logic;

signal señalc, señalrfd: std_logic;

signal señalnzvc,señalicc: STD_LOGIC_VECTOR(3 downto 0);

----------------------------------------------------------------------------------
--procesador 3

signal seu22aux,sum30aux,pc22aux,pc30aux,dmaux,pc22,pc30,sumToMux, muxToRf, crdaux: std_logic_vector (31 downto 0):=(others => '0');
signal señalrfs, señalpcsource: STD_LOGIC_VECTOR(1 downto 0);
signal wenaux, renaux, rfwenaux: std_logic;

----------------------------------------------------------------------------------

begin
-- instanciando el pc 3

SEU22: SEU22 Port map ( 
				Data22 => outIM_s(21 downto 0),--en caso de branch
            Data32 => seu22aux
				);
	

SEU30: SEU30 Port map ( 
				Data30 => outIM_s(29 downto 0),--en caso de call
				Data32 => sum30aux
				);


MuxCUtoPC: MuxCUtoPC Port map ( 
											PC30 => pc30aux,
											PC22 => pc22aux,
											
											PC => sumToMux,
											AluPC => RESULT_s,
											
											PCs => señalpcsource
											nPC => c_out					
											);

MuxDM_ALUtoRF: MuxDM_ALUtoRF port map ( 
													DM => dmaux,
													AluResult => RESULT_s,
													PC => pc_out_s,
													RFs => señalrfs,
													Data => muxToRf
);

MuxWM_15toRF: MuxWM_15toRF Port map( 
													rd => Nrd,
													reg => "001111",-- en caso de call se guarda en o7
													rfd => señalrfd,
													nrd => señalnrd
													);

dataMemory: DataMemory Port map ( 

													cRD => crdaux,
													AluResult => RESULT_s,
													WEn => wenaux,
													REn => renaux,
													rst => RST_D,
													CLK => CLK_D,
													Data => dmaux
													);

sum22: sumador port map(
								a => sum22aux,
								b => pc_out_s,
								c => pc22aux	
								);

sum30: sumador PORT MAP(
								a => aux,
								b => pc_out_s,
								c => pc30aux
								);
								
								
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
												nrd  =>Nrd
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
								c => sumToMux
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
--								
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
								op2 => outIM_s(24 downto 22),
								op3 => outIM_s(24 downto 19),
								icc => señalicc,
								cond => outIM_s(28 downto 25),

								rfs => señalrfs,
								rfd => señalrfd,
								PCs => señalpcsource,
								DMwen => wenaux,
								DMren => renaux,
								RFwen => rfwenaux,
								aluop => UC_s
								);

rf: register_file PORT MAP(
								rs1 => señalnrs1,
								rs2 => señalnrs2,
								rd =>  señalnrd,
								
								dwr => RESULT_s,
								rst => RST_D,
								crs1 => CRS1_s,
								crs2 => CRS2_s,
								
								wen => rfwenaux,
								crd => crdaux						
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

