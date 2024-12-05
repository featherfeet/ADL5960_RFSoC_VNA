'''
Functions to handle data and caculate S-parameters from the VNA

VNA Project
Fall 2024
'''

import numpy as np
import math

class VNAfunc:
    def __init__(self, name):
        self.name = name

    def iq_break_data(in_data):
        val = in_data&0xFFFF
        if val >= 32768:
            real = np.int32(0xFFFF0000|val)
        else:
            real = val
        imag = in_data>>16
        return real, imag

    '''
    Caculates the S-parameters of the two given signals
    This caculation must be done to each of the 4 signals to find S11, S12, S21, S22
    '''
    def caculate_S_param (forward_signal, reverse_signal):
        # Convert signals to polar. This is done by a CORDIC on the FPGA.
        forward_magnitude = np.abs(forward_signal)
        forward_phase = np.angle(forward_signal)
        reverse_magnitude = np.abs(reverse_signal)
        reverse_phase = np.angle(reverse_signal)

        # Reflection coefficient magnitude comes from the ratios of the magnitudes of the forward and reverse signals.
        gamma_magnitude = np.mean(forward_magnitude) / np.mean(reverse_magnitude)

        # Reflection coefficient phase comes from the difference in phase of the forward and reverse signals. 
        # Unwrapping performed by subtracting 2pi when we are outside the 180 deg range. Not 100% sure this works under all conditions.
        phase_difference = forward_phase - reverse_phase
        phase_difference[phase_difference > math.pi] = phase_difference[phase_difference > math.pi] - 2 * math.pi
        gamma_phase = np.mean(phase_difference)

        return gamma_magnitude, gamma_phase
    
    def extract_S_param(self, out_buffer):
        # Convert the entire out_buffer into a NumPy array
        out_buffer_np = np.array(out_buffer, dtype=np.int32)  # Assuming `out_buffer` is the raw input array

        # Split into 4 sub-arrays
        out_buffer0 = out_buffer_np[0::4]
        out_buffer1 = out_buffer_np[1::4]
        out_buffer2 = out_buffer_np[2::4]
        out_buffer3 = out_buffer_np[3::4]

        # Process all buffers at once
        real0, imag0 = self.iq_break_data_np(out_buffer0)
        real1, imag1 = self.iq_break_data_np(out_buffer1)
        real2, imag2 = self.iq_break_data_np(out_buffer2)
        real3, imag3 = self.iq_break_data_np(out_buffer3)

        #For caculating the S-parameters combine into complex lists
        array0 = real0 + 1j*imag0 
        array1 = real1 + 1j*imag1
        array2 = real2 + 1j*imag2 
        array3 = real3 + 1j*imag3 

        S11_mag, S11_phase = self.caculate_S_param(array0, array1)
        S12_mag, S12_phase = self.caculate_S_param(array0, array2)
        S21_mag, S21_phase = self.caculate_S_param(array1, array3)
        S22_mag, S22_phase = self.caculate_S_param(array2, array3)
        
        ''' 
        print(f"Calculated S11 magnitude is {S11_mag:.2f}.")
        print(f"Calculated S11 phase is {S11_phase * 180 / math.pi:.2f}\N{DEGREE SIGN}.")
        print(f"Calculated S12 magnitude is {S12_mag:.2f}.")
        print(f"Calculated S12 phase is {S12_phase * 180 / math.pi:.2f}\N{DEGREE SIGN}.")
        print(f"Calculated S21 magnitude is {S21_mag:.2f}.")
        print(f"Calculated S21 phase is {S21_phase * 180 / math.pi:.2f}\N{DEGREE SIGN}.")
        print(f"Calculated S22 magnitude is {S22_mag:.2f}.")
        print(f"Calculated S22 phase is {S22_phase * 180 / math.pi:.2f}\N{DEGREE SIGN}.")
        '''

        return S11_mag, S11_phase, S12_mag, S12_phase, S21_mag, S21_phase, S22_mag, S22_phase

    def iq_break_data_np(in_data):
        # Extract real part
        val = in_data & 0xFFFF
        real = np.where(val >= 32768, np.int32(0xFFFF0000 | val), val)

        # Extract imaginary part
        imag = in_data >> 16
        return real, imag