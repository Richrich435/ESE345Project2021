 
 library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.all;

--Register File has to do forwarding as well (WB/REG forwarding) 

entity register_file is
	port
	(  

	--Clock & reg_write
	clk : in std_logic;
	reg_write_in : in std_logic;	 
	
	--Control Signals to Fowarding MUX 
	reg_bypass_valid : out std_logic_vector(1 downto 0);
	
	--I/P Inclusive   
	instruction : in std_logic_vector(24 downto 0); 
	--I/P Forwarding Exclusive
	forward_valid_in : in std_logic;
	instruction_id_in : in std_logic_vector(1 downto 0);
	id_ex_rs1 : in std_logic_vector(4 downto 0); 
	id_ex_rs2: in std_logic_vector(4 downto 0);
	id_ex_rs3 : in std_logic_vector(4 downto 0);
	--I/P Forwarding and Writing Exclusive
	rd :  in std_logic_vector(4 downto 0);   
	rd_data : in std_logic_vector(127 downto 0);
	--I/P Load Exclusive
	load_index_msb : in std_logic_vector (6 downto 0);
	load_index_lsb : in std_logic_vector (6 downto 0);	 
	
	--O/P Inclusive
	rd_out : out std_logic_vector(4 downto 0); --Control signal (rd_index of the instruction currently being decoded), to be used later in writing back and forwarding
	forward_valid_out : out std_logic;	 
	reg_write_out : out std_logic;
	instruction_id_out: out std_logic_vector(1 downto 0);
	--O/P Load Exclusive
	load_index : out std_logic_vector(2 downto 0);
	immediate : out std_logic_vector(15 downto 0);
	--O/Ps R3 and R4 Exclusive
	opcode_4_lsb : out std_logic_vector(7 downto 0); --R3 only
	li_sa_hl : out std_logic_vector(2 downto 0);	 --R4 only 
	rs1_data : out std_logic_vector(127 downto 0); 
	rs2_data : out std_logic_vector(127 downto 0);
	rs3_data : out std_logic_vector(127 downto 0);	
	--O/P Forwarding
	reg_bypass_data : out std_logic_vector(127 downto 0)
	
	);
end register_file; 


architecture behavioral of register_file is	  

	type reg_array is array(0 to 31) of std_logic_vector(127 downto 0);
	signal regs : reg_array;
	

begin
	
	--Asynchronusly decode the instruciton and read the register values here 
	decode_and_read: process is 
	
	variable rs1_id_out : std_logic_vector(4 downto 0); 
	variable rs2_id_out : std_logic_vector(4 downto 0);
	variable rs3_id_out : std_logic_vector(4 downto 0);
	variable bits_24_23_out : std_logic_vector(1 downto 0);
	variable opcode_out : std_logic_vector (7 downto 0);
	
	begin 
		
		bits_24_23_out := instruction(24 downto 23);
		
		
		--Decoding/reading that is same for R3 and R4 instructions 
		if bits_24_23_out = "10" or bits_24_23_out = "11" then
			rs2_id_out := instruction(14 downto 10);
			rs1_id_out := instruction(9 downto 5);
			rd_out <= instruction(4 downto 0);
			
			rs1_data <= regs(to_integer(unsigned(rs1_id_out)));
			rs2_data <= regs(to_integer(unsigned(rs2_id_out))); 
		end if;
		
		if bits_24_23_out = "10" then --R4 exclusive decoding/reading
			li_sa_hl <= instruction(22 downto 20);
			rs3_id_out := instruction(19 downto 15);
			rs3_data <= regs(to_integer(unsigned(rs3_id_out)));
			forward_valid_out <= '1';
			reg_write_out <= '1';
			
		elsif bits_24_23_out = "11" then --R3 exclusive decoding/reading
			opcode_out := instruction(22 downto 15);
			if opcode_out = "----0000" then --if its a NOP, forward_valid = "0"
				forward_valid_out <= '0';
				reg_write_out <= '0';
			else
				forward_valid_out <= '1';
				reg_write_out<= '1';
			end if;	
			opcode_4_lsb <= opcode_out;
		    
		else --LI exclusive decoding/reading
			load_index <= instruction(23 downto 21);
			immediate <= instruction(20 downto 5);	 
			forward_valid_out <= '0';
			reg_write_out <= '1';
		end if;
		
		instruction_id_out <= bits_24_23_out;
	
	wait;
	end process;  
	
	
	--Data to be written into the array (rd_data) is fowarded to the forwarding MUX's to be checked 
	forward: process is	
	begin
		--Check to see if the ex_wb register ID is equal to RS1, RS2, or RS3 (depending on the instruciton type)
		if forward_valid_in = '1' then 
				if rd = id_ex_rs1 then
					reg_bypass_valid <= "01";
				elsif rd = id_ex_rs2 then 
					reg_bypass_valid <= "10"; 
				elsif rd = id_ex_rs3 then
					reg_bypass_valid <= "11";
				else 
					reg_bypass_valid <= "00";
				end if;	
			reg_bypass_data <= rd_data;
		end if;	
		wait;
	end process;	 
	
	write : process(clk) is 		--synchronus write 	
	begin 
		if rising_edge(clk) and reg_write_in = '1' then 
				if instruction_id_in = "0-" then	
					--Load instruciton write process. Using the msb and lsb indexes, load the 16 lsbs of rd_data into the proper half-word location of rd
					regs(to_integer(unsigned(rd))) (to_integer(unsigned(load_index_msb)) downto to_integer(unsigned(load_index_lsb)) ) <= rd_data (15 downto 0); 
			   	else
					--R3 and R4 insturction write process 
					regs(to_integer(unsigned(rd))) <= rd_data;
				end if;
		end if;
	end process;
		


end behavioral;  