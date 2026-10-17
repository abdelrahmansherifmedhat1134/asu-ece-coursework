`timescale 1ns / 1ps

module Logic_Unit(
    input  wire IN1,
    input  wire IN2,
    input  wire IN3,
    input  wire IN4,
    input  wire CLK,
    output reg  OUT1,
    output reg  OUT2);
        
        // Combinational logic internal signals
    wire xor_out, and_out, not_out, or_out;
    
    assign xor_out = (IN1^IN2);         // XOR gate
    assign and_out = (xor_out & IN3);   // AND gate for OUT1 input
    assign not_out = (~IN4);            // NOT gate
    assign or_out = (IN3 | not_out);    // OR gate for OUT2 input
    
    
    // Sequential logic: D Flip-Flops
    always @(posedge CLK) begin
        OUT1 <= and_out;  //OUT1
        OUT2 <= or_out;   //OUT2
    end
 
endmodule
