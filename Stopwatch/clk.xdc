set_property IOSTANDARD LVCMOS33 [get_ports {digit[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports pause]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property PACKAGE_PIN E14 [get_ports {digit[7]}]
set_property PACKAGE_PIN E16 [get_ports {digit[6]}]
set_property PACKAGE_PIN D16 [get_ports {digit[5]}]
set_property PACKAGE_PIN D14 [get_ports {digit[4]}]
set_property PACKAGE_PIN AB11 [get_ports {digit[3]}]
set_property PACKAGE_PIN AB12 [get_ports {digit[2]}]
set_property PACKAGE_PIN AA9 [get_ports {digit[1]}]
set_property PACKAGE_PIN AB10 [get_ports {digit[0]}]
set_property PACKAGE_PIN D20 [get_ports {seg_data[7]}]
set_property PACKAGE_PIN C20 [get_ports {seg_data[6]}]
set_property PACKAGE_PIN C22 [get_ports {seg_data[5]}]
set_property PACKAGE_PIN B22 [get_ports {seg_data[4]}]
set_property PACKAGE_PIN B21 [get_ports {seg_data[3]}]
set_property PACKAGE_PIN A21 [get_ports {seg_data[2]}]
set_property PACKAGE_PIN E22 [get_ports {seg_data[1]}]
set_property PACKAGE_PIN D22 [get_ports {seg_data[0]}]
set_property PACKAGE_PIN R4 [get_ports clk]
set_property PACKAGE_PIN G21 [get_ports pause]
set_property PACKAGE_PIN U7 [get_ports reset]
create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]
