`timescale 1ns/1ps

module shift_register #(
    parameter WIDTH = 8,        // Width of each register
    parameter SIZE = 8          // Number of registers
) (
    input clk,                  // Clock input
    input rst_n,                // Active low reset input
    input [WIDTH-1:0] data_in,  // New input data to shift in
    output reg [WIDTH-1:0] reg_out [0:SIZE-1] // Output array of registers
);

reg [WIDTH-1:0] shift_reg [0:SIZE-1]; // Register array definition

integer i;

// Always block triggered by a positive edge of the clock or negative edge of reset
always @(posedge clk) begin
    if (!rst_n) begin
        // Reset the register array to all zeros
        for (i = 0; i < SIZE; i = i + 1) begin
            shift_reg[i] <= 8'h00;
        end
    end else begin
        // Shift the values
        for (i = SIZE-1; i > 0; i = i - 1) begin
            shift_reg[i] <= shift_reg[i-1]; // Move each value one position forward
        end
        shift_reg[0] <= data_in; // Load new value at the start
    end
end

// Assign output values
always @(*) begin
    for (i = 0; i < SIZE; i = i + 1) begin
        reg_out[i] = shift_reg[i];
    end
end

endmodule
