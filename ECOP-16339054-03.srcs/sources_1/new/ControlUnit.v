`timescale 1ns / 1ps
module ControlUnit(  
     input [5:0] op,
     input zero, sign, clk, Reset,  
     output PCWre, ALUSrcB, ALUSrcA,RW, RegWre, InsMemRW, ExtSel, DBDataSrc,WrRegDSrc,IRWre,
     output [1:0] PCSrc,RegDst,  
     output [2:0] ALUOp
     );
     wire [2:0]i_state, o_state;
     DFlipFlop DFlipFlop(i_state, Reset, clk, o_state);
     NextState NextState(o_state, op, i_state);
     outputfunc outputfunc(o_state, op, zero, sign, PCWre, ALUSrcB, ALUSrcA,RW, RegWre, InsMemRW, ExtSel, DBDataSrc,WrRegDSrc,IRWre, PCSrc,RegDst,ALUOp);   
endmodule  