`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Logic_Unit_tb();

    reg in1, in2, in3, in4, clk;
    wire out1, out2;

    // Instantiate DUT
    Logic_Unit DUT (
        .IN1(in1),
        .IN2(in2),
        .IN3(in3),
        .IN4(in4),
        .CLK(clk),
        .OUT1(out1),
        .OUT2(out2)
    );

    // Clock generation
    always #5 clk = ~clk; // 10 ns period

    // Initialization task
    task initialize;
    begin
        in1 = 0;
        in2 = 0;
        in3 = 0;
        in4 = 0;
        clk = 0;
    end
    endtask

    // Apply input combinations
    task apply_inputs;
        input a, b, c, d;
    begin
        in1 = a;
        in2 = b;
        in3 = c;
        in4 = d;
        #10; // wait one clock period
    end
    endtask

    // Test sequence
    initial begin
        $dumpfile("Logic_Unit_tb.vcd");
        $dumpvars(0, Logic_Unit_tb);

        initialize;

        // Apply different input combinations
        apply_inputs(0,0,0,0);
        apply_inputs(1,0,1,0);
        apply_inputs(1,1,0,1);
        apply_inputs(0,1,1,1);
        apply_inputs(1,0,1,1);
        apply_inputs(0,0,1,0);
        
        #20;
        $finish;
    end

endmodule
