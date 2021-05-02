 
library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.all;

entity ex_wb is
	port
	(
	--Inputs 
	
	clk : in std_logic;
	
	--Control Signals
	instruction_id_in : in std_logic_vector(1 downto 0); 
	reg_write_in : in std_logic;
	rd_in : in std_logic_vector (4 downto 0);
	forward_valid_in : in std_logic; 
	--Data Signals 
	rd_data_in : in std_logic_vector(127 downto 0);
	load_index_msb_in : in std_logic_vector (6 downto 0);
	load_index_lsb_in : in std_logic_vector (6 downto 0);

	--Outputs
	
	--Control Signals
	instruction_id_out : out std_logic_vector(1 downto 0); 
	reg_write_out : out std_logic;
	rd_out: out std_logic_vector (4 downto 0);
	forward_valid_out : out std_logic; 
	--Data Signals 
	rd_data_out : out std_logic_vector(127 downto 0);
	load_index_msb_out : out std_logic_vector (6 downto 0);
	load_index_lsb_out : out std_logic_vector (6 downto 0)

	);
end ex_wb;

architecture ex_wb_archictecture of ex_wb is

	begin
				process(clk)
					begin
						if (rising_edge(clk)) then
							instruction_id_out  <= instruction_id_in; 
							reg_write_out <= reg_write_in;
							rd_out <= rd_in;
							forward_valid_out <= forward_valid_in; 
							rd_data_out <= rd_data_in;
							load_index_msb_out <= load_index_msb_in;
							load_index_lsb_out <= load_index_lsb_in;
						end if;				
					end process;

	
end ex_wb_archictecture;