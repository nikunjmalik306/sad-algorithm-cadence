`timescale 1ns / 1ps

module SAD_tb;

    parameter N = 4;       // Matrix size
    parameter WIDTH = 8;   // Data width of each element

    reg clk;
    reg rst;
    reg valid;
    reg [N*N*WIDTH-1:0] A; // Packed vector
    reg [N*N*WIDTH-1:0] B; // Packed vector
    wire [WIDTH+N-1:0] SAD_out;
    wire done;

    // Instantiate SAD module
    SAD #(N, WIDTH) uut (
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .A(A),
        .B(B),
        .SAD_out(SAD_out),
        .done(done)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    initial begin
        // Initialize values
        clk = 0;
        rst = 1;
        valid = 0;
        #10 rst = 0;

        // Load matrices into packed vectors
        A = {8'd1, 8'd2, 8'd3, 8'd4,
             8'd5, 8'd6, 8'd7, 8'd8,
             8'd9, 8'd10, 8'd11, 8'd12,
             8'd13, 8'd14, 8'd15, 8'd16};

        B = {8'd2, 8'd3, 8'd4, 8'd5,
             8'd6, 8'd7, 8'd8, 8'd9,
             8'd10, 8'd11, 8'd12, 8'd13,
             8'd14, 8'd15, 8'd16, 8'd17};

        // Apply input and start computation
        #10 valid = 1;
        #10 valid = 0;

        // Wait for computation to finish
        wait(done);
        $display("SAD Output: %d", SAD_out);

        #20;
        $stop;
    end

endmodule
