`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/05 20:09:28
// Design Name: 
// Module Name: RegFile
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


module RegFile(
    input clk,RegWre,WrRegDSrc,
    input [1:0] RegDst,
    input [4:0] rs,rt,rd,
    input [31:0] PC4,DBlate,
    output [31:0] readData1,readData2
    );
    
    wire [31:0] WriteData;
    reg [4:0] WriteReg;
    
    assign WriteData = WrRegDSrc ? DBlate : PC4;
    
   reg [31:0] register [0:31];  
   integer i;  
   initial begin  
       for (i = 0 ; i < 32; i = i+1)   
             register[i] = 0;  
   end
   
   always @(RegDst or rt or rd) 
   begin
        case(RegDst)
            2'b00 : WriteReg = 5'b11111;
            2'b01 : WriteReg = rt;
            2'b10 : WriteReg = rd;
            default : WriteReg = 0;
        endcase
   end
   
   always@(WriteData or WriteReg) begin
       if( WriteReg != 0 && RegWre == 1)
            register[WriteReg] <= WriteData;
   end
   
   assign readData1 = register[rs];
   assign readData2 = register[rt];
   
endmodule
