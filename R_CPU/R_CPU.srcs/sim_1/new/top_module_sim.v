`timescale 1ns / 1ps

module top_module_sim();
reg clk,rst;
wire OF,ZF;
wire [31:0] ALU_F;

top_module test(
    .clk            (clk),
    .rst            (rst),
    .OF             (OF),
    .ZF             (ZF),
    .ALU_F          (ALU_F)
);
initial
begin
#0
    clk = 0;
    rst = 1;
#10
    rst = 0;
end
always #20 clk = ~clk;
endmodule
