`timescale 1ns / 1ps

module top_module_sim();
reg clk,rst;
wire OF,ZF;
wire [31:0] ALU_F,M_R_Data;

RIJ_CPU test(
    .clk          (clk),
    .rst            (rst),
    .OF             (OF),
    .ZF             (ZF),
    .ALU_F          (ALU_F),
    .M_R_Data       (M_R_Data)
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
