`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/05 20:57:47
// Design Name: 
// Module Name: ALU
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


module ALU(
    input ALUSrcA,ALUSrcB,
    input [31:0] readData1,readData2,immediate_32,
    input [4:0] sa,
    input [2:0] ALUOp,
    output zero,sign,
    output reg [31:0] ALUResult
    );
    wire [31:0] sa_32;
    assign sa_32 = { {27{0}},sa[4:0] }; //sa¿©’π
    
    wire [31:0] A,B;
    assign A = ALUSrcA ? sa_32 : readData1;
    assign B = ALUSrcB ? immediate_32 : readData2;
    
    initial begin
               ALUResult = 0;
    end  
    assign zero = (ALUResult == 0) ? 1 : 0;
    assign sign = (ALUResult[31] == 1) ? 1 : 0;
    always@(A or B  or ALUOp)
    begin
        case(ALUOp)
            3'b000 : ALUResult = A + B;
            3'b001 : ALUResult = A - B;
            3'b010 : ALUResult = ( A < B) ? 1 : 0;
            3'b011 : begin
                        if( A < B && (( A[31] == 0 && B[31]==0) ||(A[31] == 1 && B[31]==1)) )
                            ALUResult = 1;
                        else if(A[31] == 1 && B[31] == 0) ALUResult = 1;
                        else ALUResult = 0;
                     end
            3'b100 : ALUResult = B << A;
            3'b101 : ALUResult = A | B;
            3'b110 : ALUResult = A & B;
            3'b111 : ALUResult = A ^ B;
            default : ALUResult = 0;
        endcase
    end
    
            
endmodule
