
`timescale 1ns/1ps

module tb_NPU2;

    reg clk,reset,start;
    reg [3:0] multiplicand_in;
    reg [3:0] multiplier_in;

    wire [7:0] product;
    wire done,busy;
   

    NPU2 dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .multiplicand_in(multiplicand_in),
        .multiplier_in(multiplier_in),
        .product(product),
        .busy(busy),
        .done(done)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1'b1;
        start = 1'b0;
        multiplicand_in = 4'b0000;
        multiplier_in = 4'b0000;


        #12;
        reset = 1'b0;

       
        @(negedge clk);
        multiplicand_in = 4'b1011;
        multiplier_in   = 4'b0111;
        start = 1'b1;

        @(negedge clk);
        start = 1'b0;

        wait (done == 1'b1);
        #1;
        $display("Test 1: 11 x 7 = %0d, product = %b",product, product);

        if (product !== 8'd77)
            $display("FAIL: Test 1");
        else
            $display("PASS: Test 1");

       
        @(negedge clk);
        multiplicand_in = 4'b0110;
        multiplier_in   = 4'b1001;
        start = 1'b1;

        @(negedge clk);
        start = 1'b0;

        wait (done == 1'b1);
        #1;
        $display("Test 2: 6 x 9 = %0d, product = %b",product, product);

        if (product !== 8'd54)
            $display("FAIL: Test 2");
        else
            $display("PASS: Test 2");

        #10;
        $finish;
    end

endmodule