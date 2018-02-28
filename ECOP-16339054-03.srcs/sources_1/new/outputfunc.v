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
      // ��PCWre��ֵ
      if (state == 3'b000 && op != 6'b111111) PCWre = 1; 
      else PCWre = 0;//ֻ��IF״̬�Ҳ���haltָ��ʱ�����Ը���pcֵ
      // ��InsMemRW��ֵ
      InsMemRW = 1;//ʼ�ն�ָ��洢�����ж�����
      // ��IRWre��ֵ
      if (state == 3'b000) IRWre = 1;//ֻ��IF״̬���Զ�ȡIRreg���ֵ
      else IRWre = 0;
      // ��WrRegDSrc��ֵ
      if (state == 3'b011) WrRegDSrc = 1;//��ִֹ��jal���ʱ���ݳ�ͻֻ������WB�׶�Ϊ1
      else WrRegDSrc = 0;
      // ��RegWre��ֵ
      if (state == 3'b011 || (op == 6'b111010&&state !=  3'b000)) RegWre = 1; // ֻ��д��׶ο���д���ݣ�jalָ��ʱ��ֹ��IF�׶�д����
      else RegWre = 0;
      // ��ALUSrcA��ֵ
      if (op == 6'b011000) ALUSrcA = 1;//sllָ��ʱΪ1
      else ALUSrcA = 0;
      // ��ALUSrcB��ֵ
      if (op == 6'b000010 || op == 6'b010010 || op== 6'b100111 || op == 6'b110001||op == 6'b110000) ALUSrcB = 1;//addi��ori��lw��swָ��ʱΪ1
      else ALUSrcB = 0;
      // ��RW��ֵ
      if (state == 3'b011 && op == 6'b110000) RW = 1;//ֻ��MEM����ָ��SWʱ����д�����ݼĴ���
      else RW = 0;
      // ��DBDataSrc��ֵ
      if (op==6'b110001) DBDataSrc = 1;//lwָ��ʱΪ1
      else DBDataSrc = 0;
      // ��ExtSel��ֵ
      if (op == 6'b010010) ExtSel = 0;//oriָ��Ϊ0
      else ExtSel = 1;
      // ��RegDst��ֵ
      if (op == 6'b111010) RegDst = 2'b00;//jalָ��
      else if (op == 6'b000010 || op == 6'b010010 || op == 6'b110001) RegDst = 2'b01;//addi��ori��lw
      else RegDst = 2'b10;
       // ��PCSrc��ֵ
      if(op==6'b111000||op == 6'b111010) PCSrc = 2'b11;//j��jalָ��
      else if(op == 6'b111001)  PCSrc = 2'b10;//jrָ��
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
      // ��ALUOp��ֵ
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