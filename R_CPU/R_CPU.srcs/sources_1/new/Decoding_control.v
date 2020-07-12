`timescale 1ns / 1ps

module Decoding_control(
    input clk,
    input rst,
    input [5:0] OP,
    input [5:0] func,
    input ZF,
    input OF,
    output reg FR_ZF,
    output reg FR_OF,
    output reg Write_Reg,
    output reg[3:0] ALU_OP
    );

reg Set_ZF,Set_OF;

always @(posedge rst or posedge clk)
   begin
      if (rst)   
          begin   
            FR_ZF <= 1'b0;
            FR_OF <= 1'b0;
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
    ALU_OP = 3'b000;    Write_Reg = 1'b0;     Set_ZF = 1'b0;    Set_OF = 1'b0;
    
    if(OP == 6'b000000)
    begin
        Write_Reg = 1'b1;    Set_ZF = 1'b1;
        case(func)
            6'b100000: begin ALU_OP = 3'b100; Set_OF = 1'b1; end    //add
            6'b100010: begin ALU_OP = 3'b101; Set_OF = 1'b1; end    //sub
            6'b100100: ALU_OP = 3'b000; //and
            6'b100101: ALU_OP = 3'b001; //or
            6'b100110: ALU_OP = 3'b010; //xor
            6'b100111: ALU_OP = 3'b011; //nor
            6'b101011: ALU_OP = 3'b110; //sltu
            6'b000100: ALU_OP = 3'b111; //sllv
        endcase
    end
end
endmodule
