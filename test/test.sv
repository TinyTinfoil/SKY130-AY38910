`include "test/test_core.sv"
`timescale 1ns / 1ps
module test;

reg clk, cen, rst_n;

initial begin
    clk = 1'b0;
    forever clk = #50 ~clk;
end // initial
initial begin
    rst_n = 1'b0;
    #100
    rst_n = 1'b1;
end // initial

wire [9:0] sound;
wire [7:0] din;
wire bdir, bc1, bc2;

test_core tb(
    .clk        ( clk       ),
    .rst_n      ( rst_n     ),
    .cen        ( cen       ),
    .bdir       ( bdir      ),
    .bc1        ( bc1       ),
    .bc2        ( bc2       ),
    .din        ( din       )
);

digital_core uut( // note that input ports are not multiplexed
    .rst_n      ( rst_n     ),
    .clk        ( clk       ),    // signal on positive edge
    .clk_en     ( cen       ),    // clock enable on negative edge
    .bdir       ( bdir      ),
    .bc1        ( bc1       ),
    .bc2        ( bc2       ),
    .din        ( din       ),
    .nA9       ( 1'b0     ),
    .A8        ( 1'b1     )
);

initial begin
    $dumpfile("test.vcd");
    $dumpvars(1,uut);
    $dumpvars(1,tb);
    $dumpon;
    #2000000 //precalculated max time for single wave sim
    // #823303350 //precalculated max time for full sim
    $finish;
end

endmodule