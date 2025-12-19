# OpenSTA Script for Timing Analysis

# 1. Read the "parts catalog" (the same library Yosys used)
read_liberty typical.lib

# 2. Read the "construction plan" (the netlist Yosys created)
read_verilog netlist_a.v

# 3. "Link" the design, connecting all the parts together
link_design rtl_topmodule

# 4. Read the "timing goals" (the same SDC file Yosys used)
read_sdc constraints_a.sdc

# 5. Run the inspection! Check for any timing violations
#    and report the worst-case path.
report_checks -path_delay max -format full_clock_expanded