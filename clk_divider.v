// clk_divider.v
module clk_divider #(parameter div_value = 10)(
    input  wire clk_in,
    input  wire rst,
    output reg  clk_out = 1'b0
);
    reg [3:0] count = 4'd0;
    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            // This logic is active on the RISING EDGE of reset.
            count   <= 4'd0;
            clk_out <= 1'b0;
        end else begin
            // This logic is active on the RISING EDGE of the clock.
            if (count == div_value - 1) begin
                count   <= 4'd0;
                clk_out <= ~clk_out;
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule
