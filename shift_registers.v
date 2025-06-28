`timescale 1ns/1ps

module siso(
    input wire clk,
    input wire rst,
    input wire serial_in,
    output wire serial_out
);
    reg [3:0] shift_reg;

    always @(posedge clk or posedge rst) begin
        if (rst)
            shift_reg <= 4'b0000;
        else
            shift_reg <= {serial_in, shift_reg[3:1]}; // Right shift
    end

    assign serial_out = shift_reg[0];
endmodule

module sipo(
    input wire clk,
    input wire rst,
    input wire serial_in,
    output wire [3:0] parallel_out
);
    reg [3:0] shift_reg;

    always @(posedge clk or posedge rst) begin
        if (rst)
            shift_reg <= 4'b0000;
        else
            shift_reg <= {serial_in, shift_reg[3:1]}; // Right shift
    end

    assign parallel_out = shift_reg;
endmodule

module shift_registers_tb();
    reg clk;
    reg rst;
    reg serial_in;
    wire siso_out;
    wire [3:0] sipo_out;

    // Instantiate the modules
    siso siso_inst(
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .serial_out(siso_out)
    );

    sipo sipo_inst(
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .parallel_out(sipo_out)
    );

    // Clock generation - faster clock for easier viewing
    initial begin
        clk = 0;
        forever #2 clk = ~clk;  // 4ns period
    end

    // Test stimulus
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, shift_registers_tb);

        // Test 1: Reset
        rst = 1;
        serial_in = 0;
        #10;
        
        // Release reset
        rst = 0;
        #10;

        // Test 2: Input pattern "1010"
        $display("\nStarting pattern 1010:");
        serial_in = 1; #4;  // Bit 1
        $display("Input: 1, SIPO: %b, SISO: %b", sipo_out, siso_out);
        
        serial_in = 0; #4;  // Bit 2
        $display("Input: 0, SIPO: %b, SISO: %b", sipo_out, siso_out);
        
        serial_in = 1; #4;  // Bit 3
        $display("Input: 1, SIPO: %b, SISO: %b", sipo_out, siso_out);
        
        serial_in = 0; #4;  // Bit 4
        $display("Input: 0, SIPO: %b, SISO: %b", sipo_out, siso_out);
        
        #8; // Wait two clock cycles

        // Test 3: Input pattern "1111"
        $display("\nStarting pattern 1111:");
        serial_in = 1; #4;
        $display("Input: 1, SIPO: %b, SISO: %b", sipo_out, siso_out);
        
        serial_in = 1; #4;
        $display("Input: 1, SIPO: %b, SISO: %b", sipo_out, siso_out);
        
        serial_in = 1; #4;
        $display("Input: 1, SIPO: %b, SISO: %b", sipo_out, siso_out);
        
        serial_in = 1; #4;
        $display("Input: 1, SIPO: %b, SISO: %b", sipo_out, siso_out);
        
        #8; // Wait two clock cycles
        
        $finish;
    end
endmodule
