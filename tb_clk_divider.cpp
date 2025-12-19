// tb_clk_divider.cpp
#include "Vclk_divider.h"      // The Verilated model
#include "verilated.h"         // Core Verilator libraries
#include "verilated_vcd_c.h"   // Waveform generation libraries

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);

    // Create an instance of our Verilated model
    Vclk_divider* dut = new Vclk_divider;

    // Enable waveform tracing
    Verilated::traceEverOn(true);
    VerilatedVcdC* vcd = new VerilatedVcdC;
    dut->trace(vcd, 99); // Trace 99 levels of hierarchy
    vcd->open("waves.vcd");

    // Simulation loop
    vluint64_t sim_time = 0;
    while (sim_time < 1000) { // Run for 1000 time units
        // Apply reset
        if (sim_time > 20 && sim_time < 40) {
            dut->rst = 1;
        } else {
            dut->rst = 0;
        }

        // Toggle the clock
        dut->clk_in = (sim_time % 10) < 5; // 10ns period clock

        // Evaluate the model
        dut->eval();

        // Write to the VCD waveform file
        vcd->dump(sim_time);

        // Advance simulation time
        sim_time++;
    }

    // Finalize and clean up
    vcd->close();
    dut->final();
    delete dut;

    return 0;
}
