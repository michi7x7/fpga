----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:36:34 08/03/2012 
-- Design Name: 
-- Module Name:    uart - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Test oscilliator, basic sawtooth, with 8 bit input for selecting a freq
-- 				and a 16 bit sample output
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use ieee.math_real.all;

entity test_osc is
	Port (
	clk 		: in std_logic;
	tone     : in integer range 0 to 127;
	
	outen		: out std_logic;
	
	samp_clk	: in std_logic;
	dout		: out signed (23 downto 0) -- 24 bits
	);
		
end test_osc;

architecture RTL of test_osc is
	signal fcw 			: integer;
	signal phase		: integer range 0 to 512*512; -- 512 is one sin, 512 for higher prec.
	
	
	-- freq m = 2**((m-69)/12) * 440;
	-- tostep f = f * 512 / (48000)
	-- steps = (round . (*512) . tostep . freq) `map` [0..127]
	type fcwlut_type is array ( 0 to 127 ) of integer range 0 to 68506;
	constant fcwlut : fcwlut_type := (45,47,50,53,56,60,63,67,71,75,80,84,89,95,100,106,113,119,126,134,142,150,159,169,179,189,200,212,225,238,253,268,284,300,318,337,357,378,401,425,450,477,505,535,567,601,636,674,714,757,802,850,900,954,1010,1070,1134,1201,1273,1349,1429,1514,1604,1699,1800,1907,2021,2141,2268,2403,2546,2697,2858,3028,3208,3398,3600,3815,4041,4282,4536,4806,5092,5395,5715,6055,6415,6797,7201,7629,8083,8563,9072,9612,10184,10789,11431,12110,12830,13593,14402,15258,16165,17127,18145,19224,20367,21578,22861,24221,25661,27187,28803,30516,32331,34253,36290,38448,40734,43156,45722,48441,51322,54373,57607,61032,64661,68506);
	
	-- sini = (floor . (*2^23) . sin . (* (pi/2 / 128)) ) `map` [0..127]
	type sinlut_type is array ( 0 to 127 ) of integer range 0 to 8387976;
	constant sinlut : sinlut_type := (0,102941,205866,308761,411609,514395,617104,719720,822227,924610,1026855,1128944,1230864,1332598,1434132,1535449,1636536,1737376,1837954,1938255,2038265,2137968,2237348,2336392,2435084,2533409,2631353,2728900,2826036,2922747,3019018,3114834,3210181,3305044,3399410,3493264,3586592,3679379,3771613,3863278,3954362,4044850,4134729,4223986,4312606,4400577,4487885,4574517,4660460,4745702,4830229,4914028,4997087,5079394,5160936,5241701,5321676,5400850,5479210,5556746,5633444,5709294,5784285,5858404,5931641,6003985,6075424,6145949,6215548,6284211,6351928,6418688,6484481,6549298,6613129,6675963,6737793,6798607,6858398,6917156,6974872,7031538,7087145,7141684,7195149,7247529,7298818,7349008,7398091,7446060,7492908,7538627,7583211,7626653,7668947,7710085,7750063,7788873,7826510,7862969,7898244,7932329,7965219,7996910,8027397,8056675,8084739,8111586,8137211,8161611,8184782,8206720,8227423,8246886,8265107,8282084,8297813,8312293,8325521,8337495,8348214,8357675,8365878,8372821,8378503,8382923,8386081,8387976);
	
	-- Oscillator enable flag
	signal en : std_logic := '0' ;
begin
	
	outen <= en;

	-- Data readin
	process(clk)
	begin 
		if rising_edge(clk) then
			-- get the FCW from the LUT
			fcw <= fcwlut(tone);
			en <= '1';
		end if;
	end process;		


	-- Numerically Controlled Oscillator
	process(samp_clk)
		variable phi : integer;
		variable pha : integer range 0 to 2*512*512;
		variable d : integer range -8387976 to 8387976;
	begin
		if rising_edge(samp_clk) then 
			if en = '1' then
				-- increment accumulator
				pha := phase + fcw;
				if pha >= 512*512 then
					phase <= pha - 512*512;
				else
					phase <= pha;
				end if;
				
				phi := phase / 512;
				
				if phi >= 3*128 then
					d := 0 - sinlut(512 - phi - 1);
				elsif phi >= 256 then
					d := 0 - sinlut(phi-256);
				elsif phi >= 128 then
					d := sinlut(256-phi - 1);
				else
					d := sinlut(phi);
				end if;
				
				dout <= to_signed(d / 2, 24);
				
				-- Output sawtooth, this has bad rounding but i don't care rn
				-- dout <= phase;
			else 
				dout <= X"800000"; 
			end if;
		end if;
	end process;
end RTL;