LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
 
ENTITY MOD_N_COUNTER_tb IS 
END MOD_N_COUNTER_tb; 
  
ARCHITECTURE behavior OF MOD_N_COUNTER_tb IS  
  
  COMPONENT MOD_N_COUNTER  
    PORT( 
         rst : IN  std_logic; 
			pr  : IN  std_logic; 
         clk : IN  std_logic; 
         dir : IN  std_logic; 
         Q : OUT  std_logic_vector(4 downto 0) 
        ); 
    END COMPONENT; 
     
	signal rst : std_logic := '0'; 
	signal pr  : std_logic := '0'; 
   signal clk : std_logic := '0'; 
   signal dir : std_logic := '0'; 
	signal Q : std_logic_vector(4 downto 0); 
 
   constant clk_period : time := 10 ns; 
  
BEGIN 
  
	uut: MOD_N_COUNTER PORT MAP ( 
          rst => rst, 
			 pr  => pr, 
          clk => clk, 
          dir => dir, 
          Q => Q 
        ); 
 
   clk_process :process 
   begin 
		clk <= '0'; 
		wait for clk_period/2; 
		clk <= '1'; 
		wait for clk_period/2; 
   end process; 
  
	stim_proc_dir: process 
   begin     
		dir <= not(dir); 
		wait for 320 ns; 
   end process; 
 
 
   stim_proc_rst: process 
   begin   
      wait for 680 ns; 
		rst <= '1'; 
		wait for 40 ns; 
		rst <= '0'; 
		wait; 
   end process; 
   
   stim_proc_pr: process 
   begin   
      wait for 750 ns; 
		pr <= '1'; 
		wait for 40 ns; 
		pr <= '0'; 
		wait; 
  end process; 
   
END; 