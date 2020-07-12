`timescale 1ns / 1ps

module Decoding_control(
    input [5:0] OP,
    input [5:0] func,
    input ZF,
    input OF,
    output reg [1:0] w_r_s,
    output reg imm_s,
    output reg rt_imm_s,
    output reg [1:0] wr_data_s,
    output reg Mem_Write,
    output reg Write_Reg,
    output reg [1:0] PC_s,
    output reg[2:0] ALU_OP
    );

always@(*)
begin
    ALU_OP = 3'b000;    Write_Reg = 1'b0;   w_r_s = 2'b00;
    rt_imm_s = 1'b0;      imm_s = 1'b0;     wr_data_s = 2'b00;
    Mem_Write = 1'b0;   PC_s = 2'b00;
    //===============R型指令
    if(OP == 6'b000000)
    begin
        Write_Reg = 1'b1;
        case(func)
            6'b100000: ALU_OP = 3'b100; //add
            6'b100010: ALU_OP = 3'b101; //sub
            6'b100100: ALU_OP = 3'b000; //and
            6'b100101: ALU_OP = 3'b001; //or
            6'b100110: ALU_OP = 3'b010; //xor
            6'b100111: ALU_OP = 3'b011; //nor
            6'b101011: ALU_OP = 3'b110; //sltu
            6'b000100: ALU_OP = 3'b111; //sllv
            6'b001000: begin PC_s = 2'b01; Write_Reg = 1'b0; end    //jr
        endcase
    end
    //===============I型指令
    else if(OP[5:3] == 3'b001)
    begin        
        Write_Reg = 1'b1;    w_r_s = 2'b01;    rt_imm_s = 1'b1;   
        case(OP[2:0])
            3'b000: begin ALU_OP = 3'b100; imm_s = 1'b1; end   //addi 有符号数扩展
            3'b100: ALU_OP = 3'b000; //andi
            3'b110: ALU_OP = 3'b010; //xori
            3'b011: ALU_OP = 3'b110; //sltiu
        endcase
    end
    //===========I型指令取存数指令
    else if(OP == 6'b100011 || OP == 6'b101011)
    begin
        rt_imm_s = 1'b1; imm_s = 1'b1;
        ALU_OP = 3'b100;    //ALU加法运算用于计算rs+offset
        if(OP == 6'b100011)         //lw
        begin
            Write_Reg = 1'b1;
            w_r_s = 2'b01;
            wr_data_s = 2'b01;
        end
        else                        //sw
            Mem_Write = 1'b1;       //数据寄存器写入信号置1         
    end
    //===========I型指令判断条件转移指令
    else if(OP == 6'b000100 || OP == 6'b000101)
    begin
        ALU_OP = 3'b101;    imm_s = 1'b1;
        if(OP == 6'b000100)
        begin
            if(ZF)  //beq 相等返回1满足条件
                PC_s = 2'b10;
        end
        else
        begin
            if(ZF == 0) //bne 不相等返回0满足条件
                PC_s = 2'b10;
        end
    end
    //===========J型指令无条件转移指令
    else if(OP == 6'b000010 || OP == 6'b000011)
    begin
        PC_s = 2'b11;
        if(OP == 6'b000011)
        begin
            w_r_s[1] = 1'b1;
            wr_data_s[1] = 1'b1;
            Write_Reg = 1'b1;
        end
    end
end
endmodule
