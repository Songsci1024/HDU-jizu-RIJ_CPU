`timescale 1ns / 1ps
module top_module(
    input clk,
    input rst,
    input SW,
    output [32:1] LED,
    output [8:1] digital,
    output  Decode_Enable
    );
wire ZF,OF;
wire [32:1] ALU_F, M_R_Data;
RIJ_CPU RIJ(
    .clk        (clk),
    .rst        (rst),
    .OF         (OF),
    .ZF         (ZF),
    .ALU_F      (ALU_F),
    .M_R_Data   (M_R_Data)
);
assign Decode_Enable = 1;
assign LED = (SW) ? ALU_F : M_R_Data;
assign digital[1] = ~ZF;
assign digital[2] = ~OF;
endmodule
