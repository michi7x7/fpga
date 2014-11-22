library ieee;
use ieee.std_logic_1164.all;

entity myDFF is
	port(
		I, CLK : in std_logic;
		Q      : out std_logic
	);
end entity;

architecture behaviour of myDFF is
begin

	process(CLK)
	begin

		if rising_edge(CLK) then
			Q <= I;
		end if;
	end process;

end behaviour;