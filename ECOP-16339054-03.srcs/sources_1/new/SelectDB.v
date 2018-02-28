`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/05 22:36:09
// Design Name: 
// Module Name: SelectDB
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


module SelectDB(
    input DBDataSrc,
    input [31:0] ALUResult,
    input [31:0] DataOut,
    output wire [31:0] DB
    );
    assign DB = DBDataSrc ? DataOut : ALUResult;
    
endmodule
