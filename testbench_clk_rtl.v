`timescale 1ns/1ns

module testbench_clk_rtl;

    // Declare signals
    reg clk;
    reg rst;
    reg [9:0] A;
    reg [8:0] C;
    wire [10:0] out;

    // Instantiate the DUT (Device Under Test)
    rtl_topmodule dut (
        .clk(clk),
        .rst(rst),
        .A(A),
        .C(C),
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // ==========================================================
    // --- Stimulus process with THE CORRECTED RESET SEQUENCE ---
    // ==========================================================
    initial begin
        $display($time, " ===== Testbench Start ===== ");
        
        // 1. Start with reset LOW to allow for a rising edge.
        rst = 0;
        A   = 10'd15;
        C   = 9'd0;
        #20; // Wait for 2 clock cycles to ensure simulation is stable.

        // 2. Apply the reset pulse (0 -> 1 -> 0). This will correctly initialize the counter.
        rst = 1;
        #20; // Hold reset high for 20ns.
        rst = 0; // De-assert reset to begin normal operation.

        // 3. Now, apply the stimulus to test the clock divider.
        #10; // Wait a moment after reset.
        C = 9'd12; // This will trigger the clk_divider because C < 51.
    end

    // VCD dump for waveform and coverage
    initial begin
        $dumpfile("testbench_clk_rtl.vcd");
        $dumpvars(0, testbench_clk_rtl);  // Dump all hierarchy below testbench_1
    end

    // Monitor output (Output would be shown on the terminal)
    initial begin
        $monitor("Time=%0t | clk=%b rst=%b | A=%d C=%d | out=%d",
                 $time, clk, rst, A, C, out);
    end

    // Terminate simulation after a fixed time
    initial begin
        #500 $finish;
    end

endmodule
