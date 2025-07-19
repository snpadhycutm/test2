`default_nettype none
`timescale 1ns / 1ps

`timescale 1ns / 1ps

module tb_sequential_multiplier_4bit;

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

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $display("Starting 4-bit sequential multiplier simulation...");
        $dumpfile("tb.vcd");
        $dumpvars(0, tb_sequential_multiplier_4bit);

        // Reset
        reset = 1;
        #20;
        reset = 0;

        // Test case: 9 * 6 = 54
        ui_in = 8'b00001001;  // a = 9
        uio_in = 8'b00000110; // b = 6
        in_valid = 1;
        #10;
        in_valid = 0;

        // Wait for done signal
        wait(out_done);
        #10;
        $display("Test 1: 9 * 6 = %d (Expected: 54)", uo_out);

        // Test case: 15 * 15 = 225
        ui_in = 8'b00001111;  // a = 15
        uio_in = 8'b00001111; // b = 15
        in_valid = 1;
        #10;
        in_valid = 0;

        wait(out_done);
        #10;
        $display("Test 2: 15 * 15 = %d (Expected: 225)", uo_out);

        // Test case: 7 * 0 = 0
        ui_in = 8'b00000111;  // a = 7
        uio_in = 8'b00000000; // b = 0
        in_valid = 1;
        #10;
        in_valid = 0;

        wait(out_done);
        #10;
        $display("Test 3: 7 * 0 = %d (Expected: 0)", uo_out);

        $display("Simulation done.");
        $finish;
    end

endmodule

