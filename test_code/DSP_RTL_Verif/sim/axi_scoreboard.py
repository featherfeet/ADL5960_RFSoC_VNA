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
from cocotb_bus.scoreboard import Scoreboard
from python_cordic import do_cordic

class AXISscoreboard(Scoreboard):
    def __init__(self, dut, test_type, fail_immediately=False):
        self.test_type = test_type
        Scoreboard.__init__(self, dut, fail_immediately=False)

    def compare(self, got, exp, log, strict_type=True):
        if(self.test_type == "cordic"):
            g_theta= int(got["data"][0:15])
            g_r = int(got["data"][16:31])
            e_theta = exp['theta']
            e_r = exp["r"]

            print(" Expected r theta: ", e_r, e_theta, " Got ", g_r, g_theta)
            assert abs(g_r-e_r) <= 1, f"Radius does not match! Expected {e_r} got {g_r}"  
            assert abs(g_theta-e_theta) <= 1, f"Theta does not match! Expected {e_theta} got {g_theta}" 
            assert got["last"] == exp["last"], f"Last does not match! Expected {exp['last']} got {got['last']}"  
            assert got["count"] == exp["count"], f"Count does not match! Expected {exp['count']} got {got['count']}" 

        elif(self.test_type != "coeff"):
            for key in exp.keys():
                print("Expected " + str(key) + " " + exp[key] + " Got: " + got[key])
                assert got[key] == exp[key], f"{key} does not match! Expected {exp[key]} got {got[key]}"



