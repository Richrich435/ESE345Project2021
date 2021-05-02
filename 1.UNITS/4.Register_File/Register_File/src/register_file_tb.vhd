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
	signal clk : std_logic;
	signal reg_write_in : std_logic;	 
	
	--Control Signals to Fowarding MUX 
	signal reg_bypass_valid : std_logic_vector(1 downto 0);
	
	signal instruction : std_logic_vector(24 downto 0); 
	--I/P Forwarding Exclusive
	signal forward_valid_in : std_logic;
	signal instruction_id_in : std_logic_vector(1 downto 0);
	signal id_ex_rs1 : std_logic_vector(4 downto 0); 
	signal id_ex_rs2: std_logic_vector(4 downto 0);
	signal id_ex_rs3 : std_logic_vector(4 downto 0);
	--I/P Forwarding and Writing Exclusive
	signal rd : std_logic_vector(4 downto 0);   
	signal rd_data : std_logic_vector(127 downto 0);
	--I/P Load Exclusive
	signal load_index_msb : std_logic_vector (6 downto 0);
	signal load_index_lsb : std_logic_vector (6 downto 0);	 
	
	--O/P Inclusive
	signal rd_out : std_logic_vector(4 downto 0);
	signal forward_valid_out : std_logic;	 
	signal reg_write_out : std_logic;
	signal instruction_id_out: std_logic_vector(1 downto 0);
	--O/P Load Exclusive
	signal load_index : std_logic_vector(2 downto 0);
	signal immediate : std_logic_vector(15 downto 0);
	--O/Ps R3 and R4 Exclusive
	signal opcode_4_lsb : std_logic_vector(7 downto 0); 
	signal li_sa_hl : std_logic_vector(2 downto 0);	  
	signal rs1_data : std_logic_vector(127 downto 0); 
	signal rs2_data : std_logic_vector(127 downto 0);
	signal rs3_data : std_logic_vector(127 downto 0);	
	--O/P Forwarding
	signal reg_bypass_data :  std_logic_vector(127 downto 0); 
constant period : time := 100ns;
		
		
begin				   
    -- Unit Under Test port map
    UUT: entity register_file
    port map (
	clk => clk,
	reg_write_in => reg_write_in,  
	reg_bypass_valid => reg_bypass_valid,
	instruction => instruction,
	forward_valid_in => forward_valid_in,
	instruction_id_in => instruction_id_in,
	id_ex_rs1 => id_ex_rs1,
	id_ex_rs2 => id_ex_rs2,
	id_ex_rs3 => id_ex_rs3,
	rd => rd,
	rd_data => rd_data,
	load_index_msb => load_index_msb,
	load_index_lsb => load_index_lsb,
	rd_out => rd_out,
	forward_valid_out => forward_valid_out,
	reg_write_out => reg_write_out,
	instruction_id_out => instruction_id_out,
	load_index => load_index,
	immediate => immediate,
	opcode_4_lsb => opcode_4_lsb,
	li_sa_hl => li_sa_hl,
	rs1_data => rs1_data,
	rs2_data=> rs2_data,
	rs3_data => rs3_data,
	reg_bypass_data => reg_bypass_data
        );	
	
 test: process  
 
 
	begin  
		 
	  --LI inst 
	  instruction <= "0110010000001111111100110";
	  wait for period;
	  
	  --R3 inst
	  instruction <= "1000000101000100000100111";
	  wait for period;
	  
	  --R4 inst
	  instruction <= "1100000001010100101101100";
	  wait for period;
			
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