library ieee;
use ieee.std_logic_1164.all;

entity PWM is
generic(
	DIV : integer := 100;
);
port(
	CLK : in std_logic;
	FAC : in integer;
	Q   : out std_logic);
end entity;

architecture behaviour of PWM is
	signal cnt : integer range 0 to DIV;
begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			cnt <= cnt + 1;
		end if;
	end process;
	
	Q <= cnt < FAC;
end behaviour;
