#!/bin/bash
set -e

# --- Clean up old files ---
echo "Cleaning up previous run..."
rm -f sim_output *.vcd *.cdd report.txt

# --- Ask the user which module to test ---
echo "Which test do you want to run?"
echo "  1) clk_divider (Unit Test)"
echo "  2) barrel_shifter (Unit Test)"
echo "  3) Full RTL Module (Integration Test for Shifter Coverage)" # <-- NEW OPTION
read -p "Enter your choice [1-3]: " choice

# --- Set filenames based on user's choice ---
TOP_MODULE=""
VCD_FILE=""
VERILOG_FILES=""

if [ "$choice" == "1" ]; then
    echo "Selected: clk_divider Unit Test"
    TOP_MODULE="testbench_clk_divider"
    VCD_FILE="clk_divider_waves.vcd"
    VERILOG_FILES="clk_divider.v testbench_clk_divider.v"
elif [ "$choice" == "2" ]; then
    echo "Selected: barrel_shifter Unit Test"
    TOP_MODULE="testbench_barrel_shifter"
    VCD_FILE="barrel_shifter_waves.vcd"
    VERILOG_FILES="barrel_shifter.v testbench_barrel_shifter.v"
# --- NEW BLOCK FOR THE INTEGRATION TEST ---
elif [ "$choice" == "3" ]; then
    echo "Selected: Full RTL Module Integration Test"
    TOP_MODULE="testbench_top_coverage"
    VCD_FILE="top_coverage_waves.vcd"
    # We must include ALL the Verilog files that are part of the rtl_topmodule
    VERILOG_FILES="rtl_topmodule.v clk_divider.v barrel_shifter.v parity_gen.v lfsr.v testbench_top_coverage.v"
# --------------------------------------------
else
    echo "Invalid choice. Exiting."
    exit 1
fi

# --- The rest of the script is the same ---
echo "Compiling Verilog files..."
iverilog -o sim_output $VERILOG_FILES

echo "Running simulation..."
vvp -n sim_output

echo "Simulation finished successfully. VCD file created: $VCD_FILE"

read -p "Do you want to open GTKWave? (y/n): " open_gtkwave
if [[ "$open_gtkwave" == "y" || "$open_gtkwave" == "Y" ]]; then
    echo "Opening GTKWave... Close it to continue."
    gtkwave $VCD_FILE
fi

echo "Generating code coverage report..."
covered score -v $VERILOG_FILES -t $TOP_MODULE -vcd $VCD_FILE -o coverage.cdd

echo "Creating text report..."
covered report -d v coverage.cdd > report.txt

echo "--- COVERAGE REPORT (report.txt) ---"
cat report.txt
echo "------------------------------------"
echo "Automation complete."```

### How to Run and What to Expect

1.  Save the `testbench_top_coverage.v` file.
2.  Save the updated `run_sim.sh` script.
3.  Run `./run_sim.sh`.
4.  Choose option **3**.
5.  The script will now compile all your design files, run the simulation, and generate the coverage report.

**Expected Coverage Report:**
*   **`barrel_shifter.v`:** Will now have **100%** line and logic coverage.
*   **`rtl_topmodule.v`:** Will have slightly higher coverage than before, but still low (e.g., ~40-50%), because you still haven't tested the `parity_gen` or `lfsr` cases.
*   **`clk_divider.v`, `parity_gen.v`, `lfsr.v`:** Will have ~0% coverage because they were never activated.

This proves that your integration test successfully targeted and fully covered the barrel shifter. You can now follow this pattern for the remaining modules.