-------------------------------------------------------------------------------
--
-- Title       : alu_tb
-- Design      : ESE345ALU
-- Author      : richard ma
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\richard ma\Desktop\ESE345PROJECT2021\ESE345ProjectALU\ESE345ALU\src\ESE345ALUTB.vhd
-- Generated   : Fri Mar 26 17:36:27 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {alu_tb} architecture {tb_architecture}}

library IEEE;
use IEEE.std_logic_1164.all; 
library work;
use work.all;

entity alu_tb is
end alu_tb;	 
		

--} End of automatically maintained section

architecture tb_architecture of alu_tb is		 

signal input_1_tb : std_logic_vector (127 downto 0);
signal input_2_tb : std_logic_vector (127 downto 0);
signal input_3_tb : std_logic_vector (127 downto 0);
signal input_constant_tb : std_logic_vector(4 downto 0);
signal output_tb : std_logic_vector (127 downto 0);
signal alu_ctrl_tb : std_logic_vector (4 downto 0);	 
signal clk : std_logic;	
constant period : time := 100ns;

begin				   
    -- Unit Under Test port map
    UUT: entity alu
	    port map (
	        input_1 =>input_1_tb,
	        input_2 => input_2_tb,
			input_3 => input_3_tb,
			input_constant => input_constant_tb,
			output => output_tb,
			alu_ctrl => alu_ctrl_tb
	        );	
		

	
 test: process
 variable offset : integer;
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
--
--wait for period;
	
-- This is AHU 
ALU_ctrl_tb <= "01100";
input_1_tb(15 downto 0) <= x"34D7";		  
input_2_tb(15 downto 0) <= x"54CD";
input_1_tb(31 downto 16) <= x"34D7";		  
input_2_tb(31 downto 16) <= x"54CD";
input_1_tb(47 downto 32) <= x"34D7";		  
input_2_tb(47 downto 32) <= x"54CD";
input_1_tb(63 downto 48) <= x"34D7";		  
input_2_tb(63 downto 48) <= x"54CD";
input_1_tb(79 downto 64) <= x"34D7";		  
input_2_tb(79 downto 64) <= x"54CD";
input_1_tb(95 downto 80) <= x"34D7";		  
input_2_tb(95 downto 80) <= x"54CD";
input_1_tb(111 downto 96) <= x"34D7";		  
input_2_tb(111 downto 96) <= x"54CD";
input_1_tb(127 downto 112) <= x"34D7";		  
input_2_tb(127 downto 112) <= x"54CD";

wait for 100ns;

ALU_ctrl_tb <= "01101";  --AHS Add with Saturation			
input_1_tb(15 downto 0) <= x"7FFE";		  
input_2_tb(15 downto 0) <= x"7FFE";
input_1_tb(31 downto 16) <= x"7FFE";		  
input_2_tb(31 downto 16) <= x"7FFE";
input_1_tb(47 downto 32) <= x"7FFE";		  
input_2_tb(47 downto 32) <= x"7FFE";
input_1_tb(63 downto 48) <= x"7FFE";		  
input_2_tb(63 downto 48) <= x"7FFE";
input_1_tb(79 downto 64) <= x"7FFE";		  
input_2_tb(79 downto 64) <= x"7FFE";
input_1_tb(95 downto 80) <= x"7FFE";		  
input_2_tb(95 downto 80) <= x"7FFE";
input_1_tb(111 downto 96) <= x"7FFE";		  
input_2_tb(111 downto 96) <= x"7FFE";
input_1_tb(127 downto 112) <= x"7FFE";		  
input_2_tb(127 downto 112) <= x"7FFE"; 

wait for 100ns;
input_1_tb(15 downto 0) <= x"8001";		  
input_2_tb(15 downto 0) <= x"8001";
input_1_tb(31 downto 16) <= x"8001";		  
input_2_tb(31 downto 16) <= x"8001";
input_1_tb(47 downto 32) <= x"8001";		  
input_2_tb(47 downto 32) <= x"8001";
input_1_tb(63 downto 48) <= x"8001";		  
input_2_tb(63 downto 48) <= x"8001";
input_1_tb(79 downto 64) <= x"8001";		  
input_2_tb(79 downto 64) <= x"8001";
input_1_tb(95 downto 80) <= x"8001";		  
input_2_tb(95 downto 80) <= x"8001";
input_1_tb(111 downto 96) <= x"8001";		  
input_2_tb(111 downto 96) <= x"8001";
input_1_tb(127 downto 112) <= x"8001";		  
input_2_tb(127 downto 112) <= x"8001"; 	

wait for 100ns;

input_1_tb(15 downto 0) <= x"34D7";		  
input_2_tb(15 downto 0) <= x"24CD";
input_1_tb(31 downto 16) <= x"34D7";		  
input_2_tb(31 downto 16) <= x"24CD";
input_1_tb(47 downto 32) <= x"34D7";		  
input_2_tb(47 downto 32) <= x"24CD";
input_1_tb(63 downto 48) <= x"34D7";		  
input_2_tb(63 downto 48) <= x"24CD";
input_1_tb(79 downto 64) <= x"34D7";		  
input_2_tb(79 downto 64) <= x"24CD";
input_1_tb(95 downto 80) <= x"34D7";		  
input_2_tb(95 downto 80) <= x"24CD";
input_1_tb(111 downto 96) <= x"34D7";		  
input_2_tb(111 downto 96) <= x"24CD";
input_1_tb(127 downto 112) <= x"34D7";		  
input_2_tb(127 downto 112) <= x"24CD"; 	


	

	
wait for 100ns;
ALU_ctrl_tb <= "01110";  --Logical AND
	for i in 0 to 7 loop
		offset := 16 * i;
		input_1_tb((15 + offset) downto (0 + offset)) <= x"34D7";
		input_2_tb((15 + offset) downto (0 + offset)) <= x"54CD";
		end loop;

wait for 100ns;
		
ALU_ctrl_tb <= "01111";	--BroadCast Word 1 to 4 Words
input_1_tb(31 downto 0) <= x"34D7_54CD";

wait for 100ns;

ALU_ctrl_tb <= "10000";	--Max Signed Word 
	input_1_tb(31 downto 0) <= x"34D7_54CD";
	input_2_tb(31 downto 0) <= x"34D7_5504";   
	input_1_tb(63 downto 32) <= x"34D7_54CD";
	input_2_tb(63 downto 32) <= x"34D7_5504"; 
	input_1_tb(95 downto 64) <= x"34D7_54CD";
	input_2_tb(95 downto 64) <= x"34D7_5504"; 
	input_1_tb(127 downto 96) <= x"34D7_54CD";
	input_2_tb(127 downto 96) <= x"34D7_5504"; 

wait for 100ns;

ALU_ctrl_tb <= "10001";	--Min Signed Word
	input_1_tb(31 downto 0) <= x"34D7_54CD";
	input_2_tb(31 downto 0) <= x"34D7_5504";
	input_1_tb(63 downto 32) <= x"34D7_54CD";
	input_2_tb(63 downto 32) <= x"34D7_5504"; 
	input_1_tb(95 downto 64) <= x"34D7_54CD";
	input_2_tb(95 downto 64) <= x"34D7_5504"; 
	input_1_tb(127 downto 96) <= x"34D7_54CD";
	input_2_tb(127 downto 96) <= x"34D7_5504"; 

wait for 100ns;

ALU_ctrl_tb <= "10010";	   --MLHU	 Multiply Low Unsigned
	input_1_tb <= x"0000_0000_0000_0000_0000_0000_0000_0000"; 
	input_2_tb <= x"0000_0000_0000_0000_0000_0000_0000_0000";
wait for 100ns;
	input_1_tb(15 downto 0) <= x"34D7";
	input_2_tb(15 downto 0) <= x"54CD";
	input_1_tb(47 downto 32) <= x"34D7";
	input_2_tb(47 downto 32) <= x"54CD";
	input_1_tb(79 downto 64) <= x"34D7";
	input_2_tb(79 downto 64) <= x"54CD";   
	input_1_tb(111 downto 96) <= x"34D7";
	input_2_tb(111 downto 96) <= x"54CD";	   

wait for 100ns;

ALU_ctrl_tb <= "10011";    --Multiply Low by Constant Unsigned
input_1_tb(15 downto 0) <= x"34D7";
   
wait for 100ns;
	
ALU_ctrl_tb <= "10100";	 --Logical OR operation
 	for i in 0 to 7 loop
		offset := 16 * i;
		input_1_tb((15 + offset) downto (0 + offset)) <= x"34D7";
		input_2_tb((15 + offset) downto (0 + offset)) <= x"54CD";
	end loop; 

wait for 100ns;	

ALU_ctrl_tb <= "10101";	  --PCNTW Count Ones in Words 
input_1_tb <= x"0000_0000_0000_0000_0000_0000_0000_0000";
input_2_tb <= x"0000_0000_0000_0000_0000_0000_0000_0000";	   	 
wait for 100ns;
input_1_tb(31 downto 0) <= x"0000_0000";
wait for 100ns;
input_1_tb(63 downto 0) <= x"0000_0002_0000_0007";

wait for 100ns;

ALU_ctrl_tb <= "10110";		  --ROTW	  Rotate Bits in Word 

input_1_tb(31 downto 0) <= x"0000_0002";
input_1_tb(63 downto 32) <= x"0000_0002";
input_1_tb(95 downto 64) <= x"0000_0002";
input_1_tb(127 downto 96) <= x"0000_0002";
input_2_tb(31 downto 0) <= x"0000_0005"; 
input_2_tb(63 downto 32) <= x"0000_0005";
input_2_tb(95 downto 64) <= x"0000_0005";
input_2_tb(127 downto 96) <= x"0000_0005";

wait for 100ns;

ALU_ctrl_tb <= "10111";				--SFHS	 Subtract from Halfword Saturated	  
input_1_tb(15 downto 0) <= x"8001";		  
input_2_tb(15 downto 0) <= x"7FFE";
input_1_tb(31 downto 16) <= x"8001";		  
input_2_tb(31 downto 16) <= x"7FFE";
input_1_tb(47 downto 32) <= x"8001";		  
input_2_tb(47 downto 32) <= x"7FFE";
input_1_tb(63 downto 48) <= x"8001";		  
input_2_tb(63 downto 48) <= x"7FFE";
input_1_tb(79 downto 64) <= x"8001";		  
input_2_tb(79 downto 64) <= x"7FFE";
input_1_tb(95 downto 80) <= x"8001";		  
input_2_tb(95 downto 80) <= x"7FFE";
input_1_tb(111 downto 96) <= x"8001";		  
input_2_tb(111 downto 96) <= x"7FFE";
input_1_tb(127 downto 112) <= x"8001";		  
input_2_tb(127 downto 112) <= x"7FFE"; 

wait for 100ns;
input_1_tb(15 downto 0) <= x"7FFE";		  
input_2_tb(15 downto 0) <= x"8001";
input_1_tb(31 downto 16) <= x"7FFE";		  
input_2_tb(31 downto 16) <= x"8001";
input_1_tb(47 downto 32) <= x"7FFE";		  
input_2_tb(47 downto 32) <= x"8001";
input_1_tb(63 downto 48) <= x"7FFE";		  
input_2_tb(63 downto 48) <= x"8001";
input_1_tb(79 downto 64) <= x"7FFE";		  
input_2_tb(79 downto 64) <= x"8001";
input_1_tb(95 downto 80) <= x"7FFE";		  
input_2_tb(95 downto 80) <= x"8001";
input_1_tb(111 downto 96) <= x"7FFE";		  
input_2_tb(111 downto 96) <= x"8001";
input_1_tb(127 downto 112) <= x"7FFE";		  
input_2_tb(127 downto 112) <= x"8001"; 	

wait for 100ns;

input_1_tb(15 downto 0) <= x"34D7";		  
input_2_tb(15 downto 0) <= x"24CD";
input_1_tb(31 downto 16) <= x"34D7";		  
input_2_tb(31 downto 16) <= x"24CD";
input_1_tb(47 downto 32) <= x"34D7";		  
input_2_tb(47 downto 32) <= x"24CD";
input_1_tb(63 downto 48) <= x"34D7";		  
input_2_tb(63 downto 48) <= x"24CD";
input_1_tb(79 downto 64) <= x"34D7";		  
input_2_tb(79 downto 64) <= x"24CD";
input_1_tb(95 downto 80) <= x"34D7";		  
input_2_tb(95 downto 80) <= x"24CD";
input_1_tb(111 downto 96) <= x"34D7";		  
input_2_tb(111 downto 96) <= x"24CD";
input_1_tb(127 downto 112) <= x"34D7";		  
input_2_tb(127 downto 112) <= x"24CD";
wait for 100ns;

ALU_ctrl_tb <= "11000";			--SFW	 Subtract from Word Unsigned
input_1_tb <= x"0005_000A_0005_000A_0005_000A_0005_000A";
input_2_tb <= x"000A_0005_000A_0005_000A_0005_000A_0005"; 


wait;
    end process;
	
clock: process				-- system clock
	begin
		clk <= '1';				-- clock starts at 0 for 0.5 clock periods
		for i in 0 to 28 loop 			
			wait for period/2;
			clk <= not clk;		-- 15 rising edges
		end loop;
		wait;						-- stop clock
	end process;


end tb_architecture;