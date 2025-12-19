`timescale 1ns / 1ps

module barrel_shifter (
    input  wire [9:0] data_in,     // 10-bit input
    input  wire [2:0] shift_amt,   // shift amount (0–7)
    output reg  [9:0] data_out     // shifted result
);

    always @(*) begin
        case (shift_amt)
            3'd0: data_out = data_in;
            3'd1: data_out = data_in << 1;
            3'd2: data_out = data_in << 2;
            3'd3: data_out = data_in << 3;
            3'd4: data_out = data_in << 4;
            3'd5: data_out = data_in << 5;
            3'd6: data_out = data_in << 6;
            3'd7: data_out = data_in >> 1; // just for variety, shift right
            default: data_out = data_in;
        endcase
    end

endmodule

