													  ---Signed Integer Multiply-Add High with Saturation	  
			when ""00011" =>	
				for i in 0 to 3 loop			    
					offset := 32*i;	
			   		temp_32_1 := input_3((63 + offset) downto (32 + offset)); 
			   		temp_32_2 := input_2((63 + offset) downto (32 + offset));
					temp_64_1 := input_1((63 + offset) downto (0 + offset));
					temp_64_2 := std_logic_vector((signed(temp_32_1) * signed(temp_32_2)));
					temp_64_3 := std_logic_vector(signed(temp_64_1) + signed(temp_64_2)); 	   
					if ((temp_64_1(63) = '0') and (temp_64_2(63) = '0') and (temp_64_3(63) /= '0')) then -- both positive but there's a 1 at MSB	
						output((63 + offset) downto (0 + offset)) <= max_integer;
					elsif ((temp_32_1(63) = '1') and (temp_32_2(63) = '1') and (temp_32_3(63) /= '1')) then --both negative but there's a 0 at MSB		
						output((63 + offset) downto (0 + offset)) <= min_integer;  
					else 
						output((63 + offset) downto (0 + offset)) <= temp_32_3; 
					end if;
				end loop;
									
				---signed integer multiply-subtract low with saturation
			 when "00100" =>	
				for i in 0 to 3 loop			    
					offset := 32*i;	
			   		temp_32_1 := input_3((31+ offset) downto (0 + offset)); 
			   		temp_32_2 := input_2((31+ offset) downto (0 + offset));
					temp_64_1 := input_1((63 + offset) downto (0 + offset));
					temp_64_2 := std_logic_vector((signed(temp_32_1) * signed(temp_32_2)));
					temp_64_3 := std_logic_vector(signed(temp_32_1) - signed(temp_32_2)); 	   
					if ((temp_64_1(63) = '0') and (temp_64_2(63) = '1') and (temp_64_3(63) /= '0')) then -- both positive but there's a 1 at MSB	
						output((63 + offset) downto (0 + offset)) <= max_integer;
					elsif ((temp_64_1(63) = '1') and (temp_64_2(63) = '0') and (temp_64_3(63) /= '1')) then --both negative but there's a 0 at MSB		
						output((63 + offset) downto (0 + offset)) <= min_long;  
					else 
						output((63 + offset) downto (0 + offset)) <= temp_64_3; 
					end if;
				end loop;
				
			---Signed Integer Multiply-Subtract High with Saturation
			when "00101" =>
				for i in 0 to 3 loop			    
					offset := 32*i;	
			   		temp_32_1 := input_3((63 + offset) downto (32 + offset)); 
			   		temp_32_2 := input_2((63 + offset) downto (32 + offset));
					temp_32_1 := input_1((63 + offset) downto (0 + offset));
					temp_32_2 := std_logic_vector((signed(temp_32_1) * signed(temp_32_2)));
					temp_32_3 := std_logic_vector(signed(temp_32_1) - signed(temp_32_2)); 	   
					if ((temp_32_1(63) = '0') and (temp_32_2(63) = '1') and (temp_32_3(63) /= '0')) then -- both positive but there's a 1 at MSB	
						output((63 + offset) downto (0 + offset)) <= max_integer;
					elsif ((temp_32_1(63) = '1') and (temp_32_2(63) = '0') and (temp_32_3(63) /= '1')) then --both negative but there's a 0 at MSB		
						output((63 + offset) downto (0 + offset)) <= min_integer;  
					else 
						output((63 + offset) downto (0 + offset)) <= temp_32_3; 
					end if;
				end loop;