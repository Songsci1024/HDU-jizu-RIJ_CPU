`timescale 1ns / 1ps
module PC_add(
    input rst,
    input clk,
    input [1:0] pc_s,
    input [31:0] R_Data_A,
    input [31:0] imm_data,
    input [25:0] address,
    output reg[31:0] PC
    );
wire [31:0] PC_new;
assign PC_new = PC + 4;
always@(posedge clk, posedge rst)
begin
    if(rst)
        PC = 32'h0000_0000; //PC清零，即指定MIPS CPU从0号主存开始执行程序
    else
    begin                      //clk下降沿，更新PC
        case(pc_s)
        2'b00: PC = PC_new;
        2'b01: PC = R_Data_A;                   //jr
        2'b10: PC = PC_new+(imm_data<<2);       //bne beq
        2'b11: PC = {PC_new[31:28], address, 2'b00};        //jal address
        default: PC = PC_new;
        endcase
    end
end
endmodule
