`default_nettype none
`timescale 1ns / 1ps

module tb ();

  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;     // [3:0] a, [7:4] b
  reg [7:0] uio_in;    // start
  wire [7:0] uo_out;   // product
  wire [7:0] uio_out;  // unused
  wire [7:0] uio_oe;   // unused

  tt_um_seq_mul dut (
      .clk(clk),
      .rst_n(rst_n),
      .ena(ena),
      .ui_in(ui_in),
      .uio_in(uio_in),
      .uo_out(uo_out),
      .uio_out(uio_out),
      .uio_oe(uio_oe)
  );

endmodule
