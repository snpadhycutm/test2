`default_nettype none
`timescale 1ns / 1ps
module tb;

    reg clk = 0;
    reg reset = 0;
    reg [7:0] ui_in;      // a[3:0]
    reg [7:0] uio_in;     // b[3:0]
    wire [7:0] uo_out;    // result
    wire [7:0] uio_out;   // unused
    reg  [7:0] ui_oe = 8'h00;
    reg  [7:0] uio_oe = 8'h00;
    reg in_valid = 0;
    wire out_done;

    // DUT instantiation
    tt_um_sequential_multiplier_4bit dut (
        .clk(clk),
        .reset(reset),
        .ui_in(ui_in),
        .uio_in(uio_in),
        .uo_out(uo_out),
        .uio_out(uio_out),
        .ui_oe(ui_oe),
        .uio_oe(uio_oe),
        .in_valid(in_valid),
        .out_done(out_done)
    );

   
endmodule

