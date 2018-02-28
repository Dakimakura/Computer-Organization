`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/06 01:18:37
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MCPU(
    input clk,Reset,
    output PCWre,
    output [31:0] pc,instruction,
    output [5:0] op,
    output [4:0] rs,rt,rd,sa,
    output [31:0] readData1,readData2,
    output [31:0] ALUResult,
    output ALUSrcB,ALUSrcA,InsMemRW,ExtSel,
    output DBDataSrc,WrRegDSrc,IRWre,RW,RegWre,
    output [1:0] PCSrc,RegDst,
    output [2:0] ALUOp,
    output [31:0] immediate_32,DataOut,DB,ins,
    output [31:0] out1,out2,ALUOut,DBlate,
    output zero,sign
    );
    assign op = instruction[31:26];
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign sa = instruction[10:6];
    //控制信号
   // wire ALUSrcB,ALUSrcA,InsMemRW,ExtSel;
   // wire DBDataSrc,WrRegDSrc,IRWre,RW,RegWre;
  //  wire [1:0] PCSrc,RegDst;
   // wire [2:0] ALUOp;
    
    //数据通路
   // wire [31:0] immediate_32,DataOut,DB,ins;
  //  wire [31:0] out1,out2,ALUOut,DBlate;         //延迟
   // wire zero,sign;
    
    //操作函数
    PC PC(clk,Reset,PCWre,PCSrc,instruction[25:0],immediate_32,readData1,pc);
    
    Extend Extend(ExtSel,instruction[15:0],immediate_32);
    
    InsMemory InsMemory(InsMemRW,pc,ins);
    
    IR IR(clk,IRWre,ins,instruction);
    
    RegFile RegFile(clk,RegWre,WrRegDSrc,RegDst,rs,rt,rd,(pc+4),DBlate,readData1,readData2);

    ADR ADR(clk,readData1,out1);
    
    BDR BDR(clk,readData2,out2);
    
    ALU ALU(ALUSrcA,ALUSrcB,out1,out2,immediate_32,sa,ALUOp,zero,sign,ALUResult);
    
    ALUoutDR ALUoutDR(clk,ALUResult,ALUOut);
    
    DBDR DBDR(clk,DB,DBlate);
    
    DataMemory DataMemory(RW,ALUOut,out2,DataOut);
    
    SelectDB SelectDB(DBDataSrc,ALUResult,DataOut,DB);
    
    ControlUnit ControlUnit( op,zero, sign, clk, Reset,  PCWre, ALUSrcB, ALUSrcA,RW, RegWre, InsMemRW, ExtSel, DBDataSrc,WrRegDSrc,IRWre,PCSrc,RegDst,ALUOp);
    
endmodule
