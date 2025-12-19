`timescale 1ns / 1ps

module parity_gen (
    input  wire [9:0] data_in,
    output wire       parity
);

    assign parity = ^data_in;  // XOR reduction = parity bit

endmodule

