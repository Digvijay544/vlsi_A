library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity FIFO is
	 generic(depth:integer:=16);
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Enr : in  STD_LOGIC;
           Enw : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (7 downto 0);
           Dout : out  STD_LOGIC_VECTOR (7 downto 0);
           FifoFull : out  STD_LOGIC;
           FifoEmpty : out  STD_LOGIC);
end FIFO;

architecture Behavioral of FIFO is
type memory_type is array(0 to depth-1)of STD_LOGIC_VECTOR(7 downto 0);
signal memory:memory_type:=(others =>(others =>'0'));
signal readptr,writeptr:integer:=0;
signal empty,full:STD_LOGIC:='1';

begin
	FifoFull<=full;
	FifoEmpty<=empty;
	process(rst,clk)
	variable num:integer:=0;
	begin
		if(rst='1') then
			memory<=(others=>(others =>'0'));
			Dout<=(others =>'0');
			full<='0';
			empty<='1';
			readptr<=0;
			writeptr<=0;
			num:=0;
		elsif(falling_edge(clk))then
			if(Enr='1' AND empty='0')then
				Dout<=memory(readptr);
				readptr<=readptr+1;
				num:=num-1;
			end if;
			if(Enw='1' AND full='0')then
				memory(writeptr)<=Din;
				writeptr<=writeptr+1;
				num:=num-1;
			end if;
			if(readptr=depth-1)then
				readptr<=0;
			end if;
			if(writeptr=depth-1)then
				writeptr<=0;
			end if;
			if(num=0)then
				empty<='1';
			else
				empty<='0';
			end if;
			if(num=depth)then
				full<='1';
			else
				full<='0';
			end if;
		end if;
		end process;
end Behavioral;
