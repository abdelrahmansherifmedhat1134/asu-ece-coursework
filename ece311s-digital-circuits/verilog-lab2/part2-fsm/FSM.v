`timescale 1ns / 1ps
module FSM (
    input  wire clk,
    input  wire rst_n,
    input  wire in_bit,
    output reg  detect
);

localparam [2:0]    
    S0 = 3'b000,  // No match
    S1 = 3'b001,  // Got '1'
    S2 = 3'b010,  // Got '11'
    S3 = 3'b011;  // Got '110'

reg [2:0] current_state, next_state;

always @(posedge clk) begin
    next_state = current_state;
    detect = 1'b0;

    case (current_state)
        S0: begin
            if (in_bit) next_state = S1;
            else next_state = S0;
        end

        S1: begin
            if (in_bit) next_state = S2;
            else next_state = S0;
        end

        S2: begin
            if (in_bit) next_state = S2;
            else next_state = S3;
        end

        S3: begin
            if (in_bit) begin
                detect = 1'b1;      // sequence "1101" detected
                next_state = S1;    // overlap handling
            end else
                next_state = S0;
        end
        
        default: next_state = S0;
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        current_state = S0;
    else
        current_state = next_state;
end

endmodule
