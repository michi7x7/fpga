library ieee;
use ieee.std_logic_1164.all;

entity FreqDiv is
port(
	CLK : in std_logic;
	FAC : in integer;
	Q   : out std_logic);
end entity;

architecture behaviour of FreqDiv is
	signal cnt : integer := 0;
	signal state : std_logic := '0';
begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			cnt <= cnt + 1;
			
			if cnt > FAC/2 then
				cnt <= 0;
				state <= not state;
			end if;
		end if;
		
		Q <= state after 2ns;
	end process;
end behaviour;
