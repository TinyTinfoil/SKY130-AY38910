/*  This file is part of JT49.

    JT49 is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    JT49 is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with JT49.  If not, see <http://www.gnu.org/licenses/>.

    Author: Jose Tejada Gomez. Twitter: @topapate
    Version: 1.0
    Date: 28-Jan-2019

    Based on sqmusic, by the same author

    */

// This is a wrapper with the BDIR/BC1 pins
/* verilator coverage_off */
// `timescale 1ns / 1ps
`include "src/jt49_cen.v"
`include "src/jt49_div.v"
`include "src/jt49_eg.v"
`include "src/jt49_exp.v"
`include "src/jt49_noise.v"
`include "src/jt49.v"
module digital_core ( // note that input ports are not multiplexed
    input            rst_n,
    input            clk,    // signal on positive edge
    input            clk_en /* synthesis direct_enable = 1 */,
    // bus control pins of original chip
    input            bdir,
    input            bc1,
    input            bc2, //ay-3-8910 has this pin
    input  [7:0]     din,

    input            sel, // if sel is low, the clock is divided by 2
    input      [7:0] IOA_in,
    input      [7:0] IOB_in,
     input nA9,//
    input A8,//
    output     [7:0] dout,
    // output     [9:0] sound,  // combined channel output
    output     [4:0] A,      // linearised channel output
    output     [4:0] B,
    output     [4:0] C,
    output           sample,

    output     [7:0] IOA_out,
    output           IOA_oe, // output enable, input when low

    output     [7:0] IOB_out,
    output           IOB_oe

    //test1, test2 not implemented (should not be implemented)
    //if {na9,a8} != 01, all bufs are high z
    //clk_en needed by implementation
    //sel not needed
);

// always_comb begin
//     if ({nA9,A8} != 2'b01) begin
//         //all bufs high z, but faked as zeros
//         da = 8'bz;
//         IOA = 8'bz;
//         IOB = 8'bz;
//     end else begin
//     // din and dout should be one, gate based on bdir
//     //bdir low-> dout, bdir high-> din
//     if (bdir) din = da; else da <= dout;
//     //ioa/iob, gate based on oe
//     // output enable, input when low
//     if (IOA_oe) IOA = IOA_out; else IOA_in <= IOA;
//     if (IOB_oe) IOB = IOB_out; else IOB_in <= IOB;
//     end
// end

parameter [2:0] COMP=3'b000;

reg wr_n, cs_n;
reg [3:0] addr;
reg addr_ok;
reg [7:0] din_latch;

always @(posedge clk)
    if( !rst_n ) begin
        wr_n    <= 1'b1;
        cs_n    <= 1'b1;
        addr    <= 4'd0;
        addr_ok <= 1'b1;
    end else begin // I/O cannot use clk_en
        // addr must be
        if (!bc2) begin
            case ( {bdir,bc1} )
                2'b00: { wr_n, cs_n } <= 2'b11; // inactive 00
                2'b01: begin //intake 11
                    { wr_n, cs_n } <= 2'b11;
                    addr    <= din[3:0];
                    addr_ok <= din[7:4] == 4'd0;
                end
                2'b10: begin //intake 11
                    { wr_n, cs_n } <= 2'b11;
                    addr    <= din[3:0];
                    addr_ok <= din[7:4] == 4'd0;
                end
                2'b11: { wr_n, cs_n } <= 2'b11; // inactive 00
            endcase
        end else begin
        case( {bdir,bc1} )
            2'b00: { wr_n, cs_n } <= 2'b11;
            2'b01: { wr_n, cs_n } <= addr_ok ? 2'b10 : 2'b11;
            2'b10: begin
                { wr_n, cs_n } <= addr_ok ? 2'b00 : 2'b11;
                din_latch <= din;
            end
            2'b11: begin
                { wr_n, cs_n } <= 2'b11;
                addr    <= din[3:0];
                addr_ok <= din[7:4] == 4'd0;
            end
        endcase // {bdir,bc1}
        end
    end

jt49 #(.COMP(COMP)) u_jt49( // note that input ports are not multiplexed
    .rst_n  (  rst_n     ),
    .clk    (  clk       ),    // signal on positive edge
    .clk_en (  clk_en    ),    // clock enable on negative edge
    .addr   (  addr[3:0] ),
    .cs_n   (  cs_n      ),
    .wr_n   (  wr_n      ),  // write
    .din    (  din_latch ),
    .sel    (  sel       ), // if sel is low, the clock is divided by 2
    .dout   (  dout      ),
    // .sound  (  sound     ),  // combined channel output
    .sample (  sample    ),
    .A      (  A         ),      // linearised channel output
    .B      (  B         ),
    .C      (  C         ),
    .IOA_in (  IOA_in    ),
    .IOA_out(  IOA_out   ),
    .IOA_oe (  IOA_oe    ),
    .IOB_in (  IOB_in    ),
    .IOB_out(  IOB_out   ),
    .IOB_oe (  IOB_oe    )
);

endmodule // jt49_bus