`timescale 1ns / 1ps
module rtl_topmodule (
    input  wire        clk,
    input  wire        rst,
    input  wire [9:0]  A,
    input  wire [8:0]  C,
    output reg  [10:0] out
);
    reg [9:0]  A_reg;
    reg [8:0]  C_reg;
    reg [10:0] out_reg;
    always @(posedge clk) begin
        if (rst) begin
            A_reg <= 10'd0;
            C_reg <= 9'd0;
        end else begin
            A_reg <= A;
            C_reg <= C;
        end
    end

    wire clk_div;
    clk_divider #(.div_value(4)) u1 (
        .clk_in (clk),
        .clk_out(clk_div)
    );

    wire [9:0] shifter_out;
    barrel_shifter u2 (
        .data_in (A_reg),
        .shift_amt(C_reg[2:0]),
        .data_out(shifter_out)
    );

    wire [9:0] lfsr_out;
    lfsr #(.WIDTH(10)) u3 (
        .clk(clk),
        .rst(rst),
        .rnd(lfsr_out)
    );

    wire parity_out;
    parity_gen u4 (
        .data_in(A_reg),
        .parity (parity_out)
    );

    always @(*) begin
        if (C_reg < 9'd51) begin
            out_reg = {10'd0, clk_div};
        end else if (C_reg < 9'd100) begin
            out_reg = {1'd0, shifter_out};
        end else if (C_reg <= 9'd128) begin
            out_reg = {10'd0, parity_out};
        end else begin
            out_reg = {1'd0, lfsr_out};
        end
    end

    always @(posedge clk) begin
        if (rst) out <= 11'd0;
        else     out <= out_reg;
    end
endmodule

