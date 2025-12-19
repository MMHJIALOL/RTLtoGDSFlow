# Yosys Synthesis Script (Using the correct SkyWater library)

# Read all the Verilog design files
read_verilog -sv rtl_topmodule.v clk_divider.v barrel_shifter.v parity_gen.v lfsr.v

# Set top module and perform basic synthesis
hierarchy -check -top rtl_topmodule
proc; opt; fsm; opt; memory; opt

# Technology Mapping using the SkyWater library
dfflibmap -liberty sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty sky130_fd_sc_hd__tt_025C_1v80.lib -clk clk,$env(CLK_PERIOD)

# Clean up and write the output
clean -purge
stat -liberty sky130_fd_sc_hd__tt_025C_1v80.lib
write_verilog $env(NETLIST_FILE)