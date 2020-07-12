`timescale 1ns / 1ps
module register_store(
    input Clk,
    input Reset,
    input [6:2] R_Addr_A,       //低2字节对齐，高5字节对应寄存器编号
    input [6:2] R_Addr_B,
    input [6:2] W_Addr,
    input [31:0]W_Data,
    input Write_Reg,            //写信号
    output wire [31:0]R_Data_A,
    output wire [31:0]R_Data_B
    );

//寄存器堆
reg [31:0] REG_files[1:31];

//读操作 组合逻辑电路，没有读出控制信号，随时读
assign R_Data_A = (R_Addr_A==5'b00000)? 32'h0000_0000 : REG_files[R_Addr_A[6:2]];
assign R_Data_B = (R_Addr_B==5'b00000)? 32'h0000_0000 : REG_files[R_Addr_B[6:2]];

//写操作
integer i;
always@(posedge Clk or posedge Reset)
begin
    if(Reset)
        //寄存器堆初始化
        begin
            for(i = 4; i <= 124; i = i + 4)
                REG_files[ i/4 ] = 32'h0000_0000;
        end
    else
        begin
            //仅仅为了测试寄存器堆和ALU的结合情况时
           
            //写入寄存器
           if(Write_Reg && (W_Addr[6:2] != 5'b00000))
                REG_files[W_Addr[6:2]] = W_Data;
        end
end

endmodule
