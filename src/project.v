/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

module seq_mult_4bit (
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire [3:0] a,       // Multiplicand
    input wire [3:0] b,       // Multiplier
    output reg [7:0] product, // Output product
    output reg done           // High when multiplication is complete
);

    reg [3:0] multiplicand;
    reg [3:0] multiplier;
    reg [7:0] partial_product;
    reg [2:0] count;
    reg busy;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            multiplicand     <= 0;
            multiplier       <= 0;
            partial_product  <= 0;
            product          <= 0;
            count            <= 0;
            busy             <= 0;
            done             <= 0;
        end else begin
            if (start && !busy) begin
                multiplicand    <= a;
                multiplier      <= b;
                partial_product <= 0;
                count           <= 0;
                busy            <= 1;
                done            <= 0;
            end else if (busy) begin
                // If LSB of multiplier is 1, add multiplicand to upper half of partial_product
                if (multiplier[0])
                    partial_product <= partial_product + {4'b0000, multiplicand};

                // Shift partial product and multiplier
                partial_product <= partial_product >> 1;
                partial_product[7] <= 0; // Clear MSB
                multiplier <= {1'b0, multiplier[3:1]}; // Logical right shift
                count <= count + 1;

                // Done after 4 cycles
                if (count == 3) begin
                    busy  <= 0;
                    done  <= 1;
                    product <= partial_product;
                end
            end else begin
                done <= 0; // Reset done when not busy
            end
        end
    end
endmodule
