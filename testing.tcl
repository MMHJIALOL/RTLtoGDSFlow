
#Read modules from Verilog file
read_verilog rtl_topmodule.v clk_divider.v barrel_shifter.v parity_gen.v lfsr.v

#Elaborate design hierarchy
# hierarchy -check-top rtl_topmodule
# Translate processes to netlists
proc
# Mapping to the internal cell library
techmap
# Mapping flip-flops to Nangate Open CellLibrary_typical.lib
# for e.g., always block
dfflibmap -liberty typical.lib
#Mapping logic to Nangate Open CellLibrary_typical.lib
#for e.g., assign block
abc -liberty typical.lib
# Remove unused cells and wires
clean
# Write the current design to a Verilog file
write_verilog -noattr synth_example.v

```
