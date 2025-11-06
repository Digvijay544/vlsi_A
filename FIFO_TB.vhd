LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY FIFO_TB IS
END FIFO_TB;
 
ARCHITECTURE behavior OF FIFO_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FIFO
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         Enr : IN  std_logic;
         Enw : IN  std_logic;
         Din : IN  std_logic_vector(7 downto 0);
         Dout : OUT  std_logic_vector(7 downto 0);
         FifoFull : OUT  std_logic;
         FifoEmpty : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal Enr : std_logic := '0';
   signal Enw : std_logic := '0';
   signal Din : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Dout : std_logic_vector(7 downto 0) := (others => '0');
   signal FifoFull : std_logic :='0';
   signal FifoEmpty : std_logic :='0';

	signal i :integer:=0;
   -- Clock period definitions
   constant clk_period : time := 10 ns;
	constant depth : integer :=16;
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FIFO PORT MAP (
          rst => rst,
          clk => clk,
          Enr => Enr,
          Enw => Enw,
          Din => Din,
          Dout => Dout,
          FifoFull => FifoFull,
          FifoEmpty =>FifoEmpty
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst<='1';
      wait for clk_period;
		rst<='0';
      wait for clk_period*3;
		Enw<='1';
		Enr<='0';
		for i in 1 to 10 loop
			Din<=conv_std_logic_vector(i,8);
			wait for clk_period;
		end loop;
		Enw<='0';
		Enr<='1';
		wait for clk_period*4;
		Enw<='0';
		Enr<='0';
		wait for clk_period*10;
		
		Enw<='1';
		Enr<='0';
		for i in 11 to 20 loop
			Din<=conv_std_logic_vector(i,8);
			wait for clk_period;
		end loop;
		Enw<='0';
		Enr<='0';
		wait for clk_period*10;
		Enw<='0';
		Enr<='1';
		wait for clk_period*4;
		Enw<='0';
		Enr<='0';
		wait for clk_period;
		Enw<='0';
		Enr<='1';
		wait for clk_period*8;
		Enw<='0';
		Enr<='0';
		wait for clk_period;
		Enw<='0';
		Enr<='1';
		wait for clk_period*4;
		Enw<='0';
		Enr<='0';
		wait for clk_period;
		Enw<='0';
		Enr<='1';
		wait for clk_period*4;
		Enw<='0';
		Enr<='0';
		wait;
   end process;

END;
