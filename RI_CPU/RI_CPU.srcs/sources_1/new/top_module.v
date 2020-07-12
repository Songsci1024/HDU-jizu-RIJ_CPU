`timescale 1ns / 1ps

module top_module(
    input clk,
    input rst,
    output OF,   //被运算影响的标志位
    output ZF
    );
wire [31:0]ALU_F;
wire [7:0] PC;
wire [31:0] Inst_code;
wire [31:0] ALU_A,ALU_B;
wire Write_Reg;
wire [2:0] ALU_OP;
wire [5:0]OP,func;
wire [4:0]Rs,Rt,Rd;

//---------以下I型指令相关
wire rt_rd_s, imm_s, rt_imm_s, alu_mem_s;      //二选一数据选择信号
wire [4:0]W_Addr;
wire [15:0] imm;
wire [31:0] imm_data;
wire Mem_Write;
wire [31:0] M_W_Data, M_R_Data;
wire [31:0] W_Data, R_Data_B;
wire clk_ram;
assign OP =  Inst_code[31:26];
assign Rs =  Inst_code[25:21];
assign Rt =  Inst_code[20:16];
assign Rd =  Inst_code[15:11];
assign func =  Inst_code[5:0];
assign imm  = Inst_code[15:0];

assign W_Addr = (rt_rd_s) ? Rt : Rd;
assign W_Data = (alu_mem_s) ? M_R_Data : ALU_F; //lw写入寄存器
assign imm_data = (imm_s)? {{16{imm[15]}},imm} : {{16{1'b0}},imm};  //存取数的offset
assign ALU_B = (rt_imm_s) ? imm_data : R_Data_B;
assign M_W_Data = R_Data_B;     //sw将（Rt）M_W_Data数据写入rs+offset 数据存储器

assign #10 clk_ram = clk;   //延时数据寄存器的时钟周期

//PC自增模块，输出更新的PC值
PC_add  auto_increase_pc(
    .clk        (clk),
    .rst        (rst),
    .PC         (PC)
);

//指令寄存器模块，输入寄存器地址，输入地址上的指令数据
blk_mem_gen_0 Inst_store (
  .clka         (clk),
  .addra        (PC[7:2]),
  .douta        (Inst_code)
);
//数据寄存器模块
blk_mem_gen_1 mem_store (
  .clka         (clk_ram),    // 时钟
  .wea          (Mem_Write),      // 写入信号
  .addra        (ALU_F[7:2]),  // 写入地址
  .dina         (M_W_Data),    // 写入数据
  .douta        (M_R_Data)  // 输出数据
);
register_store reg_store(
    .Clk        (~clk),
    .Reset      (rst),
    .R_Addr_A   (Rs),
    .R_Addr_B   (Rt),
    .W_Addr     (W_Addr),
    .W_Data     (W_Data),
    .Write_Reg  (Write_Reg),
    .R_Data_A   (ALU_A),
    .R_Data_B   (R_Data_B)

);

//ALU运算，结果存入W_Data，通过时序逻辑电路写入寄存器
ALU_32 alu(
    .clk        (~clk),
    .rst        (rst),
    .A          (ALU_A),        //ALU_A输入是从R_Data_A来的
    .B          (ALU_B),
    .ALU_OP     (ALU_OP),
    .F          (ALU_F),
    .FR_ZF      (ZF),
    .FR_OF      (OF)
);

//指令译码和控制单元
Decoding_control Decode_control(
    .OP         (OP),
    .rt_rd_s    (rt_rd_s),
    .imm_s      (imm_s),
    .rt_imm_s   (rt_imm_s),
    .alu_mem_s  (alu_mem_s),
    .Mem_Write  (Mem_Write),
    .func       (func),
    .Write_Reg  (Write_Reg),
    .ALU_OP     (ALU_OP)
);

endmodule
