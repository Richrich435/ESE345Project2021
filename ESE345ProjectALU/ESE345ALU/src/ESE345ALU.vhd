-------------------------------------------------------------------------------
--
-- Title       : alu
-- Design      : ESE345ALU
-- Author      : richard ma
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : E:\richard ma\ESE345Spring2021\ESE345Project\ESE345ProjectALU\ESE345ALU\src\ESE345ALU.vhd
-- Generated   : Mon Mar  8 15:15:18 2021
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
--{entity {alu} architecture {alu_architecture}}

library IEEE;
use IEEE.std_logic_1164.all;	   	  
use IEEE.numeric_std.all;
                                              

entity alu is
	 port(
		 input_1 : in STD_LOGIC_VECTOR(127 downto 0);
		 input_2 : in STD_LOGIC_VECTOR(127 downto 0);
		 input_3 : in STD_LOGIC_VECTOR(127 downto 0); 
		 input_constant : in STD_LOGIC_VECTOR(4 downto 0);
		 output : out STD_LOGIC_VECTOR(127 downto 0);
		 alu_ctrl : in STD_LOGIC_VECTOR(4 downto 0);
		 load_index_msb: out std_logic_vector(6 downto 0);
		 load_index_lsb: out std_logic_vector(6 downto 0)
	     );
end alu;

--}} End of automatically maintained section

architecture alu_architecture of alu is	 
	signal temp_16_1 : std_logic_vector(15 downto 0);
	signal temp_16_2 : std_logic_vector(15 downto 0); 
	signal temp_16_3 : std_logic_vector(15 downto 0);
	signal temp_16_4 : std_logic_vector(15 downto 0);
	
	signal temp_32_1 : std_logic_vector(31 downto 0);	
	signal temp_32_2 : std_logic_vector(31 downto 0);
	signal temp_32_3 : std_logic_vector(31 downto 0);
	signal temp_32_4 : std_logic_vector(31 downto 0);
	signal temp_32_5 : std_logic_vector(31 downto 0);
	signal temp_32_6 : std_logic_vector(31 downto 0);
	signal temp_32_7 : std_logic_vector(31 downto 0);
	signal temp_32_8 : std_logic_vector(31 downto 0);
	signal temp_64_1 : std_logic_vector(63 downto 0);
	signal temp_64_2 : std_logic_vector(63 downto 0);
	signal temp_64_3 : std_logic_vector(63 downto 0);
	signal temp_64_4 : std_logic_vector(63 downto 0);


 --ALL R4 instructions need to be saturated, implement this  
begin
	process(input_1, input_2, input_3, ALU_ctrl)
		variable offset : integer;
		variable temp_5 : std_logic_vector(4 downto 0);
		variable temp_8_1, temp_8_2, temp_8_3 : std_logic_vector(7 downto 0);
		variable temp_16_1 : std_logic_vector(15 downto 0);
		variable temp_16_2 : std_logic_vector(15 downto 0); 
		variable temp_16_3 : std_logic_vector(15 downto 0);
		variable temp_16_4 : std_logic_vector(15 downto 0);
		variable temp_16_5 : std_logic_vector(15 downto 0);
		variable temp_16_6 : std_logic_vector(15 downto 0);
		variable temp_16_7 : std_logic_vector(15 downto 0);
		variable temp_16_8 : std_logic_vector(15 downto 0);
		variable temp_16_9 : std_logic_vector(15 downto 0);
		variable temp_16_10 : std_logic_vector(15 downto 0);
		variable temp_16_11 : std_logic_vector(15 downto 0);
		variable temp_16_12 : std_logic_vector(15 downto 0);
		variable temp_17_1	: signed(16 downto 0);	
		variable temp_17_2	: signed(16 downto 0);
		variable temp_17_3	: signed(16 downto 0);
		
		variable temp_32_1 : std_logic_vector(31 downto 0);	
		variable temp_32_2 : std_logic_vector(31 downto 0);
		variable temp_32_3 : std_logic_vector(31 downto 0);
		variable temp_32_4 : std_logic_vector(31 downto 0);
		variable temp_32_5 : std_logic_vector(31 downto 0);
		variable temp_32_6 : std_logic_vector(31 downto 0);	
		variable temp_32_7 : std_logic_vector(31 downto 0);
		variable temp_32_8 : std_logic_vector(31 downto 0);
		
		variable temp_64_1 : std_logic_vector(63 downto 0);
		variable temp_64_2 : std_logic_vector(63 downto 0);
		variable temp_64_3 : std_logic_vector(63 downto 0);
		variable temp_64_4 : std_logic_vector(63 downto 0);
		variable temp_64_5 : std_logic_vector(63 downto 0);
		variable temp_64_6 : std_logic_vector(63 downto 0);
		variable temp_64_7 : std_logic_vector(63 downto 0);	 
		variable integerValue: integer;
		variable carry_out: std_logic; 			   --make carry out a vector(8 bits) and then assign the bit based on the iteration of the for loop(for debugging purposes)
		constant max_16 : std_logic_vector(15 downto 0) := "0111111111111111";
		constant min_16 : std_logic_vector(15 downto 0) := "1000000000000000"; 
		variable zeros : std_logic_vector(31 downto 0);	
		variable count : integer := 0;
		constant valueOfTwo : std_logic_vector(4 downto 0) := "00010";
		constant max_integer: std_logic_vector(31 downto 0):= X"7FFFFFFF"; 
	    constant min_integer: std_logic_vector(31 downto 0) := X"80000000";
	    constant max_long: std_logic_vector(63 downto 0):= X"7FFFFFFFFFFFFFFF"; 
	    constant min_long: std_logic_vector(63 downto 0) := X"8000000000000000";
											
		begin  
			case std_logic_vector(ALU_ctrl) is	 		
			 --Load Immediate 
			when "00000" =>
			--input_1 will have the load index at the 3 LSBs
			--input_2 will have the immediate at the 16 LSBs 		
			offset := to_integer(unsigned(input_1(2 downto 0))) * 16;
			load_index_msb <= std_logic_vector(to_unsigned((15 + offset), 7)); 
			load_index_lsb <= std_logic_vector(to_unsigned((0 + offset), 7)); 
			output <= (others => '0');
			output((15 + offset) downto (0 + offset)) <= input_2(15 downto 0);
			
			
	--SATURATION: keep note of the signage of our addends 
		  	-- consider positive and negative overflow (for example in additon (POS plus POS can only cause positive overflow) and (NEG plus NEG can only cause negative overflow)
			--check the leftmost bit			

			
----			--Signed Integer Multiply-Add Low with Saturation [seems to work] 		
			when "00001" =>	
				for i in 0 to 3 loop			    
					offset := 32*i;	
			   		temp_16_1 := input_3((15 + offset) downto (0 + offset)); 
			   		temp_16_2 := input_2((15 + offset) downto (0 + offset));
					temp_32_1 := input_1((31 + offset) downto (0 + offset));
					temp_32_2 := std_logic_vector((signed(temp_16_1) * signed(temp_16_2)));
					temp_32_3 := std_logic_vector(signed(temp_32_1) + signed(temp_32_2)); 	   
					if ((temp_32_1(31) = '0') and (temp_32_2(31) = '0') and (temp_32_3(31) /= '0')) then -- both positive but there's a 1 at MSB	
						output((31 + offset) downto (0 + offset)) <= max_integer;
					elsif ((temp_32_1(31) = '1') and (temp_32_2(31) = '1') and (temp_32_3(31) /= '1')) then --both negative but there's a 0 at MSB		
						output((31 + offset) downto (0 + offset)) <= min_integer;  
					else 
						output((31 + offset) downto (0 + offset)) <= temp_32_3; 
					end if;
				end loop;	
				
			---Signed Integer Multiply-Add High with Saturation	 [seems to work]  
			when "00010" =>	
				for i in 0 to 3 loop			    
					offset := 32*i;	
			   		temp_16_1 := input_3((31 + offset) downto (16 + offset)); 
			   		temp_16_2 := input_2((31 + offset) downto (16 + offset));
					temp_32_1 := input_1((31 + offset) downto (0 + offset));
					temp_32_2 := std_logic_vector((signed(temp_16_1) * signed(temp_16_2)));
					temp_32_3 := std_logic_vector(signed(temp_32_1) + signed(temp_32_2)); 	   
					if ((temp_32_1(31) = '0') and (temp_32_2(31) = '0') and (temp_32_3(31) /= '0')) then -- both positive but there's a 1 at MSB	
						output((31 + offset) downto (0 + offset)) <= max_integer;
					elsif ((temp_32_1(31) = '1') and (temp_32_2(31) = '1') and (temp_32_3(31) /= '1')) then --both negative but there's a 0 at MSB		
						output((31 + offset) downto (0 + offset)) <= min_integer;  
					else 
						output((31 + offset) downto (0 + offset)) <= temp_32_3; 
					end if;
				end loop;
									
				---signed integer multiply-subtract low with saturation [saturation works, make sure normal numbers work]
			 when "00011" =>	
				for i in 0 to 3 loop			    
					offset := 32*i;	
			   		temp_16_1 := input_3((15 + offset) downto (0 + offset)); 
			   		temp_16_2 := input_2((15 + offset) downto (0 + offset));
					temp_32_1 := input_1((31 + offset) downto (0 + offset));
					temp_32_2 := std_logic_vector((signed(temp_16_1) * signed(temp_16_2)));
					temp_32_3 := std_logic_vector(signed(temp_32_1) - signed(temp_32_2)); 	   
					if ((temp_32_1(31) = '0') and (temp_32_2(31) = '1') and (temp_32_3(31) /= '0')) then -- both positive but there's a 1 at MSB	
						output((31 + offset) downto (0 + offset)) <= max_integer;
					elsif ((temp_32_1(31) = '1') and (temp_32_2(31) = '0') and (temp_32_3(31) /= '1')) then --both negative but there's a 0 at MSB		
						output((31 + offset) downto (0 + offset)) <= min_integer;  
					else 
						output((31 + offset) downto (0 + offset)) <= temp_32_3; 
					end if;
				end loop;
				
			---Signed Integer Multiply-Subtract High with Saturation
			when "00100" =>
				for i in 0 to 3 loop			    
					offset := 32*i;	
			   		temp_16_1 := input_3((31 + offset) downto (16 + offset)); 
			   		temp_16_2 := input_2((31 + offset) downto (16 + offset));
					temp_32_1 := input_1((31 + offset) downto (0 + offset));
					temp_32_2 := std_logic_vector((signed(temp_16_1) * signed(temp_16_2)));
					temp_32_3 := std_logic_vector(signed(temp_32_1) - signed(temp_32_2)); 	   
					if ((temp_32_1(31) = '0') and (temp_32_2(31) = '1') and (temp_32_3(31) /= '0')) then -- both become positive but there's a 1 at MSB	
						output((31 + offset) downto (0 + offset)) <= max_integer;
					elsif ((temp_32_1(31) = '1') and (temp_32_2(31) = '0') and (temp_32_3(31) /= '1')) then --both become negative but there's a 0 at MSB		
						output((31 + offset) downto (0 + offset)) <= min_integer;  
					else 
						output((31 + offset) downto (0 + offset)) <= temp_32_3; 
					end if;
				end loop;
				
			
			--Signed Long Integer Multiply-Add Low with Saturation
			when "00101" =>
				for i in 0 to 1 loop			    
					offset := 64*i;	
			   		temp_32_1 := input_3((31 + offset) downto (0 + offset)); 
			   		temp_32_2 := input_2((31 + offset) downto (0 + offset));
					temp_64_1 := input_1((63 + offset) downto (0 + offset));
					temp_64_2 := std_logic_vector((signed(temp_32_1) * signed(temp_32_2)));
					temp_64_3 := std_logic_vector(signed(temp_64_1) + signed(temp_64_2)); 	   
					if ((temp_64_1(63) = '0') and (temp_64_2(63) = '0') and (temp_64_3(63) /= '0')) then -- both positive but there's a 1 at MSB	
						output((63 + offset) downto (0 + offset)) <= max_long;
					elsif ((temp_64_1(63) = '1') and (temp_64_2(63) = '1') and (temp_64_3(63) /= '1')) then --both negative but there's a 0 at MSB		
						output((63 + offset) downto (0 + offset)) <= min_long;  
					else 
						output((63 + offset) downto (0 + offset)) <= temp_64_3; 
					end if;
				end loop; 
			--Signed Long Integer Multiply-Add High with Saturation	  
			when "00110" =>	 
				for i in 0 to 1 loop			    
					offset := 64*i;	
			   		temp_32_1 := input_3((63 + offset) downto (32 + offset)); 
			   		temp_32_2 := input_2((63 + offset) downto (32 + offset));
					temp_64_1 := input_1((63 + offset) downto (0 + offset));
					temp_64_2 := std_logic_vector((signed(temp_32_1) * signed(temp_32_2)));
					temp_64_3 := std_logic_vector(signed(temp_64_1) + signed(temp_64_2)); 	   
					if ((temp_64_1(63) = '0') and (temp_64_2(63) = '0') and (temp_64_3(63) /= '0')) then -- both positive but there's a 1 at MSB	
						output((63 + offset) downto (0 + offset)) <= max_long;
					elsif ((temp_64_1(63) = '1') and (temp_64_2(63) = '1') and (temp_64_3(63) /= '1')) then --both negative but there's a 0 at MSB		
						output((63 + offset) downto (0 + offset)) <= min_long;  
					else 
						output((63 + offset) downto (0 + offset)) <= temp_64_3; 
					end if;
				end loop; 
				
		
			--Signed Long Integer Multiply-Subtract Low with Saturation	
			when "00111" =>
				for i in 0 to 1 loop			    
					offset := 64*i;	
			   		temp_32_1 := input_3((31 + offset) downto (0 + offset)); 
			   		temp_32_2 := input_2((31 + offset) downto (0 + offset));
					temp_64_1 := input_1((63 + offset) downto (0 + offset));
					temp_64_2 := std_logic_vector((signed(temp_32_1) * signed(temp_32_2)));
					temp_64_3 := std_logic_vector(signed(temp_64_1) - signed(temp_64_2)); 	   
					if ((temp_64_1(63) = '0') and (temp_64_2(63) = '1') and (temp_64_3(63) /= '0')) then -- both become positive but there's a 1 at MSB	
						output((63 + offset) downto (0 + offset)) <= max_long;
					elsif ((temp_64_1(63) = '1') and (temp_64_2(63) = '0') and (temp_64_3(63) /= '1')) then --both become negative but there's a 0 at MSB		
						output((63 + offset) downto (0 + offset)) <= min_long;  
					else 
						output((63 + offset) downto (0 + offset)) <= temp_64_3; 
					end if;
				end loop;
			
			--Signed Long Integer Multiply-Subtract High with Saturation	
			when "01000" =>
				for i in 0 to 1 loop			    
					offset := 64*i;	
			   		temp_32_1 := input_3((63 + offset) downto (32 + offset)); 
			   		temp_32_2 := input_2((63 + offset) downto (32 + offset));
					temp_64_1 := input_1((63 + offset) downto (0 + offset));
					temp_64_2 := std_logic_vector((signed(temp_32_1) * signed(temp_32_2)));
					temp_64_3 := std_logic_vector(signed(temp_64_1) - signed(temp_64_2)); 	   
					if ((temp_64_1(63) = '0') and (temp_64_2(63) = '1') and (temp_64_3(63) /= '0')) then -- both become positive but there's a 1 at MSB	
						output((63 + offset) downto (0 + offset)) <= max_long;
					elsif ((temp_64_1(63) = '1') and (temp_64_2(63) = '0') and (temp_64_3(63) /= '1')) then --both become negative but there's a 0 at MSB		
						output((63 + offset) downto (0 + offset)) <= min_long;  
					else 
						output((63 + offset) downto (0 + offset)) <= temp_64_3; 
					end if;
				end loop;  
			
				
			--NOP
			when "01001" =>	
				Null;
				
			-- Add Word Unsigned	
			when "01010" =>
				for i in 0 to 3 loop			    
					offset := 32*i;	
			   		temp_32_1 := input_1((31 + offset) downto (0 + offset)); 
			   		temp_32_2 := input_2((31 + offset) downto (0 + offset)); 
					temp_32_3 := std_logic_vector(unsigned(temp_32_1) + unsigned(temp_32_2)); 	   
					output((31 + offset) downto (0 + offset)) <= temp_32_3; 
				end loop; 
				
		  --Absolute Difference of Bytes
		   when "01011" =>
				for i in 0 to 15 loop			    
					offset := 8*i;	
			   		temp_8_1 := input_1((7 + offset) downto (0 + offset)); 
			   		temp_8_2 := input_2((7 + offset) downto (0 + offset)); 
					temp_8_3 := std_logic_vector(abs(signed(temp_8_1) - signed(temp_8_2))); 
					output((7 + offset) downto (0 + offset)) <= temp_8_3; 
				end loop;

			--AHU Add Halfword Unsigned
			when "01100" =>	
				for i in 0 to 7 loop
					offset := 16 * i;
					temp_16_1 := input_1((15 + offset) downto (0 + offset));
					temp_16_2 := input_2((15 + offset) downto (0 + offset));
					temp_16_3 := std_logic_vector(unsigned(temp_16_1) + unsigned(temp_16_2));
					output((15 + offset) downto (0 + offset)) <= temp_16_3;
				end loop;


			--AHS Add Halfword signed with Saturation
			when "01101" =>
				for i in 0 to 7 loop
					offset := 16 * i;
					temp_16_1 := input_1((15 + offset) downto (0 + offset));
					temp_16_2 := input_2((15 + offset) downto (0 + offset));
					temp_16_3 := std_logic_vector(signed(temp_16_1) + signed(temp_16_2));
					if((temp_16_1(15) = '0') and (temp_16_2(15) = '0') and (temp_16_3(15) /= '0')) then 
						output((15 + offset) downto (0 + offset)) <= max_16;
					elsif((temp_16_1(15) = '1') and (temp_16_2(15) = '1') and (temp_16_3(15) /= '1')) then 
						output((15 + offset) downto (0 + offset)) <= min_16;
					else
						output((15 + offset) downto (0 + offset)) <= temp_16_3;
					end if;
				end loop;
			
			
			
			--AND Bit Logical "AND"
			when "01110" =>	
				output <= input_1 and input_2;


			--BCW	BroadCast Words from 1 word to 4 words
			when "01111" =>	
			temp_32_1 := input_1(31 downto 0);
			output(31 downto 0) <= temp_32_1;
			output(63 downto 32) <= temp_32_1;
			output(95 downto 64) <= temp_32_1;
			output(127 downto 96) <= temp_32_1;


			--MAXWS Max sign word
			when "10000" =>
				temp_32_1 := input_1(31 downto 0);
				temp_32_2 := input_1(63 downto 32);
				temp_32_3 := input_1(95 downto 64);
				temp_32_4 := input_1(127 downto 96);
				
				temp_32_5 := input_2(31 downto 0); 
				temp_32_6 := input_2(63 downto 32);
				temp_32_7 := input_2(95 downto 64);
				temp_32_8 := input_2(127 downto 96);
			
				if signed(temp_32_1) > signed(temp_32_5) then
					output(31 downto 0) <= temp_32_1;
				else output(31 downto 0) <= temp_32_5;
				end if;
				if signed(temp_32_2) > signed(temp_32_6) then
					output(63 downto 32) <= temp_32_2;
				else output(63 downto 32) <= temp_32_6;
				end if;
				if signed(temp_32_3) > signed(temp_32_7) then
					output(95 downto 64) <= temp_32_3;
				else output(95 downto 64) <= temp_32_7;
				end if;
				if signed(temp_32_4) > signed(temp_32_8) then
					output(127 downto 96) <= temp_32_4;
				else output(127 downto 96) <= temp_32_8;
				end if;
					   

			--MINWS Min Signed Word
			when "10001" =>
				temp_32_1 := input_1(31 downto 0);
				temp_32_2 := input_1(63 downto 32);
				temp_32_3 := input_1(95 downto 64);
				temp_32_4 := input_1(127 downto 96);
				
				temp_32_5 := input_2(31 downto 0); 
				temp_32_6 := input_2(63 downto 32);
				temp_32_7 := input_2(95 downto 64);
				temp_32_8 := input_2(127 downto 96);
				
				if signed(temp_32_1) < signed(temp_32_5) then
					output(31 downto 0) <= temp_32_1;
				else output(31 downto 0) <= temp_32_5;
				end if;
				if signed(temp_32_2) < signed(temp_32_6) then
					output(63 downto 32) <= temp_32_2;
				else output(63 downto 32) <= temp_32_6;
				end if;
				if signed(temp_32_3) < signed(temp_32_7) then
					output(95 downto 64) <= temp_32_3;
				else output(95 downto 64) <= temp_32_7;
				end if;
				if signed(temp_32_4) < signed(temp_32_8) then
					output(127 downto 96) <= temp_32_4;
				else output(127 downto 96) <= temp_32_8;
				end if;
					   
	
			--MLHU	 Multiply Low Unsigned
			when "10010" =>
				for i in 0 to 3 loop
					offset := 32 * i;
					temp_32_1 := std_logic_vector(unsigned(input_1((15 + offset) downto (0 + offset))) * unsigned(input_2((15 + offset) downto (0 + offset))));
					output((31 + offset) downto (0 + offset)) <= temp_32_1;
				end loop;
				
			
			--MLHCU  -- Multiply Low by Constant Unsigned
			when "10011" =>
				for i in 0 to 3 loop
					offset := 32 * i;
					temp_32_1 := std_logic_vector(unsigned(input_1((15 + offset) downto (0 + offset))) * resize(unsigned(input_constant),16)); 
					output((31 + offset) downto (0 + offset)) <= temp_32_1;
				end loop;
  

			--OR Bit Logical "OR" 
			when "10100" =>
				output <= input_1 or input_2; 


			--PCNTW Count Ones in Words
			when "10101" =>		
				for i in 0 to 3 loop
					offset := 32 * i;
					count := 0;
					for j in 0 to 31 loop
						if input_1(j + offset) = '1' then 
							count := count + 1;
						else 
							null;
						end if;
					end loop;
					output((31 + offset) downto (0 + offset)) <= std_logic_vector(to_unsigned(count,32));
				end loop; 

			--ROTW	  Rotate Bits in Word 
			when "10110" =>	   
				for i in 0 to 3 loop
					offset := 32 * i; 										 
					temp_5 := input_2((4 + offset) downto (0 + offset));
					integerValue := to_integer(unsigned(temp_5));
					temp_32_2 := std_logic_vector(rotate_right(signed(input_1((31 + offset) downto (0 + offset))),integerValue));
					output((31 + offset) downto (0 + offset)) <= std_logic_vector(temp_32_2);
				 end loop;
			--SFHS	 Subtract from Halfword Saturated
			when "10111" =>
				for i in 0 to 7 loop
					offset := 16 * i;
					temp_16_1 := input_1((15 + offset) downto (0 + offset));
					temp_16_2 := input_2((15 + offset) downto (0 + offset));
					temp_16_3 := std_logic_vector(signed(temp_16_2) - signed(temp_16_1));
					if((temp_16_2(15) = '1') and (temp_16_1(15) = '0') and temp_16_3(15) /= '1') then  --check if the subtraction has a neg overflow
						output((15 + offset) downto (0 + offset)) <= min_16;
					elsif((temp_16_2(15) = '0') and (temp_16_1(15) = '1') and temp_16_3(15) /= '0') then	--check if the subtraction has a pos overflow  
						output((15 + offset) downto (0 + offset)) <= max_16;
					else 
						output((15 + offset) downto (0 + offset)) <= temp_16_3;	   --otherwise, input the original 
					end if;
				end loop;	

			--SFW	 Subtract from Word Unsigned
			when "11000"=> 
				for i in 0 to 3 loop
					offset := 32 * i;
					temp_32_1 := input_1((31 + offset) downto (0 + offset));
					temp_32_2 := input_2((31 + offset) downto (0 + offset));
					temp_32_3 := std_logic_vector(unsigned(temp_32_2) - unsigned(temp_32_1)); 
					output((31 + offset) downto (0 + offset)) <= temp_32_3;
				end loop;
			when others =>
		end case;	
	end process;
end alu_architecture;
