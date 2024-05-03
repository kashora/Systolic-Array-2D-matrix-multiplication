module PE(
    input clk_i, rst_i,
    input [3:0] top_i, left_i,
    output reg [3:0] bottom_o, right_o,
    // Each multiplication is 8-bits wide and we might add up to 8 of them (max n=8) so max is 11 bits
    input wire [3:0] accum_i,
    output wire [3:0] accum_o
);
wire [3:0] product; // 8-bit product of top_i and left_i

assign product = top_i * left_i;

assign accum_o = (rst_i) ? 4'd0 : accum_i + product;


always @(posedge clk_i or posedge rst_i) begin

    //$display("PE: prev_val = %0d, top_i = %0d, left_i = %0d, right_i = %0d ,product = %0d, new_val = %0d", accum_i, top_i, left_i, right_o, product, accum_o);
    if (rst_i)  begin
        bottom_o = 0;
        right_o = 0;       
    end else begin
        bottom_o = top_i;
        right_o = left_i;
    end
end

endmodule