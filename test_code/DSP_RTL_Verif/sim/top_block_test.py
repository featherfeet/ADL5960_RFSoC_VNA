import cocotb
import os
import random
import sys
import logging
from pathlib import Path
from cocotb.utils import get_sim_time as gst
from cocotb.runner import get_runner
import numpy as np
from cocotb.clock import Clock
from cocotb.triggers import Timer, ClockCycles, RisingEdge, FallingEdge, ReadOnly, with_timeout, First, Join
from cocotb_bus.bus import Bus
from cocotb_bus.drivers import BusDriver
from cocotb_bus.monitors import Monitor
from cocotb_bus.monitors import BusMonitor

from axi_monitor import AXISMonitor
from axi_driver import AXISDriver
from axi_tester import SSSTester

#set type of test here to test different modules
test_type = "top"
 
async def reset(clk, reset_wire, duration, value):
    reset_wire.value = ~value
    await ClockCycles(clk, duration)
    reset_wire.value = value

async def start_driver(tester, data, driver_num):
    if (driver_num == 0):
        tester.input_driver0.append(data)
    elif (driver_num == 1):
        tester.input_driver1.append(data)
    elif (driver_num == 2):
        tester.input_driver2.append(data)
    else:
        tester.input_driver3.append(data)


async def set_ready(dut, value):
    dut.m00_axis_tready.value = value

async def set_ready_4(dut, value):
    dut.m00_axis_tready.value = value
    dut.m01_axis_tready.value = value
    dut.m02_axis_tready.value = value
    dut.m03_axis_tready.value = value

@cocotb.test()
async def test_top(dut):
    """cocotb test for top"""
    tester = SSSTester(dut, test_type)
    cocotb.start_soon(Clock(dut.s00_axis_aclk, 10, units="ns").start())
    await set_ready_4(dut,1)
    await reset(dut.s00_axis_aclk, dut.s00_axis_aresetn,2,0)
    #dut.num_samples.value = 20


    data0 = {'type':'burst', "contents":{"data": np.array([random.randint(0, 2**32-1) for i in range(100)])}}
    data1 = {'type':'burst', "contents":{"data": np.array([random.randint(0, 2**32-1) for i in range(100)])}}
    data2 = {'type':'burst', "contents":{"data": np.array([random.randint(0, 2**32-1) for i in range(100)])}}
    data3 = {'type':'burst', "contents":{"data": np.array([random.randint(0, 2**32-1) for i in range(100)])}}
    tester.input_driver0.append(data0)
    tester.input_driver1.append(data1)
    tester.input_driver2.append(data2)
    tester.input_driver3.append(data3)

    await ClockCycles(dut.s00_axis_aclk, random.randint(1, 8))
    await ClockCycles(dut.s00_axis_aclk, 100)
    await set_ready_4(dut,0)
    await ClockCycles(dut.s00_axis_aclk, random.randint(50, 150))
    await set_ready_4(dut,1)
    await ClockCycles(dut.s00_axis_aclk, random.randint(1, 10))
    await set_ready_4(dut,0)
    await ClockCycles(dut.s00_axis_aclk, random.randint(1, 13))
    await set_ready_4(dut,1)
    await ClockCycles(dut.s00_axis_aclk, random.randint(1000, 1350))

    assert tester.input_mon.transactions==tester.output_mon.transactions, f"Transaction Count doesn't match! in {tester.input_mon.transactions} != out {tester.output_mon.transactions}:/"
    #raise tester.scoreboard.result



"""the code below should largely remain unchanged in structure, though the specific files and things
specified should get updated for different simulations.
"""
 
def axi_runner():
    """Simulate the counter using the Python runner."""
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "icarus")
    proj_path = Path(__file__).resolve().parent.parent
    sys.path.append(str(proj_path / "sim" / "model"))
    sources = [proj_path / "hdl" / "DSP_top_level.sv", proj_path / "hdl" / "fir_15.sv", proj_path / "hdl" / "cordic.sv", proj_path / "hdl" / "compute_coeff.sv"] #grow/modify this as needed.
    build_test_args = ["-Wall"]#,"COCOTB_RESOLVE_X=ZEROS"]
    parameters = {}
    sys.path.append(str(proj_path / "sim"))
    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel="DSP_top_level",
        always=True,
        build_args=build_test_args,
        parameters=parameters,
        timescale = ('1ns','1ps'),
        waves=True
    )
    run_test_args = []
    runner.test(
        hdl_toplevel="DSP_top_level",
        test_module="top_block_test",
        test_args=run_test_args,
        waves=True
    )
 
if __name__ == "__main__":
    axi_runner()