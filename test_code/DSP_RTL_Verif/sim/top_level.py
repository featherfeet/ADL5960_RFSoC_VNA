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
test_type = "cordic"
 
async def reset(clk, reset_wire, duration, value):
    reset_wire.value = value
    await ClockCycles(clk, duration)
    reset_wire.value = ~value

async def set_ready(dut, value):
    dut.m00_axis_tready.value = value

@cocotb.test()
async def test_random(dut):
    """cocotb test for cordic"""
    tester = SSSTester(dut, test_type)
    cocotb.start_soon(Clock(dut.s00_axis_aclk, 10, units="ns").start())
    await set_ready(dut,1)
    await reset(dut.s00_axis_aclk, dut.s00_axis_aresetn,2,0)

    #feed the driver:
    for i in range(50):
       data = {'type':'single', "contents":{"data": (random.randint(0,65535)*(2**16) + random.randint(0,65535)),"last":0,"strb":15}}
       #data = {'type':'single', "contents":{"data": (25306*(2**16) - 234),"last":0,"strb":15}}
       tester.input_driver.append(data)

    data = {'type':'burst', "contents":{"data": np.array([random.randint(0, 2**32-1) for i in range(100)])}}
    tester.input_driver.append(data)

    await ClockCycles(dut.s00_axis_aclk, random.randint(1, 8))
    await set_ready(dut,0)
    await ClockCycles(dut.s00_axis_aclk, random.randint(50, 150))
    await set_ready(dut,1)
    await ClockCycles(dut.s00_axis_aclk, random.randint(1, 10))
    await set_ready(dut,0)
    await ClockCycles(dut.s00_axis_aclk, random.randint(1, 13))
    await set_ready(dut,1)
    await ClockCycles(dut.s00_axis_aclk, random.randint(300, 350))

    assert tester.input_mon.transactions==tester.output_mon.transactions, f"Transaction Count doesn't match! in {tester.input_mon.transactions} != out {tester.output_mon.transactions}:/"
    raise tester.scoreboard.result

@cocotb.test()
async def test_cornercase(dut):
    """cocotb test for cordic"""
    tester = SSSTester(dut, test_type)
    cocotb.start_soon(Clock(dut.s00_axis_aclk, 10, units="ns").start())
    await set_ready(dut,1)
    await reset(dut.s00_axis_aclk, dut.s00_axis_aresetn,2,0)

    #feed the driver:
    for i in range(50):
       # Hit max and min values of signed data, and all ones/all zeros
       data = {'type':'single', "contents":{"data": (random.randint(0,1)*(2**16-1)*(2**16) + random.randint(0,1)*(2**16-1)),"last":0,"strb":15}}
       tester.input_driver.append(data)
       data = {'type':'single', "contents":{"data": (random.randint(0,1)*(2**15)*(2**16) + random.randint(0,1)*(2**15-1)),"last":0,"strb":15}}
       tester.input_driver.append(data)

    data = {'type':'burst', "contents":{"data": np.array(list(range(100)))}}
    tester.input_driver.append(data)

    await ClockCycles(dut.s00_axis_aclk, 7)
    await set_ready(dut,0)
    await ClockCycles(dut.s00_axis_aclk, 30)
    await set_ready(dut,1)
    await ClockCycles(dut.s00_axis_aclk, 10)
    await set_ready(dut,0)
    await ClockCycles(dut.s00_axis_aclk, 10)
    await set_ready(dut,1)
    await ClockCycles(dut.s00_axis_aclk, 300)
  
    assert tester.input_mon.transactions==tester.output_mon.transactions, f"Transaction Count doesn't match! in {tester.input_mon.transactions} != out {tester.output_mon.transactions}:/"
    raise tester.scoreboard.result

"""the code below should largely remain unchanged in structure, though the specific files and things
specified should get updated for different simulations.
"""
 
def axi_runner():
    """Simulate the counter using the Python runner."""
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "icarus")
    proj_path = Path(__file__).resolve().parent.parent
    sys.path.append(str(proj_path / "sim" / "model"))
    sources = [proj_path / "hdl" / "cordic.sv"] #grow/modify this as needed.
    build_test_args = ["-Wall"]#,"COCOTB_RESOLVE_X=ZEROS"]
    parameters = {}
    sys.path.append(str(proj_path / "sim"))
    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel="cordic",
        always=True,
        build_args=build_test_args,
        parameters=parameters,
        timescale = ('1ns','1ps'),
        waves=True
    )
    run_test_args = []
    runner.test(
        hdl_toplevel="cordic",
        test_module="top_level",
        test_args=run_test_args,
        waves=True
    )
 
if __name__ == "__main__":
    axi_runner()