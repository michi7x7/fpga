## Generated SDC file "msi_Test1.sdc"

## Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, the Altera Quartus II License Agreement,
## the Altera MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Altera and sold by Altera or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 14.0.0 Build 200 06/17/2014 SJ Web Edition"

## DATE    "Mon Nov 24 19:53:53 2014"

##
## DEVICE  "EP4CE115F29C7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {CLOCK_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLOCK_50}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {plla|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {plla|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 12 -divide_by 25 -master_clock {CLOCK_50} [get_pins {plla|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {plla|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {plla|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -divide_by 50 -master_clock {CLOCK_50} [get_pins {plla|altpll_component|auto_generated|pll1|clk[1]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {plla|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {plla|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {plla|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {plla|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {plla|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {plla|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {plla|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {plla|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {plla|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {plla|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {plla|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {plla|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {plla|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {plla|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {plla|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {plla|altpll_component|auto_generated|pll1|clk[0]}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

