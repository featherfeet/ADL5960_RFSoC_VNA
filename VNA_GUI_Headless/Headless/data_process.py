'''
Functions to handle data and caculate S-parameters from the VNA

VNA Project
Fall 2024
'''

import math
import numpy as np
from scipy import signal

def polar_to_rectangular(magnitude, angle):
    return magnitude * np.exp(1j * angle)

class DSP:
    def __init__(self, if_bandwidth = 10e3):
        self.fir_filter = signal.firwin(15, [1e6 - if_bandwidth / 2, 1e6 + if_bandwidth / 2], fs = 147.456e6, pass_zero = False)

    def binary_to_complex(self, in_data):
        # Extract real part
        val = in_data & 0xFFFF
        real = np.where(val >= 32768, np.int32(0xFFFF0000 | val), val)

        # Extract imaginary part
        imag = in_data >> 16
        return real + 1j * imag

    def filter(self, signal_complex):
        signal_complex = signal_complex[0:5000]
        return signal.convolve(signal_complex, self.fir_filter, mode = "same")

    '''
    Caculates the S-parameters of the two given signals
    This caculation must be done to each of the 4 signals to find S11, S12, S21, S22
    '''
    def calculate_S_param(self, forward_signal, reverse_signal):
        # Convert signals to polar. This is done by a CORDIC on the FPGA.
        forward_magnitude = np.abs(forward_signal)
        forward_phase = np.angle(forward_signal)
        reverse_magnitude = np.abs(reverse_signal)
        reverse_phase = np.angle(reverse_signal)

        # Reflection coefficient magnitude comes from the ratios of the magnitudes of the forward and reverse signals.
        gamma_magnitude = np.mean(reverse_magnitude) / np.mean(forward_magnitude)

        # Reflection coefficient phase comes from the difference in phase of the forward and reverse signals. 
        # Unwrapping performed by subtracting 2pi when we are outside the 180 deg range. Not 100% sure this works under all conditions.
        phase_difference = reverse_phase - forward_phase
        phase_difference[phase_difference > 2 * math.pi] = phase_difference[phase_difference > 2 * math.pi] - 2 * math.pi
        gamma_phase = np.mean(phase_difference)

        return gamma_magnitude, gamma_phase
