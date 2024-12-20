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
from data_process import DSP

#set type of test here to test different modules
test_type = 'top'
# Set up Python DSP.
dsp = DSP()
 
async def reset(clk, reset_wire, duration, value):
    reset_wire.value = value
    await ClockCycles(clk, duration)
    reset_wire.value = ~value

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

@cocotb.test()
async def test_top(dut):
    """cocotb test for top"""
    tester = SSSTester(dut, test_type)
    cocotb.start_soon(Clock(dut.s00_axis_aclk, 10, units="ns").start())
    await set_ready_4(dut,1)
    await reset(dut.s00_axis_aclk, dut.s00_axis_aresetn,2,0)

    NUM_SAMPLES = 5000

    dut.num_samples.value = NUM_SAMPLES
    '''for i in range(50):
        # data0 = {'type':'single', "contents":{"data": (random.randint(0,65535)*(2**16) + random.randint(0,65535)),"last":0,"strb":15}}
        # data1 = {'type':'single', "contents":{"data": (random.randint(0,65535)*(2**16) + random.randint(0,65535)),"last":0,"strb":15}}
        # data2 = {'type':'single', "contents":{"data": (random.randint(0,65535)*(2**16) + random.randint(0,65535)),"last":0,"strb":15}}
        # data3 = {'type':'single', "contents":{"data": (random.randint(0,65535)*(2**16) + random.randint(0,65535)),"last":0,"strb":15}}
        data0 = {'type':'single', "contents":{"data": (1*(2**16) + 1),"last":0,"strb":15}}
        data1 = {'type':'single', "contents":{"data": (1*(2**16) + 1),"last":0,"strb":15}}
        data2 = {'type':'single', "contents":{"data": (1*(2**16) + 1),"last":0,"strb":15}}
        data3 = {'type':'single', "contents":{"data": (1*(2**16) + 1),"last":0,"strb":15}}
        #data = {'type':'single', "contents":{"data": (25306*(2**16) - 234),"last":0,"strb":15}}
        tester.input_driver0.append(data0)
        tester.input_driver1.append(data1)
        tester.input_driver2.append(data2)
        tester.input_driver3.append(data3)
        await ClockCycles(dut.s00_axis_aclk, 20)'''
    
    example_adc_data = np.load("../../../../data_capture/example_adc_data/ports_connected_port1_active.npz")
    print(example_adc_data.keys())
    print(len(example_adc_data["port1_forward_buffer"]))
    port1_forward_raw_data = example_adc_data["port1_forward_buffer"][:5000]#.real.astype(np.int16).astype(np.uint32) | (example_adc_data["port1_forward"].imag.astype(np.int16).astype(np.uint32) << 16)
    port1_reverse_raw_data = example_adc_data["port1_reverse_buffer"][:5000]#.real.astype(np.int16).astype(np.uint32) | (example_adc_data["port1_reverse"].imag.astype(np.int16).astype(np.uint32) << 16)
    port2_forward_raw_data = example_adc_data["port2_forward_buffer"][:5000]#.real.astype(np.int16).astype(np.uint32) | (example_adc_data["port2_forward"].imag.astype(np.int16).astype(np.uint32) << 16)
    port2_reverse_raw_data = example_adc_data["port2_reverse_buffer"][:5000]#.real.astype(np.int16).astype(np.uint32) | (example_adc_data["port2_reverse"].imag.astype(np.int16).astype(np.uint32) << 16)
    
    port1_forward_raw_data_I = example_adc_data["port1_forward_buffer"][:5000] >> 16
    port1_forward_raw_data_Q = example_adc_data["port1_forward_buffer"][:5000] & 0x0000FFFF
    port1_reverse_raw_data_I = example_adc_data["port1_reverse_buffer"][:5000] >> 16
    port1_reverse_raw_data_Q = example_adc_data["port1_reverse_buffer"][:5000] & 0x0000FFFF
    port2_forward_raw_data_I = example_adc_data["port2_forward_buffer"][:5000] >> 16
    port2_forward_raw_data_Q = example_adc_data["port2_forward_buffer"][:5000] & 0x0000FFFF
    port2_reverse_raw_data_I = example_adc_data["port2_reverse_buffer"][:5000] >> 16
    port2_reverse_raw_data_Q = example_adc_data["port2_reverse_buffer"][:5000] & 0x0000FFFF

    print(port1_forward_raw_data_Q)
    print(port1_forward_raw_data)

    data0 = {'type': 'burst', "contents": {"data": port1_reverse_raw_data_Q}}
    data1 = {'type': 'burst', "contents": {"data": port1_reverse_raw_data_I}}

    data2 = {'type': 'burst', "contents": {"data": port1_forward_raw_data_Q}}
    data3 = {'type': 'burst', "contents": {"data": port1_forward_raw_data_I}}

    data4 = {'type': 'burst', "contents": {"data": port2_reverse_raw_data_Q}}
    data5 = {'type': 'burst', "contents": {"data": port2_reverse_raw_data_I}}

    data6 = {'type': 'burst', "contents": {"data": port2_forward_raw_data_Q}}
    data7 = {'type': 'burst', "contents": {"data": port2_forward_raw_data_I}}

    tester.input_driver0.append(data0)
    tester.input_driver1.append(data1)
    tester.input_driver2.append(data2)
    tester.input_driver3.append(data3)
    tester.input_driver4.append(data4)
    tester.input_driver5.append(data5)
    tester.input_driver6.append(data6)
    tester.input_driver7.append(data7)

    await ClockCycles(dut.s00_axis_aclk, 7000)

    """
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
    """
    port2_forward = dsp.binary_to_complex(port2_forward_raw_data)
    port2_reverse = dsp.binary_to_complex(port2_reverse_raw_data)
    port1_forward = dsp.binary_to_complex(port1_forward_raw_data)
    port1_reverse = dsp.binary_to_complex(port1_reverse_raw_data)

    filtered_port2_forward = dsp.filter(port2_forward)
    filtered_port2_reverse = dsp.filter(port2_reverse)
    filtered_port1_forward = dsp.filter(port1_forward)
    filtered_port1_reverse = dsp.filter(port1_reverse)

    S11_mag, S11_phase = dsp.calculate_S_param(filtered_port1_forward, filtered_port1_reverse)
    S21_mag, S21_phase = dsp.calculate_S_param(filtered_port1_forward, filtered_port2_reverse)
    S12_mag, S12_phase = dsp.calculate_S_param(filtered_port2_forward, filtered_port1_reverse)
    S22_mag, S22_phase = dsp.calculate_S_param(filtered_port2_forward, filtered_port2_reverse)

    print("S11, mag, phase", S11_mag, S11_phase)
    print("S21, mag, phase", S21_mag, S21_phase)
    print("S12, mag, phase", S12_mag, S12_phase)
    print("S22, mag, phase", S22_mag, S22_phase)

    #assert tester.input_mon.transactions==tester.output_mon.transactions, f"Transaction Count doesn't match! in {tester.input_mon.transactions} != out {tester.output_mon.transactions}:/"
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
    sources = [proj_path / "hdl" / "DSP_top_level.sv", proj_path / "hdl" / "fir_15.sv", proj_path / "hdl" / "cordic.sv", proj_path / "hdl" / "compute_coeff_averaging.sv"] #grow/modify this as needed.
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
