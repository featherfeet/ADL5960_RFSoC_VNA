import cocotb
from cocotb.triggers import Timer
import os
import random
import sys
from pathlib import Path
from cocotb.runner import get_runner
from math import log
import logging
from cocotb.clock import Clock
from cocotb.triggers import Timer, ClockCycles, RisingEdge, FallingEdge, ReadOnly,ReadWrite,with_timeout, First, Join
from cocotb.utils import get_sim_time as gst

from random import getrandbits

def reverse_bits(n,size):
    reversed_n = 0
    for i in range(size):
        reversed_n = (reversed_n << 1) | (n & 1)
        n >>= 1
    return reversed_n

SPI_RESP_MSG = 0x2345

async def drive_data_in(dut,data):
    data_wire = dut.data_in
    cs_wire = dut.chip_sel_out
    trigger_wire = dut.trigger_in
    clk = dut.clk_in
    
    if (cs_wire.value == 0):
        await RisingEdge(cs_wire)
    await FallingEdge(clk)
    data_wire.value = data
    trigger_wire.value = 1
    await FallingEdge(clk)
    trigger_wire.value = 0
    data_wire.value = 0

async def collect_responses(dut, responses):
    valid_wire = dut.data_valid_out
    data_wire = dut.data_out
    clk = dut.clk_in

    while True:
        while (valid_wire.value == 0):
            await RisingEdge(clk)
        responses.append( data_wire.value.integer )
        await ClockCycles(clk,1)

async def listen_data_out(dut):
    valid_wire = dut.data_valid_out
    data_wire = dut.data_out
    clk = dut.clk_in

    while (valid_wire.value == 0):
        await RisingEdge(clk)
    return data_wire.value.integer
    

async def test_spi_device(dut,received_messages,response_queue, assert_message_length = False):
    dut.chip_data_in.value = 0
    count = 0
    count_max = dut.DATA_WIDTH.value
    while True:
        await FallingEdge(dut.chip_sel_out)
        spi_resp_msg = response_queue.pop(0)
        dut._log.info(f"CS pulled low, peripheral sending message 0x{spi_resp_msg:X}")
        
        spi_resp_msg = reverse_bits(spi_resp_msg, dut.DATA_WIDTH.value)
        dut.chip_data_in.value = (spi_resp_msg>>count)&0x1 #feed in lowest bit
        # dut._log.info(f"SPI peripheral Device Sending: {dut.chip_data_in.value}")
        received_message = 0
        while dut.chip_sel_out.value.integer ==0:
            await First( RisingEdge(dut.chip_clk_out), RisingEdge(dut.chip_sel_out) )
            await ReadOnly()
            if (dut.chip_sel_out.value == 1):
                # this means CS rose before the neck clock high, so the message is done
                break
            count+=1
            count%=count_max
            bit = dut.chip_data_out.value.integer
            # dut._log.info(f"SPI peripheral Device Receiving: {bit}")
            received_message = (received_message << 1) + bit
            await FallingEdge(dut.chip_clk_out)
            dut.chip_data_in.value = (spi_resp_msg>>count)&0x1 #feed in lowest bit
            # dut._log.info(f"SPI peripheral Device Sending: {dut.chip_data_in.value}")

        received_messages.append(received_message)
        if (assert_message_length and dut.rst_in.value == 0):
            assert count == 0, "CS was not held low for an appropriate number of DCLK cycles!"


async def assert_clockspeed(dut):
    """ ensure that clock edges are all lasting at least floor(0.5*DATA_CLK_PERIOD), except near resets."""
    sys_clk = dut.clk_in
    spi_clk = dut.chip_clk_out
    cs = dut.chip_sel_out
    PERIOD = dut.DATA_CLK_PERIOD.value
    rst = dut.rst_in

    target_cycle_count = int(PERIOD/2)
    target_halfperiod_ns = (target_cycle_count * 10) * (0.99)

    max_cycle_count = int(PERIOD/2)+1
    max_halfperiod_ns = (max_cycle_count * 10) * (1.01)

    prev_spi_clk = spi_clk.value
    prev_cs = cs.value
    last_reset = gst(units='ns')
    last_edge = gst(units='ns')
    last_cs_fall = gst(units='ns')
    while True:
        await RisingEdge(sys_clk)
        current_time = gst(units='ns')
        
        if (rst.value == 1):
            last_reset = current_time
        if (cs.value == 1 and prev_cs == 0):
            last_cs_fall = current_time
            
        if (prev_spi_clk != spi_clk.value):
            edge_duration = current_time - last_edge
            time_since_reset = current_time - last_reset
            # dut._log.info(f"Edge duration {edge_duration} ns")
            if (time_since_reset > target_halfperiod_ns):
                assert edge_duration >= target_halfperiod_ns, f"SPI clock is running too quickly for DATA_CLK_PERIOD = {PERIOD}"
            if (last_cs_fall < last_edge):
                assert edge_duration <= max_halfperiod_ns, f"SPI clock is running too slowly for DATA_CLK_PERIOD = {PERIOD}"
                
            last_edge = current_time

        assert not( spi_clk.value == 1 and cs.value == 1 ), "SPI clock should not be high when chip-select is high!"

        prev_spi_clk = spi_clk.value
        prev_cs = cs.value
            
            

    

async def reset(clk,rst, cycles_held = 3):
    rst.value = 1
    await ClockCycles(clk, cycles_held)
    rst.value = 0
      
"""
testing strategy

check for:
-CS value just after reset
-value output that matches what we send from testbench
-frequency of the clock
-controller only talks when it's supposed to
-CS value during listening
-CS value after listening should be done
"""

@cocotb.test()
async def test_spi_single(dut):
    """single message sent and received, check validity of response"""

    # clk_in clock
    cocotb.start_soon(Clock(dut.clk_in, 10, units="ns").start())
    dut.trigger_in.value = 0

    # reset for 3 cycles
    dut._log.info("Holding reset...")
    await reset( dut.clk_in, dut.rst_in )
    assert dut.chip_sel_out.value.integer==1, "CS is not high on reset!"

    # configure SPI peripheral device, with arrays for messages and responses
    received_messages = []

    SPI_PERIPHERAL_WORD = getrandbits( dut.DATA_WIDTH.value )
    dut._log.info(f"Peripheral will send 0x{SPI_PERIPHERAL_WORD:X}")
    response_queue = [ SPI_PERIPHERAL_WORD ]
    cocotb.start_soon(test_spi_device(dut, received_messages, response_queue))

    # monitor output of data_out
    data_out_responses = []
    cocotb.start_soon(collect_responses(dut,data_out_responses))

    # drive request for single message
    SPI_CONTROLLER_WORD = getrandbits( dut.DATA_WIDTH.value )
    dut._log.info(f"Controller will send 0x{SPI_CONTROLLER_WORD:X}")
    await drive_data_in(dut,SPI_CONTROLLER_WORD)

    # await response on data_out
    coro_monitor_data_out = cocotb.start_soon( listen_data_out(dut) )
    data_out_result = await with_timeout( coro_monitor_data_out, 200_000, timeout_unit='ns' )

    # assertions of proper data conditions!
    assert data_out_result == SPI_PERIPHERAL_WORD, f"Incorrect message received by controller! Peripheral sent 0x{SPI_PERIPHERAL_WORD:X}, controller received 0x{data_out_result:X}"
    assert len(data_out_responses)==1, "Too many responses received on data_out!"

    assert len(received_messages)==1, "Incorrect number of complete messages sent to peripheral!"
    assert received_messages[0] == SPI_CONTROLLER_WORD, f"Incorrect message sent by controller! data_in drove a request for 0x{SPI_CONTROLLER_WORD:X}, controller sent 0x{received_messages[0]:X}"

@cocotb.test()
async def test_spi_multiple(dut):
    """multiple messages sent and received, check validity of responses"""

    # clk_in clock
    cocotb.start_soon(Clock(dut.clk_in, 10, units="ns").start())
    dut.trigger_in.value = 0

    # reset for 3 cycles
    dut._log.info("Holding reset...")
    await reset( dut.clk_in, dut.rst_in )
    assert dut.chip_sel_out.value.integer==1, "CS is not high on reset!"

    # configure SPI peripheral device, with arrays for messages and responses
    received_messages = []
    intended_responses = [ getrandbits(dut.DATA_WIDTH.value) for _ in range(3) ]
    dut._log.info(f"Peripheral will send {[hex(val) for val in intended_responses ]}")
    response_queue = intended_responses.copy()
    cocotb.start_soon(test_spi_device(dut, received_messages, response_queue))

    # monitor output of data_out
    data_out_responses = []
    cocotb.start_soon(collect_responses(dut,data_out_responses))

    data_in_queue = [ getrandbits(dut.DATA_WIDTH.value) for _ in range(3) ]
    dut._log.info(f"Controller will send {[hex(val) for val in data_in_queue ]}")
    for message in data_in_queue:
        # drive request
        await with_timeout( drive_data_in(dut,message), 5000, timeout_unit='ns' )

        # await response on data_out
        coro_monitor_data_out = cocotb.start_soon( listen_data_out(dut) )
        data_out_result = await with_timeout( coro_monitor_data_out, 200_000, timeout_unit='ns' )
        dut._log.info(f"Data out Result: 0x{data_out_result:x}")

        await ClockCycles(dut.clk_in, 3)

    # assertions of proper data conditions!

    assert data_out_responses == intended_responses, f"Incorrect messages received by controller! Controller received {[hex(x) for x in data_out_responses]}, correct messages should have been {[hex(x) for x in intended_responses]}"

    assert received_messages == data_in_queue, f"Incorrect messages sent by controller! Controller send {[hex(x) for x in received_messages]}, correct messages should have been {[hex(x) for x in data_in_queue]}"

@cocotb.test()
async def test_spi_clock(dut):
    """multiple messages sent and received, assert clock speed and message lengths"""

    # clk_in clock
    cocotb.start_soon(Clock(dut.clk_in, 10, units="ns").start())
    dut.trigger_in.value = 0

    # reset for 3 cycles
    dut._log.info("Holding reset...")
    await reset( dut.clk_in, dut.rst_in )
    assert dut.chip_sel_out.value.integer==1, "CS is not high on reset!"

    # listen to DCLK for incorrect clock periods
    cocotb.start_soon( assert_clockspeed(dut) )

    # configure SPI peripheral device, with arrays for messages and responses
    received_messages = []
    intended_responses = [ getrandbits(dut.DATA_WIDTH.value) for _ in range(3) ]
    dut._log.info(f"Peripheral will send {[hex(val) for val in intended_responses ]}")
    response_queue = intended_responses.copy()
    cocotb.start_soon(test_spi_device(dut, received_messages, response_queue, assert_message_length=True))

    # monitor output of data_out
    data_out_responses = []
    cocotb.start_soon(collect_responses(dut,data_out_responses))

    data_in_queue = [ getrandbits(dut.DATA_WIDTH.value) for _ in range(3) ]
    dut._log.info(f"Controller will send {[hex(val) for val in data_in_queue ]}")
    for message in data_in_queue:
        # drive request
        await with_timeout( drive_data_in(dut,message), 5000, timeout_unit='ns' )

        # await response on data_out
        coro_monitor_data_out = cocotb.start_soon( listen_data_out(dut) )
        data_out_result = await with_timeout( coro_monitor_data_out, 200_000, timeout_unit='ns' )
        dut._log.info(f"Data out Result: 0x{data_out_result:x}")

        await ClockCycles(dut.clk_in, 3)

    # assertions of proper data conditions!

    assert data_out_responses == intended_responses, f"Incorrect messages received by controller! Controller received {[hex(x) for x in data_out_responses]}, correct messages should have been {[hex(x) for x in intended_responses]}"

    assert received_messages == data_in_queue, f"Incorrect messages sent by controller! Controller send {[hex(x) for x in received_messages]}, correct messages should have been {[hex(x) for x in data_in_queue]}"

def spi_con_runner():
    """Simulate the module using the Python runner."""
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "icarus")
    proj_path = Path(__file__).resolve().parent.parent
    sys.path.append(str(proj_path / "sim" / "model"))
    sources = [proj_path / "hdl" / "spi_control.sv"] #grow/modify this as needed.
    build_test_args = ["-Wall"]#,"COCOTB_RESOLVE_X=ZEROS"]
    #parameters = {"DATA_CLK_PERIOD": 4}
    sys.path.append(str(proj_path / "sim"))
    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel="spi_control", #modify
        always=True,
        build_args=build_test_args,
        timescale = ('1ns','1ps'),
        waves=True
    )
    run_test_args = []
    runner.test(
        hdl_toplevel="spi_control", #modify
        test_module="test_spi_con", #modify
        test_args=run_test_args,
        waves=True
    )
 
if __name__ == "__main__":
    spi_con_runner() #modify
