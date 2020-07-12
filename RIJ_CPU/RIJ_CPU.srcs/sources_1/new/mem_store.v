`timescale 1ns / 1ps
module mem_store(
    input Clk,
    input Reset,
    input [7:2] addra,       
    input [31:0]M_W_Data,
    input Mem_Write,            //Ð´ÐÅºÅ
    output wire [31:0]M_R_Data
    );

//¼Ä´æÆ÷¶Ñ
reg [31:0] Mem_files[0:63];

//¶Á²Ù×÷ ×éºÏÂß¼­µçÂ·£¬Ã»ÓÐ¶Á³ö¿ØÖÆÐÅºÅ£¬ËæÊ±¶Á
assign M_R_Data = Mem_files[addra[7:2]];

//Ð´²Ù×÷
integer i;
always@(posedge Clk or posedge Reset)
begin
    if(Reset)
        //¼Ä´æÆ÷¶Ñ³õÊ¼»¯
        begin
            Mem_files[0] = 32'h88888888; 
            Mem_files[1] = 32'h99999999;
            Mem_files[2] = 32'h00010fff;
            Mem_files[3] = 32'h20006789;
            Mem_files[4] = 32'hFFFF0000;
            Mem_files[5] = 32'h0000FFFF;
            Mem_files[6] = 32'h88888888;
            Mem_files[7] = 32'h99999999;
            Mem_files[8] = 32'haaaaaaaa;
            Mem_files[9] = 32'hbbbbbbbb; 
            Mem_files[10] = 32'h00000820;
            Mem_files[11] = 32'h00632020; 
            Mem_files[12] = 32'h00010fff;
            Mem_files[13] = 32'h20006789;
            Mem_files[14] = 32'hffff0000;
            Mem_files[15] = 32'h00001111;
            Mem_files[16] = 32'h00002222;
            Mem_files[17] = 32'h00003333; 
            Mem_files[18] = 32'h00004444; 
            Mem_files[19] = 32'h00005555;
            Mem_files[20] = 32'h00006666;
            Mem_files[21] = 32'h00007777; 
            Mem_files[22] = 32'h00008888;
            Mem_files[23] = 32'h00009999;
            Mem_files[24] = 32'haaaa0000;
            Mem_files[25] = 32'hbbbb0000; 
            Mem_files[26] = 32'hcccc0000;
            Mem_files[27] = 32'hdddd0000;
            Mem_files[28] = 32'heeee0000; 
            Mem_files[29] = 32'hffff0000; 
            Mem_files[30] = 32'h11110000; 
            Mem_files[31] = 32'h22220000; 
            Mem_files[32] = 32'h33330000;
            Mem_files[33] = 32'h44440000;
            Mem_files[34] = 32'h55550000;
            Mem_files[35] = 32'h66660000; 
            Mem_files[36] = 32'h77770000;
            Mem_files[37] = 32'h88880000; 
            Mem_files[38] = 32'h99990000;
            Mem_files[39] = 32'haaaaaaaa; 
            Mem_files[40] = 32'hbbbbbbbb;
            Mem_files[41] = 32'h00000820;
            Mem_files[42] = 32'h00632020;
            Mem_files[43] = 32'h00010fff; 
            Mem_files[44] = 32'h20006789; 
            Mem_files[45] = 32'hffff0000; 
            Mem_files[46] = 32'h0000ffff; 
            Mem_files[47] = 32'h88888888;
            Mem_files[48] = 32'h99999999;
            Mem_files[49] = 32'haaaaaaaa; 
            Mem_files[50] = 32'hbbbbbbbb;
            Mem_files[51] = 32'h00000820;
            Mem_files[52] = 32'h00632020; 
            Mem_files[53] = 32'h00010fff; 
            Mem_files[54] = 32'h20006789;
            Mem_files[55] = 32'hffff0000;
            Mem_files[56] = 32'h0000ffff;
            Mem_files[57] = 32'h88888888;
            Mem_files[58] = 32'h99999999;
            Mem_files[59] = 32'haaaaaaaa;
            Mem_files[60] = 32'hbbbbbbbb;
            Mem_files[61] = 32'h12345678;
            Mem_files[62] = 32'h23456789;
            Mem_files[63] = 32'h3456789a;
        end
    else
        begin
            //Ð´Èë¼Ä´æÆ÷
            if(Mem_Write)
                Mem_files[addra[7:2]] = M_W_Data;
        end
end

endmodule
