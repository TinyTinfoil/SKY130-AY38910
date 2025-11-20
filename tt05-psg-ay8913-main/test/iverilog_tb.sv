`timescale 10ns/10ns
`include "../src/tt_um_rejunity_ay8913.v"

module iverilog_tb;
    /*
    logic clk = 0;
    logic SW = 1'b1;
    logic BOOT = 1'b1;
    logic _48b, _45a;
    */

    // wire up the inputs and outputs
    wire [7:0] ui_in;
    wire [7:0] uo_out;
    wire [7:0] uio_in;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    wire clk;
    wire rst_n;
    wire ena;

    tt_um_rejunity_ay8913 tt_um_rejunity_ay8913_uut 
    (
        // include power ports for the Gate Level test
        .ui_in      (ui_in),    // Dedicated inputs
        .uo_out     (uo_out),   // Dedicated outputs
        .uio_in     (uio_in),   // IOs: Input path
        .uio_out    (uio_out),  // IOs: Output path
        .uio_oe     (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
        .ena        (ena),      // enable - goes high when design is selected
        .clk        (clk),      // clock
        .rst_n      (rst_n)     // not reset
    );

    initial begin
        $dumpfile("led_matrix.vcd");
        $dumpvars(0, led_matrix_tb);
        #10000000
        $finish;
    end

    always begin
        #4
        clk = ~clk;
    end

endmodule

