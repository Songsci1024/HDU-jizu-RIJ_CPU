`timescale 1ns / 1ps

module top_module_sim();
reg clk,rst;
wire OF,ZF;
wire [31:0] ALU_F;

top_module test(
    .clk          (clk),
    .rst            (rst),
    .OF             (OF),
    .ZF             (ZF)
);

initial
begin
#0
    clk = 0;
    rst = 1;
#100
    rst = 0;
end
always #100 clk = ~clk;
endmodule
