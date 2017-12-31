create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK100MHZ}];
set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property PACKAGE_PIN N17 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]




#dac

set_property PACKAGE_PIN E7 [get_ports CS_DAC]
set_property PACKAGE_PIN J3 [get_ports SDI]

set_property PACKAGE_PIN F6 [get_ports LDAC]
set_property IOSTANDARD LVCMOS33 [get_ports LDAC]

set_property IOSTANDARD LVCMOS33 [get_ports CS_DAC]
set_property IOSTANDARD LVCMOS33 [get_ports SDI]

set_property PACKAGE_PIN K1 [get_ports SCK_DAC]
set_property IOSTANDARD LVCMOS33 [get_ports SCK_DAC]

#ADC

set_property PACKAGE_PIN G6 [get_ports CS_ADC]
set_property IOSTANDARD LVCMOS33 [get_ports CS_ADC]

set_property PACKAGE_PIN J4 [get_ports D_in]
set_property IOSTANDARD LVCMOS33 [get_ports D_in]

set_property PACKAGE_PIN J2 [get_ports D_out]
set_property IOSTANDARD LVCMOS33 [get_ports D_out]

set_property PACKAGE_PIN V11 [get_ports finished]
set_property IOSTANDARD LVCMOS33 [get_ports finished]

set_property PACKAGE_PIN N17 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

set_property PACKAGE_PIN E6 [get_ports SCK_ADC]
set_property IOSTANDARD LVCMOS33 [get_ports SCK_ADC]

set_property IOSTANDARD LVCMOS33 [get_ports start]
set_property PACKAGE_PIN P18 [get_ports start]



#D_out               : in  std_logic; -- ADC
#        CS_ADC             : out std_logic; -- ADC
#        SCK_ADC             : out std_logic; -- ADC
#        D_in                : out std_logic; -- ADC







# SDI                 : out std_logic; -- DAC
#        SCK_DAC             : out std_logic; -- DAC
#        LDAC               : out std_logic; -- DAC
#        CS_DAC             : out std_logic); --DAC