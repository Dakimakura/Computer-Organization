`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/05 18:49:15
// Design Name: 
// Module Name: PC
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

module PC(
    input clk,Reset,PCWre,
    input [1:0] PCSrc,
    input [25:0] j_addr,
    input [31:0] immediate_32,ReadData1,
    output reg [31:0] pc
    );
    
    always@(PCWre or negedge Reset) begin
        if(Reset == 1) begin
            pc = 0;
        end
        if(PCWre) begin
            if(PCSrc == 2'b00)
                pc = pc + 4;
            else if(PCSrc == 2'b01)
                pc = pc + 4 + immediate_32*4;
            else if(PCSrc == 2'b10)
                pc = ReadData1;
            else if(PCSrc == 2'b11) begin
                pc <= pc + 4;
                pc[27:2] <= j_addr;
                pc[1:0] <= 2'b00;
            end
        end
    end
endmodule
