`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/05 19:31:13
// Design Name: 
// Module Name: InsMemory
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

module InsMemory(
    input InsMemRW,
    input [31:0] pc,
    output reg [31:0] instruction
    );
    
    reg [7:0] mem [0:159];
    initial begin
        #1; 
        $readmemb("C:/Users/Joe/Desktop/MpCPU/MpCPU.srcs/sources_1/new/my_store.txt", mem);
    end
    
    always@( pc or InsMemRW) begin  
            if (InsMemRW) begin  
              instruction[31:24] = mem[pc];  
              instruction[23:16] = mem[pc+1];  
              instruction[15:8] = mem[pc+2];  
              instruction[7:0] = mem[pc+3];  
            end  
         end  
        
endmodule
