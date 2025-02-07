# Master Clock timing constraint
create_clock -period 8.000 -name MCLK -waveform {0.000 4.000} [get_ports MCLK];

set_property -dict { PACKAGE_PIN K17 IOSTANDARD LVCMOS33 } [get_ports MCLK];
# Reset (warning pull down resistors on board)
set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports RST];
# P output
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 } [get_ports P];