 library IEEE;
 use IEEE.std_logic_1164.all;
 
 entity IF_ID is 
	 port(
	 instruction_in : in std_logic_vector(24 downto 0);
	 instruction_out : out std_logic_vector(24 downto 0);
	 clk : in std_logic
	 );
 end IF_ID;
 
 
 architecture behavioral of IF_ID is 
 begin 
	 
	 process (instruction_in, clk) is 
	 begin 
		 if rising_edge(clk) then 
			 instruction_out <= instruction_in;
		 end if;
	end process;
	
 end behavioral;
	 