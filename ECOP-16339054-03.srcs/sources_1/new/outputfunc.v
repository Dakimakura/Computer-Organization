`timescale 1ns / 1ps
module outputfunc(
   input [2:0] state,
   input [5:0] op,
   input zero,
   input sign,
   output reg PCWre, ALUSrcB, ALUSrcA,RW, RegWre, InsMemRW, ExtSel, DBDataSrc,WrRegDSrc,IRWre,
   output reg[1:0] PCSrc,RegDst,  
   output reg [2:0] ALUOp  
    );

    
   always @(state) begin
      // 对PCWre定值
      if (state == 3'b000 && op != 6'b111111) PCWre = 1; 
      else PCWre = 0;//只有IF状态且不是halt指令时，可以更新pc值
      // 对InsMemRW定值
      InsMemRW = 1;//始终对指令存储器进行读操作
      // 对IRWre定值
      if (state == 3'b000) IRWre = 1;//只有IF状态可以读取IRreg里的值
      else IRWre = 0;
      // 对WrRegDSrc定值
      if (state == 3'b011) WrRegDSrc = 1;//防止执行jal语句时数据冲突只允许在WB阶段为1
      else WrRegDSrc = 0;
      // 对RegWre定值
      if (state == 3'b011 || (op == 6'b111010&&state !=  3'b000)) RegWre = 1; // 只有写入阶段可以写数据，jal指令时防止在IF阶段写数据
      else RegWre = 0;
      // 对ALUSrcA定值
      if (op == 6'b011000) ALUSrcA = 1;//sll指令时为1
      else ALUSrcA = 0;
      // 对ALUSrcB定值
      if (op == 6'b000010 || op == 6'b010010 || op== 6'b100111 || op == 6'b110001||op == 6'b110000) ALUSrcB = 1;//addi、ori、lw、sw指令时为1
      else ALUSrcB = 0;
      // 对RW定值
      if (state == 3'b011 && op == 6'b110000) RW = 1;//只有MEM且是指令SW时可以写入数据寄存器
      else RW = 0;
      // 对DBDataSrc定值
      if (op==6'b110001) DBDataSrc = 1;//lw指令时为1
      else DBDataSrc = 0;
      // 对ExtSel定值
      if (op == 6'b010010) ExtSel = 0;//ori指令为0
      else ExtSel = 1;
      // 对RegDst定值
      if (op == 6'b111010) RegDst = 2'b00;//jal指令
      else if (op == 6'b000010 || op == 6'b010010 || op == 6'b110001) RegDst = 2'b01;//addi、ori、lw
      else RegDst = 2'b10;
       // 对PCSrc定值
      if(op==6'b111000||op == 6'b111010) PCSrc = 2'b11;//j、jal指令
      else if(op == 6'b111001)  PCSrc = 2'b10;//jr指令
      else if(op ==6'b110100) begin
           if (zero) PCSrc = 2'b01;//beq(zero=1)
           else PCSrc = 2'b00;//beq(zero=0)
      end
      else  if(op ==6'b110101) begin
            if (zero==0) PCSrc = 2'b01;//bne(zero=0)
            else PCSrc = 2'b00;//bne(zero=1)
      end
      else  if(op ==6'b110110) begin
            if (zero==0 && sign == 0 ) PCSrc = 2'b01;//bgtz(zero=0 and sign == 0)
            else PCSrc = 2'b00;//bgtz(zero=1 or sign = 1)
      end
      else  PCSrc = 2'b00;
      // 对ALUOp定值
      if(op==6'b000000||op==6'b000010||op==6'b110000||op==6'b110001) ALUOp = 3'b000;//add,addi,sw,lw
      else if(op==6'b000001||op==6'b110100||op==6'b110101|| op == 6'b110110)  ALUOp = 3'b001;//sub,beq,bne,bgtz
      //else if(op==6'b100111)    ALUOp = 3'b010;//sltu
      else if(op==6'b100110||op==6'b100111)    ALUOp = 3'b011;//slt,slti
      else if(op==6'b011000)    ALUOp = 3'b100;//sll
      else if(op==6'b010000||op==6'b010010) ALUOp = 3'b101;//or,ori
      else if(op==6'b010001)   ALUOp = 3'b110;//and
      else ALUOp = 3'b000;
    end
endmodule