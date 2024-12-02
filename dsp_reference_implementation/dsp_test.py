#!/usr/bin/env python3

import math
import numpy as np
import matplotlib.pyplot as plt
import scipy.signal as signal

# ADCs give us samples at 147.456 Msps
sampling_frequency = 147.456e6
capture_length = 65535

# IF is 11 MHz. We set NCO to 10 MHz for offset tuning (to avoid LO spike).
intermediate_frequency = 11e6
nco_frequency = 10e6

# Create test signals similar to those that would go into the ADCs.
forward_signal = 300 * np.sin(2 * math.pi * intermediate_frequency * np.arange(capture_length) / sampling_frequency)
reverse_signal = 200 * np.sin(2 * math.pi * intermediate_frequency * np.arange(capture_length) / sampling_frequency + 0.5)
forward_signal += 10 * np.random.randn(len(forward_signal))
reverse_signal += 10 * np.random.randn(len(reverse_signal))

# Quadrature sample the test signals like the ADC would.
nco_signal = np.sin(2 * math.pi * nco_frequency * np.arange(capture_length) / sampling_frequency)
nco_signal_quadrature = np.cos(2 * math.pi * nco_frequency * np.arange(capture_length) / sampling_frequency)
forward_signal_sampled = forward_signal * nco_signal + 1j * forward_signal * nco_signal_quadrature
reverse_signal_sampled = reverse_signal * nco_signal + 1j * reverse_signal * nco_signal_quadrature

#~~~~~~~~~~~~~~~~~~Processing done by the FPGA starts here~~~~~~~~~~~~~~~~~~~~~~

# Filter the signals using an FIR filter. This sets the IFBW of the VNA and helps remove the LO spike.
fir_filter = signal.firwin(15, [1e6 - 5e3, 1e6 + 5e3], fs = sampling_frequency, pass_zero = False)
forward_filtered = signal.convolve(forward_signal_sampled, fir_filter, mode = "same")
reverse_filtered = signal.convolve(reverse_signal_sampled, fir_filter, mode = "same")

"""
plt.xlim(0, 1000)
plt.plot(forward_filtered.real, label = "Forward Real")
plt.plot(forward_filtered.imag, label = "Forward Imag")
plt.plot(reverse_filtered.real, label = "Reverse Real")
plt.plot(reverse_filtered.imag, label = "Reverse Imag")
plt.legend()
plt.show()
"""

# Convert signals to polar. This is done by a CORDIC on the FPGA.
forward_magnitude = np.abs(forward_filtered)
forward_phase = np.angle(forward_filtered)
reverse_magnitude = np.abs(reverse_filtered)
reverse_phase = np.angle(reverse_filtered)

# Reflection coefficient magnitude comes from the ratios of the magnitudes of the forward and reverse signals.
gamma_magnitude = np.mean(forward_magnitude) / np.mean(reverse_magnitude)

# Reflection coefficient phase comes from the difference in phase of the forward and reverse signals. Unwrapping performed by subtracting 2pi when we are outside the 180 deg range. Not 100% sure this works under all conditions.
phase_difference = forward_phase - reverse_phase
phase_difference[phase_difference > math.pi] = phase_difference[phase_difference > math.pi] - 2 * math.pi
gamma_phase = np.mean(phase_difference)

print(f"Calculated reflection coefficient magnitude is {gamma_magnitude:.2f}.")
print(f"Calculated reflection coefficient phase is {gamma_phase * 180 / math.pi:.2f}\N{DEGREE SIGN}.")
