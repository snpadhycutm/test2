<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project implements a 4-bit sequential multiplier that takes two 4-bit inputs a and b and produces an 8-bit product op. The multiplication is performed serially using a combination of registers, a 4-bit adder, and a counter to iterate over each bit of the multiplier. On asserting the start signal, the system begins multiplying the two inputs over four clock cycles. Partial products are accumulated using an adder and shifted registers. Once the final result is computed, it is output through uo_out.

## How to test

To test the project, provide 4-bit operands a and b through ui_in[3:0] and ui_in[7:4], respectively, and assert the start signal through uio_in[0]. The result of the multiplication will appear on uo_out after a few clock cycles. The module can be simulated using a Verilog testbench (tb.v) or a Python Cocotb script (test.py) that provides input stimuli and checks the expected output.

## External hardware

NA
