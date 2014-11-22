library ieee;
use ieee.std_logic_1164.all;

entity FourDigits is
port(
	CLK : in std_logic;
	N   : in integer;
	
	H0 : out std_logic_vector(6 downto 0);
	H1 : out std_logic_vector(6 downto 0);
	H2 : out std_logic_vector(6 downto 0);
	H3 : out std_logic_vector(6 downto 0) );
end entity;

architecture behaviour of FourDigits is
	component BCDdisp is
	port(
		N : in integer range 0 to 15;
		Q : out std_logic_vector(6 downto 0) );
	end component;

	type digit_vect is array(1 to 5) of integer;
	signal dig : digit_vect;
	signal rest: digit_vect;
	signal cnt : integer range 1 to 4 := 1;
begin
	process(CLK)
	begin
		if rising_edge(CLK) THEN
			if cnt = 1 then
				dig(1) <= N mod 10;
				rest(2) <= N / 10;
			else
				dig(cnt)    <= rest(cnt) mod 10;
				rest(cnt+1) <= rest(cnt) / 10;
			end if;
			
			cnt <= cnt + 1;
		end if;
	end process;
			
	bcd1 : BCDdisp port map(
		N => dig(1),
		Q => H0);
	bcd2 : BCDdisp port map(
		N => dig(2),
		Q => H1);
	bcd3 : BCDdisp port map(
		N => dig(3),
		Q => H2);
	bcd4 : BCDdisp port map(
		N => dig(4),
		Q => H3);
end behaviour;
