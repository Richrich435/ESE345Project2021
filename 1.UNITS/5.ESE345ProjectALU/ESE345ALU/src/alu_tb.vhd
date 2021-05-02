library ieee;
use ieee.std_logic_1164.all; 
use IEEE.numeric_std.all;
library work;
use work.all;

--Architecture definition

entity alu_tb is 
	end alu_tb;

architecture tb_architecture of alu_tb is


--Stimulus signals 
signal input_1_tb : std_logic_vector (127 downto 0);
signal input_2_tb : std_logic_vector (127 downto 0);
signal input_3_tb : std_logic_vector (127 downto 0);
signal output_tb : std_logic_vector (127 downto 0);
signal ALU_ctrl_tb : std_logic_vector (4 downto 0);	 
signal clk : std_logic;	
constant period : time := 100ns;


		
begin				   
    -- Unit Under Test port map
    UUT: entity alu
    port map (
        input_1 =>input_1_tb,
        input_2 => input_2_tb,
		input_3 => input_3_tb,
		output => output_tb,
		ALU_ctrl => ALU_ctrl_tb 
        );	
	
 test: process  
 
 
	begin  
		
		
	alu_ctrl_tb <= "00000";	
		 
		
	     input_1_tb <= x"0000_0000_0000_0000_0000_0000_0000_0004";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_0000_ffff";
			
		
	wait for period;
		
		
	alu_ctrl_tb <= "00001"; --1		  
	
		--max_overflow_test
		 	
	    input_1_tb <= x"0000_0000_0000_0000_0000_0000_7fff_fffe";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_0000_7fff";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_0000_7fff";

   wait for period;
   
   		--min_overflow_test
   	
		input_1_tb <= x"0000_0000_0000_0000_0000_0000_8000_0001";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_0000_8000";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_0000_7fff"; 
		
	wait for period;
	
		--regular_computation_test
	
		input_1_tb <= x"0000_0000_0000_0000_0000_0000_34d7_0000";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_0000_7000";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_0000_7000";
		
	wait for period;

		
	alu_ctrl_tb <= "00010";	
	
		--max_overflow_test
	
		input_1_tb <= x"0000_0000_0000_0000_0000_0000_7fff_fffe";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_7fff_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_7fff_0000";	 
	
	wait for period; 
	
		--min_overflow_test

		input_1_tb <= x"0000_0000_0000_0000_0000_0000_8000_0001";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_8000_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_7fff_0000";
		
	wait for period;  
	
		--regular_computation_test

		input_1_tb <= x"0000_0000_0000_0000_0000_0000_34d7_0000";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_7000_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_7000_0000";
		
	wait for period;

		
	alu_ctrl_tb <= "00011";	
	
		--max_overflow_test
	
		input_1_tb <= x"0000_0000_0000_0000_0000_0000_7fff_fffe";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_0000_7fff";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_0000_8000";	 
	
	wait for period;
	
		--min_overflow_test

		input_1_tb <= x"0000_0000_0000_0000_0000_0000_8000_0000";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_0000_7fff";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_0000_7fff";
		
	wait for period;  
	
		--regular_computation_test

		input_1_tb <= x"0000_0000_0000_0000_0000_0000_0000_0800";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_0000_007f";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_0000_007f";
		
	wait for period;
		
		
	alu_ctrl_tb <= "00100";
	
		--max_overflow_test
	
		input_1_tb <= x"0000_0000_0000_0000_0000_0000_7fff_fffe";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_7fff_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_8000_0000";	 
	
	wait for period; 
	
		--min_overflow_test

		input_1_tb <= x"0000_0000_0000_0000_0000_0000_8000_0000";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_7fff_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_7fff_0000";
		
	wait for period;  
	
		--regular_computation_test

		input_1_tb <= x"0000_0000_0000_0000_0000_0000_0800_0000";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_0070_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_0070_0000";
		
	wait for period;

		
	alu_ctrl_tb <= "00101";
	
		--max_overflow_test
	
		input_1_tb <= x"0000_0000_0000_0000_7fff_ffff_ffff_fffe";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_7fff_ffff";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_7fff_ffff";	 
	
	wait for period;
	
		--min_overflow_test

		input_1_tb <= x"0000_0000_0000_0000_8000_0000_0000_0001";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_8000_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_7fff_ffff";
		
	wait for period; 
	
		--regular_computation_test

		input_1_tb <= x"0000_0000_0000_0000_34d7_0000_0000_0000";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_7000_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_7000_0000";
		
	wait for period;
		
	alu_ctrl_tb <= "00110";
	
		--max_overflow_test
	
		input_1_tb <= x"0000_0000_0000_0000_7fff_ffff_ffff_fffe";
		
		input_2_tb <= x"0000_0000_0000_0000_7fff_ffff_0000_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_7fff_ffff_0000_0000";	 
	
	wait for period;   
	
		--min_overflow_test

		input_1_tb <= x"0000_0000_0000_0000_8000_0000_0000_0001";
		
		input_2_tb <= x"0000_0000_0000_0000_8000_0000_0000_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_7fff_ffff_0000_0000";
		
	wait for period;
	
		--regular_computation_test
		
		input_1_tb <= x"0000_0000_0000_0000_34d7_0000_0000_0000";
		
		input_2_tb <= x"0000_0000_0000_0000_7000_0000_0000_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_7000_0000_0000_0000";
		
	wait for period;	  
	
		
	alu_ctrl_tb <= "00111";	
	
		--max_overflow_test
	
		input_1_tb <= x"0000_0000_0000_0000_7fff_fffe_ffff_ffff";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_7fff_ffff";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_8000_0000";	 
	
	wait for period;   
	
		--min_overflow_test

		input_1_tb <= x"0000_0000_0000_0000_8000_0000_0000_0000";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_7fff_ffff";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_7fff_ffff";
		
	wait for period;   
	
		--regular_computation_test

		input_1_tb <= x"0000_0000_0000_0000_34d7_0000_0000_0000";
		
		input_2_tb <= x"0000_0000_0000_0000_0000_0000_7000_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_7000_0000";
		
		
	wait for period;	  
	
		
	alu_ctrl_tb <= "01000"; 
	
		--max_overflow_test
	
		input_1_tb <= x"0000_0000_0000_0000_7fff_fffe_ffff_ffff";
		
		input_2_tb <= x"0000_0000_0000_0000_7fff_ffff_0000_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_8000_0000_0000_0000";	 
	
	wait for period;  
	
		--min_overflow_test

		input_1_tb <= x"0000_0000_0000_0000_8000_0000_0000_0000";
		
		input_2_tb <= x"0000_0000_0000_0000_7fff_ffff_0000_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_7fff_ffff_0000_0000";
		
	wait for period;  
	
		--regular_computation_test

		input_1_tb <= x"0000_0000_0000_0000_34d7_0000_0000_0000";
		
		input_2_tb <= x"0000_0000_0000_0000_7000_0000_0000_0000";
		
		input_3_tb <= x"0000_0000_0000_0000_7000_0000_0000_0000";
	
		
	
	wait for period;	  
	
	ALU_ctrl_tb <= "01001"; 
	
	wait for period;
	
	ALU_ctrl_tb <= "01010";		 
	
		input_1_tb <= x"0005_000A_0005_000A_0005_000A_0005_000A";
		
		input_2_tb <= x"000A_0005_000A_0005_000A_0005_000A_0005"; 
		
	wait for period;		   
	
	ALU_ctrl_tb <= "01011"; 		 
	
		input_1_tb <= x"0810_0810_0810_0810_0810_0810_0810_0810";
		
		input_2_tb <= x"1008_1008_1008_1008_1008_1008_1008_1008";
		
		input_3_tb <= x"0000_0000_0000_0000_0000_0000_0000_0000";
			
	wait;
	
    end process;
	
clock: process				-- system clock
	begin
		clk <= '1';				-- clock starts at 0 for 0.5 clock periods
		for i in 0 to 56 loop 			
			wait for period/2;
			clk <= not clk;		-- 15 rising edges
		end loop;
		wait;						-- stop clock
	end process;


end tb_architecture;