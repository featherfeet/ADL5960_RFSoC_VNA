import cocotb
import os
import random
import sys
import logging
from pathlib import Path
from cocotb.triggers import Timer
from cocotb.utils import get_sim_time as gst
from cocotb.runner import get_runner
import numpy as np
from cocotb.triggers import Timer, ClockCycles, RisingEdge, FallingEdge, ReadOnly, with_timeout, First, Join
from cocotb_bus.bus import Bus
from cocotb_bus.drivers import BusDriver
from cocotb_bus.monitors import Monitor
from cocotb_bus.monitors import BusMonitor

class AXISDriver(BusDriver):
  def __init__(self, dut, name, clk):
    self._signals = ['axis_tvalid', 'axis_tready', 'axis_tlast', 'axis_tdata','axis_tstrb']
    BusDriver.__init__(self, dut, name, clk)
    self.clock = clk
    self.bus.axis_tdata.value = 0
    self.bus.axis_tstrb.value = 0
    self.bus.axis_tlast.value = 0
    self.bus.axis_tvalid.value = 0

  async def _driver_send(self, value, sync=True):
        clk_falling_edge = FallingEdge(self.clock)
        clk_rising_edge = RisingEdge(self.clock)

        if value["type"] == "single":
            # Send the actual trasaction
            #print(f"[DRIVER] sending single transaction with {value}")

            await clk_falling_edge

            # set signals:
            self.bus.axis_tvalid.value = 1
            self.bus.axis_tdata.value = value["contents"]["data"]
            self.bus.axis_tstrb.value = value["contents"]["strb"]
            self.bus.axis_tlast.value = value["contents"]["last"]

            if (self.bus.axis_tready != 1):
                await RisingEdge(self.bus.axis_tready)

            await clk_rising_edge #ensure high for at least one cycle
            await clk_falling_edge

        else:
            # Set up for a burst transaction
            index = 0
            #print(f"[DRIVER] sending burst transaction with {value}")

            # Send the actual trasaction
            await clk_falling_edge

            while (index < len(value["contents"]["data"])):
                #print(f"INDEX: {index}")
                # set signals:
                self.bus.axis_tvalid.value = 1
                self.bus.axis_tdata.value = int(value["contents"]["data"][index])
                self.bus.axis_tstrb.value = 15
                if(index == len(value["contents"]["data"]) - 1):
                    self.bus.axis_tlast.value = 1

                if (self.bus.axis_tready.value != 1):
                    await RisingEdge(self.bus.axis_tready)
                
                await clk_rising_edge # Do this to make sure its high for at least a cycle
                await clk_falling_edge 
                index += 1
            

        # set everything back to zero on a falling edge. 
        self.bus.axis_tvalid.value = 0
        self.bus.axis_tlast.value = 0
        self.bus.axis_tdata.value = 0
        self.bus.axis_tstrb.value = 0            




