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
		 output : out STD_LOGIC_VECTOR(127 downto 0);
		 alu_ctrl : in STD_LOGIC_VECTOR(4 downto 0);
		 load_index_msb : out std_logic_vector (6 downto 0);
		 load_index_lsb : out std_logic_vector (6 downto 0)
	     );
end alu;

--}} End of automatically maintained section

architecture alu_architecture of alu is	  

signal temp_16_1, temp_16_2, temp_16_3, temp_16_4 : std_logic_vector(15 downto 0);

signal temp_32_1, temp_32_2, temp_32_3, temp_32_4, temp_32_5, temp_32_6, temp_32_7, temp_32_8: std_logic_vector(31 downto 0);	

signal temp_64_1, temp_64_2, temp_64_3, temp_64_4 : std_logic_vector(63 downto 0);

begin

	 -- enter your statements here --

process(input_1, input_2, input_3, ALU_ctrl)
	
	variable offset : integer;
	
	variable temp_8_1, temp_8_2, temp_8_3 : std_logic_vector(7 downto 0);
	
	variable temp_16_1, temp_16_2, temp_16_3, temp_16_4, temp_16_5, temp_16_6, temp_16_7, temp_16_8, temp_16_9, temp_16_10, temp_16_11, temp_16_12 : std_logic_vector(15 downto 0);

	variable temp_17_1, temp_17_2  : signed (16 downto 0);

	variable temp_32_1, temp_32_2 , temp_32_3 , temp_32_4 , temp_32_5 , temp_32_6 , temp_32_7  : std_logic_vector(31 downto 0);	

	variable temp_34_1 : signed (33 downto 0);

	variable temp_33_1, temp_33_2, temp_33_3 : signed (32 downto 0);

	variable temp_64_1,temp_64_2, temp_64_3, temp_64_4, temp_64_5, temp_64_6, temp_64_7 : std_logic_vector(63 downto 0); 

	variable sign_1, sign_2 : boolean;	--TRUE == positive sign, FALSE == negative sign	  
	
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
				null;
				
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
			 	
			
			when others =>
	
	end case;
--	
--
end process;

end alu_architecture;
