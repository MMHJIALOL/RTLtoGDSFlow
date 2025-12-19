create_clock -name clk -period 18.0 [get_ports clk]

set_clock_transition 0.5 [get_clocks clk]
set_clock_uncertainty 0.5 [get_clocks clk]

set_input_delay 1.2 -clock clk [get_ports {A[*] B[*] C[*] rst}]
set_input_delay 0.5 -min -clock clk [get_ports {A[*] B[*] C[*] rst}]

set_output_delay 1.5 -clock clk [get_ports out]
set_output_delay 0.8 -min -clock clk [get_ports out]
