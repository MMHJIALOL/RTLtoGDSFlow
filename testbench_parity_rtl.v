`timescale 1ns/1ns

module testbench_parity_rtl;

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
        $dumpfile("testbench_parity_rtl.vcd");
        $dumpvars(0, testbench_parity_rtl);
    end

    // --- Main Stimulus ---
    initial begin
        $display("Starting Parity Generator Integration Test...");
        
        // 1. Correct Reset Pulse
        rst = 0; A = 0; C = 0;
        #20; rst = 1; #20; rst = 0;

        // 2. Set C to 110 (this is in the range 100 to 128)
        // This tells the "brain" to select the Parity Generator
        C = 9'd110; 
        #10; 

        // 3. Test Case A: Input with ODD number of 1s
        // Binary: 00 0000 0001 (One '1') -> Parity should be 1
        A = 10'b0000000001; 
        #20; // Wait for clock edge to register the output

        // 4. Test Case B: Input with EVEN number of 1s
        // Binary: 00 0000 0011 (Two '1's) -> Parity should be 0
        A = 10'b0000000011; 
        #20;

        // 5. Test Case C: All 1s
        // Binary: 11 1111 1111 (Ten '1's - Even) -> Parity should be 0
        A = 10'b1111111111; 
        #20;

        // 6. Test Case D: Nine 1s
        // Binary: 11 1111 1110 (Nine '1's - Odd) -> Parity should be 1
        A = 10'b1111111110; 
        #20;

        $display("Test Finished.");
        $finish;
    end

    // Monitor for console output
    initial begin
        $monitor("Time=%0t | C=%d | A=%b | out[0] (Parity)=%b", 
                 $time, C, A, out[0]);
    end

endmodule