`timescale 1ns / 1ps

module testbench_2;

    reg clk, rst;
    reg [9:0] A;
    reg [8:0] C;
    wire [10:0] out;
     
    // Instantiate DUT
    rtl_topmodule dut (
        .clk(clk),
        .rst(rst),
        .A(A),
        .C(C),
        .out(out)
    );

    // Clock generator (10 ns period = 100 MHz)
    initial clk = 0;
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        // VCD dump for GTKWave + Covered
        $dumpfile("dump2.vcd");
        $dumpvars(0, testbench_2);

        // Monitor console outputs
        $monitor("Time=%0t | clk=%b rst=%b | A=%d C=%d | out=%d",
                  $time, clk, rst, A, C, out);

        // Init
        rst = 1;
        A   = 10'd45;   // some input for shifter
        C   = 9'd0;

        // Release reset
        #24 rst = 0;

        // Select barrel shifter branch (C between 51–99)
        #20 C = 9'd75;

        // Run for a while then finish
        #500 $finish;
    end

endmodule

