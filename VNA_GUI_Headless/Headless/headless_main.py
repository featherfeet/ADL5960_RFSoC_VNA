#!/usr/bin/env python3

import io
import time
import math
import numpy as np
import zlib
import skrf as rf

from networking import GuiRemoteConnection
from sig_source import SigSource
from data_process import DSP, polar_to_rectangular
from adl5960 import ADL5960
from switch import Switch
from adcs import ADCs
from sig_source import SigSource

from pynq import PL, Overlay, GPIO

import socket

# Connect to GUI over network.
print("Connecting to GUI on remote computer...")
remote_connection = GuiRemoteConnection()

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
adl1 = ADL5960(ol.spi_adl_0, fgain = 30, rgain = 36)
adl2 = ADL5960(ol.spi_adl_1, fgain = 30, rgain = 36)
print("Setting up source...")
source = SigSource(mmio_spi_controller = ol.spi_lmx_0)
source.set_active()

# Set up Python DSP.
dsp = DSP()

#Main capture and processing loop.
#filename = "siggen"
#data_out_file = open("bandpass.csv", "w")
#data_out_file.write(f"Freq (Hz),S11_mag,S11_phase,S12_mag,S12_phase,S21_mag,S21_phase,S22_mag,S22_phase\n")

raw_s_parameters = rf.Network(s = np.zeros((len(source.freq_points), 2, 2), dtype = np.float64), f = source.freq_points)

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

    #np.savez(f"{filename}_port1_active_adc_data.npz", port1_forward = port1_forward, port1_reverse = port1_reverse, port2_forward = port2_forward, port2_reverse = port2_reverse)

    # Filter out LO spike.
    filtered_port2_forward = dsp.filter(port2_forward)
    filtered_port2_reverse = dsp.filter(port2_reverse)
    filtered_port1_forward = dsp.filter(port1_forward)
    filtered_port1_reverse = dsp.filter(port1_reverse)

    # Calculate S-parameters S11 and S12
    S11_mag, S11_phase = dsp.calculate_S_param(filtered_port1_forward, filtered_port1_reverse)
    S12_mag, S12_phase = dsp.calculate_S_param(filtered_port2_forward, filtered_port1_forward)

    # Send data to network GUI.
    message = {}
    message["filtered_port1_forward"] = filtered_port1_forward[:500].real.tobytes()
    message["filtered_port2_forward"] = filtered_port2_forward[:500].real.tobytes()
    message["filtered_port1_reverse"] = filtered_port1_reverse[:500].real.tobytes()
    message["filtered_port2_reverse"] = filtered_port2_reverse[:500].real.tobytes()
    message["raw_s_parameters"] = raw_s_parameters
    remote_connection.send_message(message)

    # Set switch
    switch.setPort2Active()

    # Read ADC values from DMA
    port1_reverse_buffer, port1_forward_buffer, port2_reverse_buffer, port2_forward_buffer = adcs.read_adcs()

    port2_forward = dsp.binary_to_complex(port2_forward_buffer)
    port2_reverse = dsp.binary_to_complex(port2_reverse_buffer)
    port1_forward = dsp.binary_to_complex(port1_forward_buffer)
    port1_reverse = dsp.binary_to_complex(port1_reverse_buffer)

    #np.savez(f"{filename}_port2_active_adc_data.npz", port1_forward = port1_forward, port1_reverse = port1_reverse, port2_forward = port2_forward, port2_reverse = port2_reverse)

    # Filter out LO spike.
    filtered_port2_forward = dsp.filter(port2_forward)
    filtered_port2_reverse = dsp.filter(port2_reverse)
    filtered_port1_forward = dsp.filter(port1_forward)
    filtered_port1_reverse = dsp.filter(port1_reverse)

    # Calculate S-parameters S21 and S22
    S21_mag, S21_phase = dsp.calculate_S_param(filtered_port2_forward, filtered_port1_forward)
    S22_mag, S22_phase = dsp.calculate_S_param(filtered_port2_forward, filtered_port2_reverse)

    # Save raw S-parameters.
    raw_s_parameters.s[source.get_current_index(), 0, 0] = polar_to_rectangular(S11_mag, S11_phase)
    raw_s_parameters.s[source.get_current_index(), 0, 1] = polar_to_rectangular(S12_mag, S12_phase)
    raw_s_parameters.s[source.get_current_index(), 1, 0] = polar_to_rectangular(S21_mag, S21_phase)
    raw_s_parameters.s[source.get_current_index(), 1, 1] = polar_to_rectangular(S22_mag, S22_phase)

    # Send data to network GUI.
    """
    message = {}
    message["filtered_port1_forward"] = filtered_port1_forward[:500].real.tobytes()
    message["filtered_port2_forward"] = filtered_port2_forward[:500].real.tobytes()
    message["filtered_port1_reverse"] = filtered_port1_reverse[:500].real.tobytes()
    message["filtered_port2_reverse"] = filtered_port2_reverse[:500].real.tobytes()
    message["raw_s_parameters"] = raw_s_parameters
    remote_connection.send_message(message)
    """

    # Check for messages.
    message = remote_connection.receive_message()
    if message:
        print(message)
        if message["type"] == "parameters":
            source.update_parameters(start = message["start"], stop = message["stop"], center = message["center"], span = message["span"], resolution = message["resolution"], single_freq = message["single_freq"])
            source.set_next_freq(start = True)
            raw_s_parameters = rf.Network(s = np.zeros((len(source.freq_points), 2, 2), dtype = np.complex128), f = source.freq_points)

    """
    print(f"Frequency: {freq} MHz")
    print(f"Calculated S11 magnitude is {S11_mag:.2f}.")
    print(f"Calculated S11 phase is {S11_phase * 180 / math.pi:.2f}\N{DEGREE SIGN}.")
    print(f"Calculated S12 magnitude is {S12_mag:.2f}.")
    print(f"Calculated S12 phase is {S12_phase * 180 / math.pi:.2f}\N{DEGREE SIGN}.")
    print(f"Calculated S21 magnitude is {S21_mag:.2f}.")
    print(f"Calculated S21 phase is {S21_phase * 180 / math.pi:.2f}\N{DEGREE SIGN}.")
    print(f"Calculated S22 magnitude is {S22_mag:.2f}.")
    print(f"Calculated S22 phase is {S22_phase * 180 / math.pi:.2f}\N{DEGREE SIGN}.")
    """

    source.set_next_freq()

    #np.savez(f"{filename}_s_parameters.npz", S11_mag = S11_mag, S11_phase = S11_phase, S12_mag = S12_mag, S12_phase = S12_phase, S21_mag = S21_mag, S21_phase = S21_phase, S22_mag = S22_mag, S22_phase = S22_phase)

    #break
    #data_out_file.write(f"{freq},{S11_mag},{S11_phase},{S12_mag},{S12_phase},{S21_mag},{S21_phase},{S22_mag},{S22_phase}\n")
    #data_out_file.flush()
