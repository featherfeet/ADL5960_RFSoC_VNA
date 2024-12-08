#!/usr/bin/env python3

import io
import time
import math
import numpy as np
import zlib
import pickle

from sig_source import SigSource
from data_process import DSP
from adl5960 import ADL5960
from switch import Switch
from adcs import ADCs
from sig_source import SigSource

from pynq import PL, Overlay, GPIO

import socket

# Connect to GUI over network.
print("Connecting to GUI on remote computer...")
gui_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
gui_socket.connect(("192.168.0.105", 1234))

# Upload Code to RFSoC
print("Uploading overlay to RFSoC...")
PL.reset() #important fixes caching issues which have popped up.
ol = Overlay('./design_1.bit')  #locate/point to the bit file

# Set up RF switch
print("Setting up RF switch...")
switch = Switch(GPIO(GPIO.get_gpio_pin(0), "out"))

# Set up ADCs
print("Setting up RFSoC ADCs...")
adcs = ADCs(ol.usp_rf_data_converter_0, ol.axi_dma_0)

# Set up SPI devices
print("Setting up VNA frontends...")
adl1 = ADL5960(ol.spi_adl_0)
adl2 = ADL5960(ol.spi_adl_1)
print("Setting up source...")
source = SigSource(mmio_spi_controller = ol.spi_lmx_0)
source.set_active()
source.set_frequency(100e6) # TODO remove

# Set up Python DSP.
dsp = DSP()

#Main capture and processing loop.
first = True
while True:
    freq = source.get_current_freq()

    # Set switch
    switch.setPort1Active()

    # Read ADC values from DMA
    port1_reverse_buffer, port1_forward_buffer, port2_reverse_buffer, port2_forward_buffer = adcs.read_adcs()

    port2_forward = dsp.binary_to_complex(port2_forward_buffer)
    port2_reverse = dsp.binary_to_complex(port2_reverse_buffer)
    port1_forward = dsp.binary_to_complex(port1_forward_buffer)
    port1_reverse = dsp.binary_to_complex(port1_reverse_buffer)

    # Filter out LO spike.
    filtered_port2_forward = dsp.filter(port2_forward)
    filtered_port2_reverse = dsp.filter(port2_reverse)
    filtered_port1_forward = dsp.filter(port1_forward)
    filtered_port1_reverse = dsp.filter(port1_reverse)

    # Calculate S-parameters S11 and S12
    S11_mag, S11_phase = dsp.calculate_S_param(filtered_port1_forward, filtered_port1_reverse)
    S12_mag, S12_phase = dsp.calculate_S_param(filtered_port1_forward, filtered_port2_forward)

    # Set switch
    switch.setPort2Active()

    # Read ADC values from DMA
    port1_reverse_buffer, port1_forward_buffer, port2_reverse_buffer, port2_forward_buffer = adcs.read_adcs()

    port2_forward = dsp.binary_to_complex(port2_forward_buffer)
    port2_reverse = dsp.binary_to_complex(port2_reverse_buffer)
    port1_forward = dsp.binary_to_complex(port1_forward_buffer)
    port1_reverse = dsp.binary_to_complex(port1_reverse_buffer)

    # Filter out LO spike.
    filtered_port2_forward = dsp.filter(port2_forward)
    filtered_port2_reverse = dsp.filter(port2_reverse)
    filtered_port1_forward = dsp.filter(port1_forward)
    filtered_port1_reverse = dsp.filter(port1_reverse)

    # Calculate S-parameters S21 and S22
    S21_mag, S21_phase = dsp.calculate_S_param(filtered_port2_forward, filtered_port1_forward)
    S22_mag, S22_phase = dsp.calculate_S_param(filtered_port2_forward, filtered_port2_reverse)

    # Send data to network GUI.
    start = time.time()
    message = {}
    message["filtered_port1_forward"] = filtered_port1_forward[:500].real.tobytes()
    message["filtered_port2_forward"] = filtered_port2_forward[:500].real.tobytes()
    message["filtered_port1_reverse"] = filtered_port1_reverse[:500].real.tobytes()
    message["filtered_port2_reverse"] = filtered_port2_reverse[:500].real.tobytes()
    bytes_to_send = pickle.dumps(message)
    end = time.time()
    print(f"Saving takes {end - start} s")
    start = time.time()
    gui_socket.sendall(len(bytes_to_send).to_bytes(4, "little"))
    gui_socket.sendall(bytes_to_send)
    end = time.time()
    print(f"Sending takes {end - start} s for {len(bytes_to_send)} bytes.")

    print(f"Frequency: {freq / 1e6:.3f} MHz")
    print(f"Calculated S11 magnitude is {S11_mag:.2f}.")
    print(f"Calculated S11 phase is {S11_phase * 180 / math.pi:.2f}\N{DEGREE SIGN}.")
    print(f"Calculated S12 magnitude is {S12_mag:.2f}.")
    print(f"Calculated S12 phase is {S12_phase * 180 / math.pi:.2f}\N{DEGREE SIGN}.")
    print(f"Calculated S21 magnitude is {S21_mag:.2f}.")
    print(f"Calculated S21 phase is {S21_phase * 180 / math.pi:.2f}\N{DEGREE SIGN}.")
    print(f"Calculated S22 magnitude is {S22_mag:.2f}.")
    print(f"Calculated S22 phase is {S22_phase * 180 / math.pi:.2f}\N{DEGREE SIGN}.")
    #data_out_file.write(f"{freq},{S11_mag},{S12_mag},{S21_mag},{S22_mag}\n")
    #data_out_file.flush()
