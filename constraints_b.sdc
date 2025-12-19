# Tight timing constraint (min delay / max performance)

create_clock -name clk -period 2.37 [get_ports clk]

set_clock_transition 0.2 [get_clocks clk]
set_clock_uncertainty 0.2 [get_clocks clk]

set_input_delay 0.5 -clock clk [get_ports {A[*] B[*] C[*] rst}]
set_input_delay 0.2 -min -clock clk [get_ports {A[*] B[*] C[*] rst}]

set_output_delay 0.5 -clock clk [get_ports out]
set_output_delay 0.2 -min -clock clk [get_ports out]
