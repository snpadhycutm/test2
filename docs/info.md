<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This 4-bit sequential multiplier uses the shift-and-add algorithm to multiply two 4-bit unsigned numbers over four clock cycles. When the start signal is pulsed high, the module captures the inputs A and B and initialises the internal state. It then iteratively examines each bit of B, and if a bit is set, it adds a left-shifted version of A (based on the current bit position) to an accumulator. This process continues for four cycles, after which the final 8-bit product is available on the output. This design is efficient in terms of area and ideal for resource-constrained environments, such as Tiny Tapeout.

## How to test

To test the 4-bit sequential multiplier, apply the 4-bit operands A and B to the input pins ui[3:0] and ui[7:4] respectively, and pulse the start signal on uio[0] high for one clock cycle to initiate the multiplication. After four clock cycles, the 8-bit result will be available on the output pins uo[7:0]. You can verify the correctness by comparing the output with the expected product of A and B. For automated testing, a Cocotb-based Python testbench is provided, which applies a set of known test vectors, waits for the multiplication to complete, and checks that the result matches the expected output.

## External hardware

NA
