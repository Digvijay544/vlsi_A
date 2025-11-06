library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
use IEEE.NUMERIC_STD.ALL; 
 
 
entity USR is 
    Port ( rst : in  STD_LOGIC; 
			  clk : in  STD_LOGIC; 
           Sin : in  STD_LOGIC; 
           mode : in  STD_LOGIC_VECTOR (1 downto 0); 
           Pin : in  STD_LOGIC_VECTOR (3 downto 0); 
           Sout : out  STD_LOGIC; 
           Pout : out  STD_LOGIC_VECTOR (3 downto 0) 
     ); 
end USR; 
 
architecture USR_arch of USR is 
SIGNAL temp : STD_LOGIC_VECTOR (3 downto 0):="0000"; 
 begin 
  PROCESS(rst, clk, mode, Sin, Pin) 
  BEGIN 
   IF rst = '1' THEN 
    Pout <= "0000"; 
    Sout <= '0'; 
    
   ELSIF FALLING_EDGE(clk) THEN 
     
    CASE mode IS  
     
     WHEN "00" =>  --serial in serial out
      temp(3 downto 1) <= temp(2 downto 0); 
      temp(0) <= Sin;     
  
      Sout <= temp(3); 
      Pout <= "0000"; 
      
     WHEN "01" =>  --serial in parallel out
      temp(3 downto 1) <= temp(2 downto 0); 
      temp(0) <= Sin; 
      Pout <= temp; 
      Sout <= '0'; 
       
     WHEN "10" =>  --parallel in serial out
      temp <= Pin; 
      Sout <= temp(3); 
      temp(3 downto 1) <= temp(2 downto 0); 
  
      Pout <= "0000"; 
       
     WHEN OTHERS => --parallel in parallel out
      Pout <= Pin; 
      Sout <= '0'; 
    
    END CASE; 
   END IF; 
  END PROCESS; 
 
end USR_arch;