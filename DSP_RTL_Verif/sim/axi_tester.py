import cocotb
import os
import random
import sys
import logging
import numpy as np

from cocotb.handle import SimHandleBase
from axi_monitor import AXISMonitor
from axi_driver import AXISDriver
from cocotb_bus.scoreboard import Scoreboard
from axi_scoreboard import AXISscoreboard
from python_16bit_cordic import do_cordic
 
class SSSTester:
    """
    Checker of an instance
    Args
      dut_entity: handle to an instance 
    """
    def __init__(self, dut_entity: SimHandleBase, test_type, debug=False):
        self.test_type = test_type
        self.dut = dut_entity
        self.log = logging.getLogger("cocotb.tb")
        self.log.setLevel(logging.DEBUG)
        self.input_mon = AXISMonitor(self.dut,'s00',self.dut.s00_axis_aclk, callback=self.model)
        self.output_mon = AXISMonitor(self.dut,'m00',self.dut.s00_axis_aclk)
        self.input_driver = AXISDriver(self.dut,'s00',self.dut.s00_axis_aclk)
        self._checker = None
        self.calcs_sent = 0
        # Create a scoreboard on the stream_out bus
        self.expected_output = [] #contains list of expected outputs (Growing)
        self.scoreboard = AXISscoreboard(self.dut, test_type, fail_immediately=False)
        self.scoreboard.add_interface(self.output_mon, self.expected_output)
 
    def stop(self) -> None:
        """Stops everything"""
        if self._checker is None:
            raise RuntimeError("Monitor never started")
        self.input_mon.stop()
        self.output_mon.stop()
        self.input_driver.stop()
 
    def model(self, transaction):
        """Calls python modules to get the expected output for input data"""
        if(self.test_type == "cordic"):
            data = str(transaction['data'])
            part_1 = self.cast_signed_binary_to_int(data[16:]) #bottom 16 bits
            part_2 = self.cast_signed_binary_to_int(data[0:16])
            print("I data", part_1)
            print("Q data", part_2)
            (r, theta) = do_cordic(part_1, part_2)

            result = {"r": r, "theta": theta, "last": transaction["last"], "count": transaction["count"]}
        else: 
            result = {"data": transaction["data"], "last": transaction["last"], "count": transaction["count"]}

        self.expected_output.append(result)

    def cast_signed_binary_to_int(self, binary_str):
        """Casts a signed binary string to an integer."""

        if binary_str[0] == '1':
            # Negative number
            inverted_str = ''.join(['1' if bit == '0' else '0' for bit in binary_str[1:]])
            return -int(inverted_str, 2) - 1
        else:
            # Positive number
            return int(binary_str, 2)