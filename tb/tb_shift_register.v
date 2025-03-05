`timescale 1ns/1ps

module shift_register_tb;

    // Testbench parameters
    parameter WIDTH = 8;  // Must match module parameters
    parameter SIZE  = 8;

    // Testbench signals
    reg clk;
    reg rst_n;
    reg [WIDTH-1:0] data_in;
    wire [WIDTH-1:0] reg_out [0:SIZE-1];

    // Instantiate the shift register module
    shift_register #(
        .WIDTH(WIDTH),
        .SIZE(SIZE)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .reg_out(reg_out)
    );

    // Clock generation: 10ns period (100MHz)
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;      // Apply reset
        data_in = 8'h00;

        // Hold reset for a few cycles
        #20;
        rst_n = 1;      // Release reset
        $display("Reset released. Starting test sequence...");

        // Apply test values
        repeat (10) begin
            data_in = $random % 256;  // Generate a random 8-bit value
            #10;  // Wait for a clock cycle
            $display("Time: %0t | Input: 0x%h | Register State: %p", $time, data_in, reg_out);
        end

        // Finish the simulation
        #50;
        $display("Test completed.");
        $finish;
    end

endmodule
