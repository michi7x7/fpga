
-- library declaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity msi_Test1 is
	port (
		SW   : in std_logic_vector(17 downto 0);
		KEY  : in std_logic_vector(3 downto 0);
		CLOCK_50 : in std_logic;
		LEDR : out std_logic_vector(17 downto 0);
		LEDG : out std_logic_vector(7 downto 0);
		
		HEX0 : out std_logic_vector(6 downto 0);
		HEX1 : out std_logic_vector(6 downto 0);
		HEX2 : out std_logic_vector(6 downto 0);
		HEX3 : out std_logic_vector(6 downto 0)
		);
end entity;

architecture behaviour of msi_Test1 is
	component ShiftReg is
		generic(
			width:	integer:=4 );
		port(
			I, CLK : in std_logic;
			Q      : out std_logic_vector(width-1 downto 0) );
	end component;
	
	component FreqDiv is
	port(
		CLK : in std_logic;
		FAC : in integer;
		Q   : out std_logic);
	end component;
	
	component pll1 is
	port(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		      : OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC 
	);
	end component;

	component FourDigits is
	port(
		CLK: in std_logic;
		N  : in integer;
		H0 : out std_logic_vector(6 downto 0);
		H1 : out std_logic_vector(6 downto 0);
		H2 : out std_logic_vector(6 downto 0);
		H3 : out std_logic_vector(6 downto 0) );
	end component;
	
	signal cnt  : integer range 0 to 100;
	signal cnt2 : integer range 0 to 100;
	signal clk10k : std_logic;
	signal clk100 : std_logic;
	signal clk10  : std_logic;
begin
	plla: pll1 port map(
		inclk0 => CLOCK_50,
		c0     => clk10k
	);
	
	fd1 : FreqDiv port map(
		CLK => clk10k,
		FAC => 1000,
		Q   => clk10);
		
	fd2 : FreqDiv port map(
		CLK => clk10k,
		FAC => 100,
		Q   => clk100);
	
	sr1: ShiftReg generic map(
		width => 18)
		port map(
			I   => SW(17),
			CLK => clk10,
			Q => LEDR(17 downto 0)
		);
	
	-- 7-SEGMENT --
	dig: FourDigits port map(
		CLK => clk100,
		N   => cnt,
		H0 => HEX0,
		H1 => HEX1,
		H2 => HEX2,
		H3 => HEX3
	);
	
	process(clk10)
	begin
		if rising_edge(clk10) then
			cnt <= cnt + 1;
		end if;
	end process;
	
	LEDG(0) <= clk10;
	LEDG(1) <= clk10k;
	
	
	process(clk10k)
	begin
		if rising_edge(clk10k) then
			cnt2 <= cnt2 + 1;
		end if;
	end process;
	
	LEDG(2) <=  '1' when (cnt2 < cnt) else '0';
		
	-- pwm1 : MyPWM generic map(
	--	DIV => 100)
	-- port map(
	--	CLK => clk10k,
	--	FAC => 50,
	--	Q   => LEDG(2)
	-- );

	-- LEDG(7 downto 3) <= std_logic_vector(to_unsigned(cnt, 5));
end behaviour;
