 `timescale 1ns/1ps

module pwm_module_tb;

    // Parameters
    parameter BIT_WIDTH = 8;
    parameter CLK_PERIOD = 10; // 10 ns clock period (100 MHz)

    // Testbench signals
    reg clk;
    reg rst_n;
    reg [BIT_WIDTH-1:0] duty;
    reg [BIT_WIDTH-1:0] max_value;
    wire pwm_out;

    // Instantiate the DUT (Device Under Test)
    pwm_module #(.bit_width(BIT_WIDTH)) uut (
        .clk(clk),
        .rst_n(rst_n),
        .duty(duty),
        .max_value(max_value),
        .pwm_out(pwm_out)
    );

    // Clock generation: 10ns period (100MHz)
    always #(CLK_PERIOD / 2) clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0; // Hold reset
        duty = 8'd0;
        max_value = 8'd255; // Max value for an 8-bit counter

        // Apply reset
        #20;
        rst_n = 1; // Release reset
        $display("Reset released. Starting test sequence...");

        // Test different duty cycles
        repeat (3) begin
            duty = $random % 256; // Generate random duty cycle
            $display("Time: %0t | Duty Cycle: %d/%d", $time, duty, max_value);
            #2560; // Run for 10 full PWM cycles (256 * 10 ns)
        end

        // Finish the simulation
        #50;
        $display("Test completed.");
        $finish;
    end

endmodule
