-------------------------------------------------------------------------------
--
-- Title       : Instruction_Buffer
-- Design      : ESE345ALU
-- Author      : richard ma
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\richard ma\Desktop\ESE345PROJECT2021\ESE345ProjectALU\ESE345ALU\src\Instruction_Buffer.vhd
-- Generated   : Fri Apr 30 16:59:25 2021
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
--{entity {Instruction_Buffer} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;	 
use ieee.numeric_std.all;


package instruction_input is 
	type instruction_array_buffer is array (0 to 63) of std_logic_vector(24 downto 0);	
end package;	

library IEEE;
use IEEE.std_logic_1164.all;	 
use ieee.numeric_std.all;
library work;
use work.all;
use work.instruction_input.all;


entity Instruction_Buffer is
	port(					  
		 instruction_input: in instruction_array_buffer;
		 PC_in : in integer;
		 PC_out : out integer;
		 clk : in STD_LOGIC;		 
		 instruction_out: out std_logic_vector(24 downto 0)
	     );
end Instruction_Buffer;

--}} End of automatically maintained section

architecture behavioral of Instruction_Buffer is
begin

	process(clk)
	begin
		if rising_edge(clk) then 
			instruction_out <= instruction_input(PC_in);
			PC_OUT <= PC_in + 1;
		end if;
	end process;

end behavioral;
