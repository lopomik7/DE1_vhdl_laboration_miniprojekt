# Uppgift 6 - AND grind på Basys3: LD0 = SW1 AND SW0
## Switch 0
set_property PACKAGE_PIN V17 [get_ports {SW[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[0]}]

## Switch 1
set_property PACKAGE_PIN V16 [get_ports {SW[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[1]}]

## LED 0
set_property PACKAGE_PIN U16 [get_ports {LD}]
set_property IOSTANDARD LVCMOS33 [get_ports {LD}]
