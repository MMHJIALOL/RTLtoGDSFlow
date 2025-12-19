`timescale 1ns / 1ps

module lfsr #(parameter WIDTH = 10)(
    input  wire clk,
    input  wire rst,
    output reg [WIDTH-1:0] rnd
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rnd <= {WIDTH{1'b1}}; // seed: all 1s
        end else begin
            // Example taps for 10-bit LFSR: bits 9 and 6
            rnd <= {rnd[WIDTH-2:0], rnd[WIDTH-1] ^ rnd[6]};
        end
    end

endmodule

