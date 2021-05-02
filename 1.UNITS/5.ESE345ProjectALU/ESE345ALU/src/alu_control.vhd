 library ieee;
use ieee.std_logic_1164.all;

entity alu_control is
	port
	(
	instruction_id : in std_logic_vector(1 downto 0);
	li_sa_hl : in std_logic_vector(2 downto 0);
	opcode : in std_logic_vector(3 downto 0);
	alu_control_command : out std_logic_vector(4 downto 0)
	);
end alu_control;

architecture alu_control_brains of alu_control is
begin
	process(instruction_id, opcode)
	begin
		if instruction_id = "10" then	--R4 instructions	 
			case std_logic_vector(li_sa_hl) is
			when "000" =>
			alu_control_command <= "00001"; 
			when "001" =>
			alu_control_command <= "00010";		
			when "010" =>
			alu_control_command <= "00011";
			when "011" =>
			alu_control_command <= "00100";
			when "100" =>
			alu_control_command <= "00101";
			when "101" =>
			alu_control_command <= "00110";
			when "110" =>
			alu_control_command <= "00111";
			when "111" =>
			alu_control_command <= "01000";
			when others	=>
			alu_control_command <= "-----";
			end case; 
		elsif instruction_id = "0-" then --LI
			alu_control_command <= "00000";
		elsif instruction_id = "11" then --R3 instructions 
			case std_logic_vector(opcode) is
			when "0000" =>
			alu_control_command <= "01001"; 
			when "0001" =>
			alu_control_command <= "01010";		
			when "0010" =>
			alu_control_command <= "01011";
			when "0011" =>
			alu_control_command <= "01100";
			when "0100" =>
			alu_control_command <= "01101";
			when "0101" =>
			alu_control_command <= "01110";
			when "0110" =>
			alu_control_command <= "01111";
			when "0111" =>
			alu_control_command <= "10000";
			when "1000" =>
			alu_control_command <= "10001";
			when "1001" =>
			alu_control_command <= "10010";
			when "1010" =>
			alu_control_command <= "10011";
			when "1011" =>
			alu_control_command <= "10100";
			when "1100" =>
			alu_control_command <= "10101";
			when "1101" =>
			alu_control_command <= "10110";
			when "1110" =>
			alu_control_command <= "10111";
			when "1111" =>
			alu_control_command <= "11000";
			when others	=>
			alu_control_command <= "-----";
			end case;
		else
			alu_control_command <= "-----";
		end if;
	end process;
end alu_control_brains;