										 -------------------------------------------------------------------------------
--
-- Title       : Instruction_BufferTB
-- Design      : ESE345ALU
-- Author      : richard ma
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\richard ma\Desktop\ESE345PROJECT2021\ESE345ProjectALU\ESE345ALU\src\Instruction_BufferTB.vhd
-- Generated   : Fri Apr 30 17:08:15 2021
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
--{entity {Instruction_BufferTB} architecture {Instruction_BufferTB}}

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.all;
use work.instruction_input.all;	  	


entity Instruction_BufferTB is
end Instruction_BufferTB;

--}} End of automatically maintained section

architecture Instruction_BufferTB of Instruction_BufferTB is			 

signal instruction_input : instruction_array_buffer;
signal PC_in : integer;
signal PC_out : integer;
signal clk : std_logic;
signal instruction_out : std_logic_vector(24 downto 0);

begin

	-- enter your statements here -- 
	UUT: entity Instruction_Buffer
		port map(instruction_input,PC_in,PC_out,clk,instruction_out);
		instruction_input(0) <= "0110010000001111111100110";
		instruction_input(1) <= "1000000101000100000100111";
		instruction_input(2) <= "1100000001010100101101100";
		instruction_input(3) <= "1100000011010000001100100";

end Instruction_BufferTB;
