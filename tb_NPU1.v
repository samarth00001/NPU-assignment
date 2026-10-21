`timescale 1ns/1ps

module tb_NPU1;

    reg clk,reset;
    reg [3:0] req;
    wire [3:0] grant;

    NPU1 dut (.clk(clk),.reset(reset),.req(req),.grant(grant));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
    
        reset = 1;
        req = 4'b0000;

        #10;
        reset = 0;

       
        req = 4'b1111;

       
        repeat (8) begin
            @(posedge clk);
            #1;
            $display("Time=%0t req=%b grant=%b",$time, req, grant);
        end

        
        @(negedge clk);
        req = 4'b0000;

        repeat (2) @(posedge clk);

        $finish;
    end

endmodule
