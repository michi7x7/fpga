library ieee;
use ieee.std_logic_1164.all;

entity BCDdisp is
port(
	N : in integer range 0 to 15;
	Q : out std_logic_vector(6 downto 0) );
end entity;

--   0
-- 5    1
--   6
-- 4    2
--   3
--
--

architecture behaviour of BCDdisp is
	type disp_t is array(0 to 15) of  std_logic_vector(6 downto 0);
	constant disps : disp_t := (
		"0111111", -- 0
		"0000110", -- 1
		"1011011", -- 2
		"1001111", -- 3
		"1100110", -- 4
		"1101101", -- 5
		"1111101", -- 6
		"0000111", -- 7
		"1111111", -- 8
		"1101111", -- 9
		"1110111", -- A
		"1111100", -- b
		"0111001", -- C
		"1011110", -- d
		"1111001", -- E
		"1110001"  -- F
		);
begin
	Q <= not disps(N);
end behaviour;
