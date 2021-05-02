 library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.all;

entity forwarding_mux is
	port
	(
	--Signals from Fowarding Unit and Register File 
	forwarding_unit_valid : in std_logic_vector(1 downto 0);
	reg_bypass_valid : in std_logic_vector(1 downto 0);
	
	--Data from Forwarding Unit and Register File 
	forwarding_unit_data: in std_logic_vector(127 downto 0);
	reg_bypass_data : in std_logic_vector(127 downto 0);  
	
	--Data from ID/EX
	instruction_id :in STD_LOGIC_VECTOR(1 downto 0);
	forward_valid: in std_logic; 
	rs1_data_in  : in std_logic_vector(127 downto 0);
	rs2_data_in  : in std_logic_vector(127 downto 0); 
	rs3_data_in  : in std_logic_vector(127 downto 0);
	load_index_in : in std_logic_vector(2 downto 0);
	immediate_in : in std_logic_vector(15 downto 0);
	
	--Outputs to ALU		
	rs1_data_out  : out std_logic_vector(127 downto 0);
	rs2_data_out  : out std_logic_vector(127 downto 0); 
	rs3_data_out  : out std_logic_vector(127 downto 0);
	load_index_out : out std_logic_vector(2 downto 0);
	immediate_out : out std_logic_vector(15 downto 0)

	);
end forwarding_mux;

architecture forward_mux_archictecture of forwarding_mux is


begin
	
	forward: process is	 
	
	
	variable rs1_data_o : std_logic_vector(127 downto 0);
	variable rs2_data_o : std_logic_vector(127 downto 0);
	variable rs3_data_o :	std_logic_vector(127 downto 0);
	begin 
		
		if forward_valid = '0' and instruction_id = "0-" then
			load_index_out <= load_index_in;
			load_index_out <= load_index_in;
		elsif forward_valid = '1' then 	
			rs1_data_o := rs1_data_in;
			rs2_data_o := rs2_data_in;
			rs3_data_o := rs3_data_in;
			if forwarding_unit_valid /= "00" then 
				if forwarding_unit_valid = "01" then 
				 	rs1_data_o := forwarding_unit_data;
				elsif forwarding_unit_valid = "10" then
					rs2_data_o := forwarding_unit_data;
				else 
					rs3_data_o := forwarding_unit_data;
				end if;
			elsif reg_bypass_valid /= "00" then 
				if reg_bypass_valid = "01" then
					rs1_data_o := reg_bypass_data;
				elsif reg_bypass_valid = "10" then
					rs2_data_o := reg_bypass_data;
				else 
					rs3_data_o := reg_bypass_data; 
				end if;
			end if;
			rs1_data_out <= rs1_data_o;
			rs2_data_out <= rs2_data_o;
			rs3_data_out <= rs3_data_o;
		end if;
			
		
						
	wait;
	
	end process;
	
end forward_mux_archictecture;