// testbench_clk_divider.v
`timescale 1ns/1ns

module testbench_clk_divider;

    reg clk_in;
    reg rst;
    wire clk_out;
    reg [9:0] A;
    reg [8:0] C;

    clk_divider #(.div_value(10)) dut (
        .clk_in(clk_in), .rst(rst), .clk_out(clk_out)
    );

    initial begin
        clk_in = 1'b0;
        forever #5 clk_in = ~clk_in;
    end

    // Use your preferred VCD filename
    initial begin
        $dumpfile("testbench_clk_divider.vcd"); 
        $dumpvars(0, testbench_clk_divider);
    end

    // Correct, stabilized reset pulse and A/C stimulus
    initial begin
        rst = 0; A = 0; C = 0;
        #20;
        rst = 1;
        #20;
        rst = 0;
        
        A = 10'd150; C = 9'd25;
        #200;
        A = 10'd327; C = 9'd60;
        #200;
        A = 10'd99; C = 9'd115;
        
        #560;
        $finish;
    end
endmodule
