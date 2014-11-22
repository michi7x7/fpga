library ieee;
use ieee.std_logic_1164.all;

entity Digit is
port(
	CLK : in std_logic;
	N   : in integer;
	D   : out integer range 0 to 9;
	R   : out integer );
end entity;

architecture behaviour of Digit is
begin

process(CLK)
begin
	if rising_edge(CLK) then
		D <= N mod 10;
		R <= N / 10;
	end if;
end process;

end behaviour;
