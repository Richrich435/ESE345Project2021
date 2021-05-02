library IEEE;
use IEEE.std_logic_1164.all;

entity ID_EX is
	port(	   
	
	clk : in std_logic;
	--Input
	--control signals 
	instruction_in : in STD_LOGIC_VECTOR(1 downto 0);
	forward_valid_in : in std_logic;
	reg_write_in : in STD_LOGIC;					 
	rd_in : in std_logic_vector(4 downto 0);
	--Data signals
    opCode_4_lsb_in : in STD_LOGIC_VECTOR(3 downto 0);
    li_sa_hl_in : in STD_LOGIC_VECTOR(2 downto 0);
    rs1_data_in : in STD_LOGIC_VECTOR(127 downto 0);
    rs2_data_in : in STD_LOGIC_VECTOR(127 downto 0);
    rs3_data_in : in STD_LOGIC_VECTOR(127 downto 0);
	load_index_in : in std_logic_vector(2 downto 0);
	immediate_in : in std_logic_vector(15 downto 0);
 	
	
	--Output Signals
 	--control signals
	instruction_out : out STD_LOGIC_VECTOR(1 downto 0);
	forward_valid_out : out std_logic;
	reg_write_out : out std_logic;
	rd_out : out std_logic_vector(4 downto 0);
	--Data signals 
	opcode_4_lsb_out : out STD_LOGIC_VECTOR(3 downto 0);
    li_sa_hl_out : out STD_LOGIC_VECTOR(2 downto 0);
    rs1_data_out : out STD_LOGIC_VECTOR(127 downto 0);
    rs2_data_out : out STD_LOGIC_VECTOR(127 downto 0);
    rs3_data_out : out STD_LOGIC_VECTOR(127 downto 0);
	load_index_out : out std_logic_vector(2 downto 0);
	immediate_out : out std_logic_vector(15 downto 0)
    );												
		 
end ID_EX;

--}} End of automatically maintained section

architecture Behavioral of ID_EX is
begin

	process(clk)
		begin  	
		if rising_edge(clk) then
				--Control Signals
				instruction_out <= instruction_in;	
				reg_write_out <= reg_write_in;
				rd_out <= rd_in;
				forward_valid_out <= forward_valid_in;
				--Data Signals
				opcode_4_lsb_out <= opcode_4_lsb_in;
				li_sa_hl_out <= li_sa_hl_in;
				rs1_data_out <= rs1_data_in;
				rs2_data_out <= rs2_data_in;
				rs3_data_out <= rs3_data_in;
				load_index_out <= load_index_in;
				immediate_out <= immediate_in;
		end if;
	end process;	
end Behavioral;
