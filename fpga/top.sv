`include "jt49_bus.v"
`include "jt49_cen.v"
`include "jt49_div.v"
`include "jt49_eg.v"
`include "jt49_exp.v"
`include "jt49_noise.v"
`include "jt49.v"

module top (
    input  wire clk,        // FPGA clock
    // input  wire rst_n,      // Reset (active low)
    output wire LED         // Connect to an LED for basic output
);

    // Minimal signals for jt49
    wire rst_n = 1'b1;     // No reset
    wire clk_en = 1'b1;     // Always enabled
    wire [3:0] addr = 4'd0; // Hardcoded address
    wire cs_n   = 1'b0;     // Always selected
    wire wr_n   = 1'b1;     // No write
    wire [7:0] din = 8'd0;  // No data
    wire sel   = 1'b1;      // Normal operation

    wire [7:0] dout;
    wire [9:0] sound;
    wire [7:0] A, B, C;
    wire sample;

    // Dummy IOA/IOB connections
    wire [7:0] IOA_in = 8'd0;
    wire [7:0] IOB_in = 8'd0;
    wire [7:0] IOA_out;
    wire [7:0] IOB_out;
    wire IOA_oe, IOB_oe;

    jt49 jt49_inst (
        .rst_n(rst_n),
        .clk(clk),
        .clk_en(clk_en),
        .addr(addr),
        .cs_n(cs_n),
        .wr_n(wr_n),
        .din(din),
        .sel(sel),
        .dout(dout),
        .sound(sound),
        .A(A),
        .B(B),
        .C(C),
        .sample(sample),
        .IOA_in(IOA_in),
        .IOA_out(IOA_out),
        .IOA_oe(IOA_oe),
        .IOB_in(IOB_in),
        .IOB_out(IOB_out),
        .IOB_oe(IOB_oe)
    );

    // Drive LED with one bit of sound output for basic activity indication
    assign LED = sound[0];

endmodule