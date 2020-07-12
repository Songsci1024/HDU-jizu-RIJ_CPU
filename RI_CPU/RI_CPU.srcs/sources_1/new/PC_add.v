`timescale 1ns / 1ps
module PC_add(
    input rst,
    input clk,
    output reg[7:0] PC
    );
wire [7:0] PC_new;
assign PC_new = PC + 4;
always@(posedge clk, posedge rst)
begin
    if(rst)
        PC = 32'h0000_0000; //PC清零，即指定MIPS CPU从0号主存开始执行程序
    else                    //clk下降沿，更新PC
        PC = PC_new;
end
endmodule
