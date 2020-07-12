`timescale 1ns / 1ps
module ALU_32(
    input [31:0]A,
    input [31:0]B,
    input [2:0]ALU_OP,
    output reg [31:0]F,
    output wire OF,
    output wire ZF
    );
parameter Zero_32 = 32'h0000_0000, One_32 = 32'h0000_0001;
reg c32;
assign OF = A[31] ^ B[31] ^ F[31] ^ c32;
assign ZF = (F[31:0]== 32'h0000_0000)? 1'b1 : 1'b0;
always@(*)
begin
    c32 = 1'b0;
    case(ALU_OP)
        3'b000: F = A & B;
        3'b001: F = A | B;
        3'b010: F = A ^ B;
        3'b011: F = ~(A | B);
        3'b100: {c32,F} = A + B;
        3'b101: {c32,F} = A - B;
        3'b110: F = (A<B) ? One_32 : Zero_32;
        3'b111: F = B << A;
        default: F=Zero_32;
    endcase
end
endmodule
