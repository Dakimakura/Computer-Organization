`timescale 1ns / 1ps
module DFlipFlop(
    input [2:0]i_state,
    input Reset, clk,
    output reg[2:0]o_state
    );
    always @(posedge clk) begin//时钟上升沿改变
         if (Reset) o_state = 3'b000;//reset重置状态为IF
         else o_state = i_state;
     end
endmodule