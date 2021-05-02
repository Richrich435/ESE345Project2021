library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.all;

entity forwarding_unit is
	port
	(
	
	--Instruction ID 
	instruction_id : in std_logic_vector(1 downto 0); 
	--Control Signal to make sure instruction is viable for forwarding (all instructions except NOP and LI should be forward valid)
	forward_valid : in std_logic;
	--Signals from EX/WB register, Register IDs and RD data  
	ex_wb_reg_id : in std_logic_vector(4 downto 0);
	id_ex_rs1_id : in std_logic_vector(4 downto 0);
	id_ex_rs2_id : in std_logic_vector(4 downto 0);
	id_ex_rs3_id : in std_logic_vector(4 downto 0);	 
	
	ex_wb_rd_data : in std_logic_vector(127 downto 0);

	--Outputs to the Forwarding MUXes		
	forwarding_unit_valid : out std_logic_vector(1 downto 0);
	forwarding_unit_data : out std_logic_vector(127 downto 0)

	);
end forwarding_unit;

architecture forward_unit_archictecture of forwarding_unit is

begin
	
   process
   
   begin 
	
	--Check to see if the ex_wb register ID is equal to RS1, RS2, or RS3 (depending on the instruciton type)
		--LI not included b/c LI not considered for forwarding 
	if forward_valid = '1' then 
			if ex_wb_reg_id = id_ex_rs1_id then
				forwarding_unit_valid <= "01";
			elsif ex_wb_reg_id = id_ex_rs2_id then 
				forwarding_unit_valid <= "10";	
			elsif instruction_id = "10" and ex_wb_reg_id = id_ex_rs3_id then 		--R4 exclusive
				forwarding_unit_valid <= "11"; 
			else 
				forwarding_unit_valid <= "00"; 
			end if;
				forwarding_unit_data <= ex_wb_rd_data;
	end if;									   

	wait;
   end process;
	
end forward_unit_archictecture;