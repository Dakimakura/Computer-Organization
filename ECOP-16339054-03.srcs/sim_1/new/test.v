`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/06 02:05:42
// Design Name: 
// Module Name: test
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


module test();
    reg clk;
    reg Reset;
    wire [5:0] op;
    wire [2:0] ALUOp;
    wire [4:0] rs,rt,rd,sa;
    wire [31:0] pc,instruction,readData1,readData2,ALUResult;
    wire RegWre, WrRegDSrc, DBDataSrc;
    
MCPU uut(
    .clk(clk),
    .Reset(Reset),
    .pc(pc),
    .instruction(instruction),
    .op(op),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .sa(sa),
    .readData1(readData1),
    .readData2(readData2),
    .RegWre(RegWre),
    .WrRegDSrc(WrRegDSrc),
    .DBDataSrc(DBDataSrc),
    .ALUOp(ALUOp),
    .ALUResult(ALUResult)
);

    initial begin
        // Initialize Inputs
        clk = 0;
        Reset = 1;
        #50; // 刚开始设置pc为0
            clk = !clk;
        #50;
            Reset = 0;
      forever #50 begin // 产生时钟信号
            clk = !clk;
        end
    end
endmodule
