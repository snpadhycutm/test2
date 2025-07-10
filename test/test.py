# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles


@cocotb.test()
async def test_project(dut):
    """Testbench for 4-bit sequential multiplier (tt_um_seq_mul)"""

    dut._log.info("Starting sequential multiplier testbench...")

    # Set up a 100 MHz clock
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    # Initial values
    dut.rst_n.value = 1
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    await ClockCycles(dut.clk, 2)

    async def run_test(a, b, expected):
        # Load inputs: ui_in = {b[3:0], a[3:0]}
        dut.ui_in.value = (b << 4) | a

        # Start pulse
        dut.uio_in.value = 1
        await ClockCycles(dut.clk, 1)
        dut.uio_in.value = 0

        # Wait enough cycles for multiplication to complete
        await ClockCycles(dut.clk, 20)

        actual = dut.uo_out.value.integer
        dut._log.info(f"{a} x {b} = {actual} (Expected: {expected})")
        assert actual == expected, f"FAILED: {a} x {b} = {actual}, expected {expected}"

    # Run a few tests
    await run_test(3, 2, 6)
    await run_test(4, 5, 20)
    await run_test(0, 15, 0)
    await run_test(15, 15, 225)
