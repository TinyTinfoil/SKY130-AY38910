`timescale 1ns / 1ps
//verilog file that generates control signals for ay-3-8910 without dependance
module test_core(
    input logic clk,// init 0, forever toggle every 50ns
    input logic rst_n, // init 0, set to 1 after 500ns
    //pins after map to ay-3-8910
    output logic cen, // .clk_en
    output logic bdir,
    output logic bc1,
    output logic bc2,
    output logic [7:0] din
    // sel tied to 1
    //sound output from ay-3-8910
);

reg restart;
wire [4:0] env;
reg  [3:0]ctrl;

reg [1:0] cen_cnt=2'd0;
always @(negedge clk) begin
    cen_cnt <= cen_cnt+2'd1;
    cen <= cen_cnt==2'd0;
end

reg [7:0] aux;

always @(posedge clk ) begin
    if(~rst_n) begin
        {ctrl,aux} <= 12'd0;
        restart <= 1'b0;
    end else begin
        {ctrl,aux} <= {ctrl,aux} + 12'd1;
        restart <= aux==8'd0;
    end
end

reg [11:0] cmd_list [0:127];
integer cmd_cnt, cmd_wait, cmd_end=127;

initial begin : cmd_set
    integer cnt;
    for(cnt=0;cnt<cmd_end;cnt=cnt+1)
        cmd_list[cnt] = {4'hf,8'hff}; // wait

    cmd_list[ 0] = { 4'h0, 8'h01 };
    cmd_list[ 1] = { 4'h1, 8'h00 };  // set ch A freq 
    cmd_list[ 2] = { 4'h2, 8'h22 };
    cmd_list[ 3] = { 4'h3, 8'h02 };  // set ch B freq 
    cmd_list[ 4] = { 4'h4, 8'h23 };
    cmd_list[ 5] = { 4'h5, 8'h03 };  // set ch B freq 
    cmd_list[ 6] = { 4'hf, 8'hff };  // wait

    cmd_list[ 7] = { 4'h0, 8'h00 };
    cmd_list[ 8] = { 4'h1, 8'h00 };  // stop ch A freq 
    cmd_list[ 9] = { 4'h7, 8'h31 };  // A = noise
    cmd_list[10] = { 4'h6, 8'h03 };  // noise freq
    cmd_list[11] = { 4'hf, 8'hff };  // wait

    // envelope
    cmd_list[12] = { 4'hd, 8'h0e };  // zig zag
    cmd_list[13] = { 4'hc, 8'h00 };  // freq. of envelope MSB
    cmd_list[14] = { 4'hb, 8'h0A };  // freq. of envelope LSB
    cmd_list[15] = { 4'h8, 8'h10 };  // ch A controlled by eg

    cmd_list[17] = { 4'hd, 8'b0_000 };
    cmd_list[19] = { 4'hd, 8'b0_100 };

    cmd_list[21] = { 4'hd, 8'b1_000 };
    cmd_list[23] = { 4'hd, 8'b1_001 };
    cmd_list[25] = { 4'hd, 8'b1_010 };
    cmd_list[27] = { 4'hd, 8'b1_011 };

    cmd_list[29] = { 4'hd, 8'b1_100 };
    cmd_list[31] = { 4'hd, 8'b1_101 };
    cmd_list[33] = { 4'hd, 8'b1_110 };
    cmd_list[35] = { 4'hd, 8'b1_111 };

    cmd_list[36] = { 4'h7, ~8'h1 }; // Only output channel A
    cmd_list[37] = { 4'h0, 8'h10 }; // ch A freq 
    cmd_list[36+2] = { 4'h8, 8'hf };
    cmd_list[37+2] = { 4'hf, 8'h40};
    cmd_list[38+2] = { 4'h8, 8'he };
    cmd_list[39+2] = { 4'hf, 8'h40};
    cmd_list[40+2] = { 4'h8, 8'hd };
    cmd_list[41+2] = { 4'hf, 8'h40};
    cmd_list[42+2] = { 4'h8, 8'hc };
    cmd_list[43+2] = { 4'hf, 8'h40};
    cmd_list[44+2] = { 4'h8, 8'hb };
    cmd_list[45+2] = { 4'hf, 8'h40};
    cmd_list[46+2] = { 4'h8, 8'ha };
    cmd_list[47+2] = { 4'hf, 8'h40};
    cmd_list[48+2] = { 4'h8, 8'h9 };
    cmd_list[49+2] = { 4'hf, 8'h40};
    cmd_list[50+2] = { 4'h8, 8'h8 };
    cmd_list[51+2] = { 4'hf, 8'h40};
    cmd_list[52+2] = { 4'h8, 8'h7 };
    cmd_list[53+2] = { 4'hf, 8'h40};
    cmd_list[54+2] = { 4'h8, 8'h6 };
    cmd_list[55+2] = { 4'hf, 8'h40};
    cmd_list[56+2] = { 4'h8, 8'h5 };
    cmd_list[57+2] = { 4'hf, 8'h40};
    cmd_list[58+2] = { 4'h8, 8'h4 };
    cmd_list[59+2] = { 4'hf, 8'h40};
    cmd_list[60+2] = { 4'h8, 8'h3 };
    cmd_list[61+2] = { 4'hf, 8'h40};
    cmd_list[62+2] = { 4'h8, 8'h2 };
    cmd_list[63+2] = { 4'hf, 8'h40};
    cmd_list[64+2] = { 4'h8, 8'h1 };
    cmd_list[65+2] = { 4'hf, 8'h40};
    cmd_list[66+2] = { 4'h8, 8'h0 };
    cmd_list[67+2] = { 4'hf, 8'h40};

    cmd_list[68] = { 4'he, 8'hff };  // end
end

// State machine for bus protocol
// To write a register: first latch address (bdir=1,bc1=1,bc2=1), then write data (bdir=1,bc1=0,bc2=1)
reg [1:0] bus_state;
localparam IDLE = 2'd0, LATCH_ADDR = 2'd1, WRITE_DATA = 2'd2, WAIT_STATE = 2'd3;

always @(posedge clk)
    if( !rst_n ) begin
        bdir <= 1'b0;
        bc1  <= 1'b0;
        bc2  <= 1'b1;
        din  <= 8'd0;
        cmd_cnt  <= 0;
        cmd_wait <= 0;
        bus_state <= IDLE;
    end
    else begin
        case (bus_state)
            IDLE: begin
                bdir <= 1'b0;
                bc1  <= 1'b0;
                bc2  <= 1'b1;
                if( cmd_cnt != cmd_end || cmd_wait != 0 ) begin
                    if( cmd_wait == 0 ) begin
                        if( cmd_list[cmd_cnt][11:8] == 4'hf ) begin
                            cmd_wait <= cmd_list[cmd_cnt][7:0] << 11;
                            cmd_cnt <= cmd_cnt + 1;
                        end
                        else if( cmd_list[cmd_cnt][11:8] == 4'he ) begin
                            // $display("Simulation finished through command\n");
                            // $finish;
                            cmd_cnt <= cmd_cnt + 1;
                        end
                        else begin
                            // Latch address: bdir=1, bc1=1, bc2=1
                            din <= {4'd0, cmd_list[cmd_cnt][11:8]};
                            bdir <= 1'b1;
                            bc1  <= 1'b1;
                            bc2  <= 1'b1;
                            bus_state <= LATCH_ADDR;
                        end
                    end
                    else begin
                        cmd_wait <= cmd_wait - 1;
                    end
                end
            end
            LATCH_ADDR: begin
                // After latching address, go to write data state
                // Write data: bdir=1, bc1=0, bc2=1
                din <= cmd_list[cmd_cnt][7:0];
                bdir <= 1'b1;
                bc1  <= 1'b0;
                bc2  <= 1'b1;
                bus_state <= WRITE_DATA;
            end
            WRITE_DATA: begin
                // Return to idle, increment command counter
                bdir <= 1'b0;
                bc1  <= 1'b0;
                bc2  <= 1'b1;
                cmd_cnt <= cmd_cnt + 1;
                bus_state <= IDLE;
            end
            default: bus_state <= IDLE;
        endcase
    end


endmodule