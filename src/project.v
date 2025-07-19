/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

module tt_um_sequential_multiplier_4bit (
    input  wire        clk,
    input  wire        reset,
    input  wire [7:0]  ui_in,     // ui_in[3:0] = A (4-bit input)
    input  wire [7:0]  uio_in,    // uio_in[3:0] = B (4-bit input)
    output wire [7:0]  uo_out,    // Product (8-bit)
    output wire [7:0]  uio_out,   // Unused
    input  wire [7:0]  ui_oe,     // Not used
    input  wire [7:0]  uio_oe,    // Not used
    input  wire        in_valid,  // Start signal
    output wire        out_done   // Done signal
);

    reg [3:0] a, b;
    reg [7:0] product;
    reg [2:0] counter;
    reg       busy;
    reg       done;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            a       <= 4'b0;
            b       <= 4'b0;
            product <= 8'b0;
            counter <= 3'd0;
            busy    <= 1'b0;
            done    <= 1'b0;
        end else begin
            if (in_valid && !busy) begin
                a       <= ui_in[3:0];
                b       <= uio_in[3:0];
                product <= 8'b0;
                counter <= 3'd0;
                busy    <= 1'b1;
                done    <= 1'b0;
            end else if (busy) begin
                if (b[0])
                    product <= product + (a << counter);

                b <= b >> 1;
                counter <= counter + 1;

                if (counter == 3'd3) begin
                    busy <= 1'b0;
                    done <= 1'b1;
                end
            end else begin
                done <= 1'b0;
            end
        end
    end

    assign uo_out   = product;
    assign uio_out  = 8'b0;      // Not used
    assign out_done = done;

endmodule

