# I/O Drive Strength & Slew
set_property DRIVE 4 [get_ports {result[*]}]
set_property DRIVE 4 [get_ports {done}]
set_property SLEW SLOW [get_ports {result[*]}]
set_property SLEW SLOW [get_ports {done}]

# IO Standard (1.2V)
set_property IOSTANDARD LVCMOS12 [get_ports {result[*]}]
set_property IOSTANDARD LVCMOS12 [get_ports {done}]

# Clock Constraint (50 MHz)
create_clock -name clk -period 20.000 [get_ports {clk}]

# Generic delays for demonstration purposes (not board-specific)
set_input_delay 5   -clock clk [get_ports A[*]]
set_input_delay 5   -clock clk [get_ports B[*]]
set_input_delay 2   -clock clk [get_ports start]
set_input_delay 2   -clock clk [get_ports rst_n]

set_output_delay 5  -clock clk [get_ports result[*]]
set_output_delay 2  -clock clk [get_ports done]
