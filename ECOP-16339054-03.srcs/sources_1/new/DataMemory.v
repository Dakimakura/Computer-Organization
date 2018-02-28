`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/05 22:09:30
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input RW,
    input [31:0] DAddr,
    input [31:0] DataIn,
    output reg [31:0] DataOut
    );
    
    reg [7:0] mem [0:63]; //´æ´¢Æ÷
    integer i;  
    initial begin  
             for (i = 0; i < 63; i = i+1) mem[i] <= 0;  
    end  //´æ´¢Æ÷³õÊ¼»¯
                
     always@(DAddr or DataIn or RW ) 
         begin
             if( RW )  //1ÎªÐ´
                 begin
                    mem[DAddr+3] = DataIn[31:24];
                    mem[DAddr+2] = DataIn[23:16];
                    mem[DAddr+1] = DataIn[15:8];
                    mem[DAddr] = DataIn[7:0];
                 end
             else      // 0Îª¶Á
                 begin
                    DataOut[31:24] = mem[DAddr+3];
                    DataOut[23:16] = mem[DAddr+2];
                    DataOut[15:8] = mem[DAddr+1];
                    DataOut[7:0] = mem[DAddr];
                 end      
          end
endmodule
