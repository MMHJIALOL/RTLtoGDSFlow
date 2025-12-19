// testbench_barrel_shifter.v
`timescale 1ns/1ns

module testbench_barrel_shifter;

    reg  [9:0] data_in;
    reg  [2:0] shift_amt;
    wire [9:0] data_out;
    
    // Instantiate the DUT
    barrel_shifter dut (
        .data_in(data_in),
        .shift_amt(shift_amt),
        .data_out(data_out)
    );
    
    // VCD Dump
    initial begin
        $dumpfile("testbench_barrel_shifter_only.vcd");
        $dumpvars(0, testbench_barrel_shifter);
    end

    // Stimulus to get 100% coverage
    initial begin
        // Set an interesting value to shift
        data_in = 10'b0001101001; 
        
        // Loop through all possible shift amounts to test every case
        for (integer i = 0; i < 8; i = i + 1) begin
            shift_amt = i;
            #20; // Wait 20ns for each case
        end
        
        $finish;
    end
    
    // Monitor
    initial begin
        $monitor("Time=%0t | data_in=%b shift_amt=%d | data_out=%b",
                 $time, data_in, shift_amt, data_out);
    end
    
endmodule
