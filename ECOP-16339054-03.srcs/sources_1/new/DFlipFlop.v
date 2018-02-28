`timescale 1ns / 1ps
module DFlipFlop(
    input [2:0]i_state,
    input Reset, clk,
    output reg[2:0]o_state
    );
    always @(posedge clk) begin//ʱ�������ظı�
         if (Reset) o_state = 3'b000;//reset����״̬ΪIF
         else o_state = i_state;
     end
endmodule