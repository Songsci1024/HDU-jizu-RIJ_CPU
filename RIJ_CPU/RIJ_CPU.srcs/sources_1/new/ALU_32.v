`timescale 1ns / 1ps
module ALU_32(
    input clk,
    input rst,
    input [31:0]A,
    input [31:0]B,
    input [2:0]ALU_OP,
    output reg [31:0]F,
    output reg FR_OF,
    output reg FR_ZF
    );
parameter Zero_32 = 32'h0000_0000, One_32 = 32'h0000_0001;
reg c32;
wire OF,ZF;
assign OF = A[31] ^ B[31] ^ F[31] ^ c32;
assign ZF = (F[31:0]== 32'h0000_0000)? 1'b1 : 1'b0;
reg Set_ZF,Set_OF;
always @(posedge rst or posedge clk)
   begin
      if (rst)   
          begin   
            FR_ZF <= 1'b0;
            FR_OF <= 1'b0;
            Set_ZF <=1'b0;
            Set_OF <=1'b0;
          end
      else
          //标志寄存器的更新 如果标志位被影响，就更新
          begin
            if (Set_ZF) FR_ZF <= ZF;
            else FR_ZF <= 0;
            
            if (Set_OF) FR_OF <= OF;
            else FR_OF <= 0;        //无影响标志位都做清零处理

          end
   end
always@(*)
begin
    c32 = 1'b0; Set_ZF = 1'b1; Set_OF = 1'b0;
    case(ALU_OP)
        3'b000: F = A & B;
        3'b001: F = A | B;
        3'b010: F = A ^ B;
        3'b011: F = ~(A | B);
        3'b100: begin {c32,F} = A + B; Set_OF = 1'b1; end
        3'b101: begin {c32,F} = A - B; Set_OF = 1'b1; end
        3'b110: F = (A<B) ? One_32 : Zero_32;
        3'b111: F = B << A;
        default: F=Zero_32;
    endcase
end
endmodule
