`timescale 1ns / 1ps

module top_module(
    input clk,
    input rst,
    output OF,   //被运算影响的标志位
    output ZF,
    output [31:0] ALU_F
    );
wire [7:0] PC;
wire [31:0] Inst_code;
wire [31:0] ALU_A,ALU_B;
wire Write_Reg;
wire [2:0] ALU_OP;
wire [5:0]OP,func;
wire [4:0]Rs,Rt,Rd;
wire OF_,ZF_;   //未被确认是否由运算影响的标志位
assign OP =  Inst_code[31:26];
assign Rs =  Inst_code[25:21];
assign Rt =  Inst_code[20:16];
assign Rd =  Inst_code[15:11];
assign func =  Inst_code[5:0];

//PC自增模块，输出更新的PC值
PC_add  auto_increase_pc(
    .clk        (~clk),
    .rst        (rst),
    .PC         (PC)
);

//指令寄存器模块，输入寄存器地址，输入地址上的指令数据
blk_mem_gen_0 Inst_store (
  .clka         (clk),
  .addra        (PC[7:2]),
  .douta        (Inst_code)
);

register_store reg_store(
    .Clk        (~clk),
    .Reset      (rst),
    .R_Addr_A   (Rs),
    .R_Addr_B   (Rt),
    .W_Addr     (Rd),
    .W_Data     (ALU_F),
    .Write_Reg  (Write_Reg),
    .R_Data_A   (ALU_A),
    .R_Data_B   (ALU_B)

);

//ALU运算，结果存入W_Data，通过时序逻辑电路写入寄存器
ALU_32 alu(
    .A          (ALU_A),        //ALU_A输入是从R_Data_A来的
    .B          (ALU_B),
    .ALU_OP     (ALU_OP),
    .F          (ALU_F),
    .ZF         (ZF_),
    .OF         (OF_)
);

//指令译码和控制单元
Decoding_control Decode_control(
    .clk        (~clk),
    .rst        (rst),
    .ZF         (ZF_),
    .OF         (OF_),
    .OP         (OP),
    .func       (func),
    .FR_ZF      (ZF),
    .FR_OF      (OF),
    .Write_Reg  (Write_Reg),
    .ALU_OP     (ALU_OP)
);
endmodule
