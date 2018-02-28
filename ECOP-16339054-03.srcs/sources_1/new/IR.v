`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/05 19:59:29
// Design Name: 
// Module Name: IR
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
 
module IR(
    input clk,IRWre,
    input [31:0] instruction,
    output reg [31:0] insLate
    );
    
    always @(posedge clk) begin  
         if(IRWre) begin
            insLate = instruction;  
        end 
    end
endmodule
