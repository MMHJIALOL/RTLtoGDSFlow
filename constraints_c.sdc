# Balanced timing constraint

create_clock -name clk -period 4.0 [get_ports clk]

set_clock_transition 0.3 [get_clocks clk]
set_clock_uncertainty 0.3 [get_clocks clk]

set_input_delay 0.8 -clock clk [get_ports {A[*] B[*] C[*] rst}]
set_input_delay 0.4 -min -clock clk [get_ports {A[*] B[*] C[*] rst}]

set_output_delay 1.0 -clock clk [get_ports out]
set_output_delay 0.4 -min -clock clk [get_ports out]
