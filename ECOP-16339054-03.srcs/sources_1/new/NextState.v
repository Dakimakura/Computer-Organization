`timescale 1ns / 1ps
    module NextState(
    input [2:0]i_state,
    input [5:0]op,
    output reg[2:0]next_state
    );
    always @(i_state or op) begin
        case (i_state)
           3'b000: next_state = 3'b001;
           3'b001: begin
             case(op[5:3])
                3'b111: next_state = 3'b000;
                default:next_state = 3'b010;
              endcase  
           
           end
           3'b010:begin
             if(op == 110100||op == 110101||op == 110110) next_state = 3'b000;  // beq和bne和bgtz指令
             else if(op == 6'b110000||op == 6'b110001)  next_state =3'b100;//sw和lw指令   
             else next_state = 3'b011; // add, sub等指令
           end
           3'b100:begin
               if(op == 110000) next_state = 3'b000;
               else next_state = 3'b011;
           end
           3'b011:begin
               next_state = 3'b000;
           end
        endcase
    end
endmodule
