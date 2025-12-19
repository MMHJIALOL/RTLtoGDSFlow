`timescale 1ns/1ns

module testbench_lfsr_rtl;

    // Signals for the top module
    reg clk;
    reg rst;
    reg [9:0] A;
    reg [8:0] C;
    wire [10:0] out;

    // Instantiate the full rtl_topmodule
    rtl_topmodule dut (
        .clk(clk),
        .rst(rst),
        .A(A),
        .C(C),
        .out(out)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Waveform setup
    initial begin
        $dumpfile("testbench_lfsr_rtl.vcd");
        $dumpvars(0, testbench_lfsr_rtl);
    end

    // --- Main Stimulus ---
    initial begin
        $display("Starting LFSR Integration Test...");
        
        // 1. Correct Reset Pulse
        rst = 0; A = 0; C = 0;
        #20; rst = 1; #20; rst = 0;

        // 2. Set C to 150 (this is > 128)
        // This tells the "brain" to select the LFSR.
        C = 9'd150; 
        A = 10'd0; // The 'A' input is not used by the LFSR, so we can set it to 0.
        #10; 

        // 3. Let the simulation run for a while.
        // We will watch the 'out' signal change on every clock cycle.
        #200; 

        $display("Test Finished.");
        $finish;
    end

    // Monitor for console output
    initial begin
        // Using %h (hex) is often easier to read for random-looking numbers
        $monitor("Time=%0t | C=%d | out=%h", 
                 $time, C, out);
    end

endmodule