
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
		HEX3 : out std_logic_vector(6 downto 0);
		
		AUD_ADCDAT,	AUD_ADCLRCK, AUD_BCLK, AUD_DACDAT, AUD_DACLRCK,	AUD_XCK : out std_logic;
		I2C_SCLK, I2C_SDAT : out std_logic
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
	
	signal clk24M : std_logic;
	signal clk1M  : std_logic;
	signal clk1k  : std_logic;
	signal clk100 : std_logic;
	signal clk10  : std_logic;
	signal clk48k : std_logic;
	
	signal mdat : signed(15 downto 0);
	signal mout : signed(23 downto 0);
begin
	plla: work.pll1 port map(
		inclk0 => CLOCK_50,
		c0     => clk24M,
		c1     => clk1M
	);
	
	fd1k : work.FreqDiv port map(
		CLK => clk1M,
		FAC => 1000,
		Q   => clk1k
	);
	
	fd100 : work.FreqDiv port map(
		CLK => clk1M,
		FAC => 10000,
		Q   => clk100);
		
	fd10 : work.FreqDiv port map(
		CLK => clk1M,
		FAC => 100000,
		Q   => clk10);
	
	
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
	
	-- process(clk10, SW)
	-- begin
	-- 	if rising_edge(clk10) then
	-- 		cnt <= cnt + 1;
	-- 	end if;
	-- end process;
	
	cnt <= to_integer(unsigned(SW(6 downto 0)) );
	
	LEDG(0) <= clk10;
	LEDG(1) <= clk1M;
	
	LEDG(2) <= clk48k;
	
	-- AUDIO OUT --	
	test_osc1 : entity work.test_osc
	port map (
		clk			=> clk24M,
		tone        => cnt,
		dout 			=> mout,
		samp_clk    => clk48k,
		outen			=> LEDG(3)
	);
	
	aud_out : entity work.g00_audio_interface
	port map (	
		LDATA => mout,
		RDATA	=> mout,
		clk => clk24M,
		rst => not KEY(0),
		INIT => KEY(0),
		W_EN => not KEY(1),
		pulse_48KHz => clk48k, 		-- sample sync pulse
		AUD_MCLK  => AUD_XCK,		-- codec master clock input
		AUD_BCLK => AUD_BCLK,		-- digital audio bit clock
		AUD_DACDAT => AUD_DACDAT,	-- DAC data lines
		AUD_DACLRCK => AUD_DACLRCK, -- DAC data left/right select
		I2C_SDAT => I2C_SDAT, 		-- serial interface data line
		I2C_SCLK => I2C_SCLK			-- serial interface clock
	);
	
end behaviour;
