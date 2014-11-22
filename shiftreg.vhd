library ieee;
use ieee.std_logic_1164.all;

entity ShiftReg is
generic(
	width:	integer:=4 );
port(
	I, CLK : in std_logic;
	Q      : out std_logic_vector(width-1 downto 0) );
end entity;

architecture behaviour of ShiftReg is
	constant max: integer := width-1;
	
	signal state : std_logic_vector(max downto 0);
begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			state <= I & state(max downto 1);
		end if;
	end process;
	
	Q <= state;
end behaviour;
