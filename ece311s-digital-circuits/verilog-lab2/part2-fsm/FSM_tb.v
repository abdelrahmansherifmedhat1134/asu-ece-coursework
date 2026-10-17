`timescale 1ns / 1ps
module FSM_tb;
    reg clk, rst_n, in_bit;
    wire detect;

    FSM DUT (.clk(clk), .rst_n(rst_n), .in_bit(in_bit), .detect(detect));

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns period
    end

    // Test sequence
    initial begin
        rst_n = 0; in_bit = 0;
        #12; rst_n = 1;

        // Input stream: 1 1 0 1 0 1 1 0 1
        #10 in_bit = 1;
        #10 in_bit = 1;
        #10 in_bit = 0;
        #10 in_bit = 1; // Detect should go HIGH here (sequence 1101)
        #10 in_bit = 0;
        #10 in_bit = 1;
        #10 in_bit = 1;
        #10 in_bit = 0;
        #10 in_bit = 1; // Another detection

        #20 $finish;
    end

    initial begin
        $monitor("Time=%0t | in_bit=%b | detect=%b | state=%b",
                 $time, in_bit, detect, DUT.current_state);
    end
endmodule
