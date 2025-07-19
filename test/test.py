# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.triggers import RisingEdge, FallingEdge, Timer
from cocotb.result import TestFailure

async def reset_dut(dut):
    dut.reset.value = 1
    await Timer(20, units="ns")
    dut.reset.value = 0
    await RisingEdge(dut.clk)

async def apply_inputs(dut, a, b):
    dut.ui_in.value = a
    dut.uio_in.value = b
    dut.in_valid.value = 1
    await RisingEdge(dut.clk)
    dut.in_valid.value = 0

@cocotb.test()
async def test_sequential_multiplier(dut):
    dut._log.info("Starting test for 4-bit sequential multiplier")
    dut.clk.value = 0
    dut.in_valid.value = 0
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    # Clock generation
    async def clk_gen():
        while True:
            dut.clk.value = not dut.clk.value
            await Timer(5, units="ns")

    cocotb.start_soon(clk_gen())

    await reset_dut(dut)

    test_vectors = [
        (9, 6, 54),
        (15, 15, 225),
        (7, 0, 0),
        (0, 13, 0),
        (3, 4, 12)
    ]

    for a, b, expected in test_vectors:
        await apply_inputs(dut, a, b)

        # Wait until out_done is high
        for _ in range(10):
            await RisingEdge(dut.clk)
            if dut.out_done.value == 1:
                break

        result = int(dut.uo_out.value)
        dut._log.info(f"{a} * {b} = {result}, expected = {expected}")
        assert result == expected, f"FAIL: {a} * {b} = {result}, expected {expected}"

    dut._log.info("All test vectors passed.")

