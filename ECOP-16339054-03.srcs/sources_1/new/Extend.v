`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/05 22:41:47
// Design Name: 
// Module Name: Extend
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


module Extend(
    input ExtSel,
    input [15:0] immediate_16,
    output [31:0] immediate_32
    );
    assign immediate_32[15:0] = immediate_16;  
    assign immediate_32[31:16] = ExtSel? (immediate_16[15]? 16'hffff : 16'h0000) : 16'h0000;
endmodule
