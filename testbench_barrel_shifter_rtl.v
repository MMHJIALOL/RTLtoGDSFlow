// testbench_top_shifter.v
`timescale 1ns/1ns

module testbench_barrel_shifter_rtl;

    reg clk, rst;
    reg [9:0] A;
    reg [8:0] C;
    wire [10:0] out;

    rtl_topmodule dut (
        .clk(clk), .rst(rst), .A(A), .C(C), .out(out)
    );

    // Clock and VCD setup
    initial begin clk = 0; forever #5 clk = ~clk; end
    initial begin $dumpfile("testbench_barrel_shifter_rtl.vcd"); $dumpvars(0, testbench_barrel_shifter_rtl); end

    // Stimulus
    initial begin
        // Standard reset pulse
        rst = 0; A = 0; C = 0;
        #20; rst = 1; #20; rst = 0;

        // --- Test the Barrel Shifter Mode ---
        $display("Testing Barrel Shifter...");
        
        // Set C to a value between 51 and 99
        // C=70 means C[2:0] is 3'b110, or 6. We expect a shift left by 6.
        C = 9'd70;
        A = 10'b0000001101; // Input value
        
        // Expected result: 10'b0011010000
        #100;

        $finish;
    end
    
    initial begin
        $monitor("Time=%0t | C=%d, A=%b | out[9:0]=%b", $time, C, A, out[9:0]);
    end

endmodule
