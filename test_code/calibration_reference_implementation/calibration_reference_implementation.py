#!/usr/bin/env python3

"""
Implementation and tests of the "Cal-Acquisition for 12-Term Models" described in 3.3 (page 139) of _Handbook of Microwave Component Measurements_ (2020) by Joel Dunsmore.

Also based on https://coppermountaintech.com/webinar-vna-master-class-full-1-port-vna-calibration-math-with-python-code/
Also see Keysight Application Note "Specifying Calibration Standards and Kits for Keysight Vector Network Analyzers"

Terms:
    DUT - device under test
"""

import math
import skrf as rf
import numpy as np
import matplotlib.pyplot as plt

def generate_short_standard(offset_delay, offset_loss, l0, l1, l2, l3, frequencies):
    """
    Generate S-parameters for a short standard using the standard polynomial approximation given in equation 3.27 of the book. A short standard is modeled as a short lossy transmission line before a small frequency-dependent inductor.

    Also see https://www.minicircuits.com/pdfs/SOL-63-NM+.pdf for the units.

    offset_delay - Delay of the transmission line in ps.
    offset_loss - Loss of the transmission line in GOhm/s
    l0 - First coefficient for inductance in (1e-12 H)
    l1 - Second coefficient for inductance in (1e-24 H)
    l2 - Third coefficient for inductance in (1e-33 H)
    l3 - Fourth coefficient for inductance in  (1e-42 H)
    """
    #loss = (offset_loss * 1e9) * (offset_delay * 1e-12)

    s11_values = []
    for frequency in frequencies.f:
        omega = 2 * math.pi * frequency
        L = (l0 * 1e-12) + (l1 * 1e-24 * frequency) + (l2 * 1e-33 * (frequency ** 2)) + (l3 * 1e-42 * (frequency ** 3))
        inductor_impedance = 1j * omega * L
        reflection_coefficient = (inductor_impedance - 50) / (inductor_impedance + 50)

        delay_phase_shift = omega * (offset_delay * 1e-12)
        reflection_coefficient *= math.e ** (-1j * delay_phase_shift)

        s11_values.append(reflection_coefficient)

    inductor_network = rf.Network(f = frequencies.f, s = s11_values, z0 = 50)
    return inductor_network

def generate_open_standard(offset_delay, offset_loss, c0, c1, c2, c3, frequencies):
    """
    Generate S-parameters for an open standard using the standard polynomial approximation given in equation 3.27 of the book. A open standard is modeled as a short lossy transmission line before a small frequency-dependent capacitor.

    Also see https://www.minicircuits.com/pdfs/SOL-63-NM+.pdf for the units.

    offset_delay - Delay of the transmission line in ps.
    offset_loss - Loss of the transmission line in GOhm/s
    c0 - First coefficient for inductance in (1e-15 H)
    c1 - Second coefficient for inductance in (1e-27 H)
    c2 - Third coefficient for inductance in (1e-36 H)
    c3 - Fourth coefficient for inductance in  (1e-45 H)
    """
    #loss = (offset_loss * 1e9) * (offset_delay * 1e-12)

    s11_values = []
    for frequency in frequencies.f:
        omega = 2 * math.pi * frequency
        C = (c0 * 1e-15) + (c1 * 1e-27 * frequency) + (c2 * 1e-36 * (frequency ** 2)) + (c3 * 1e-45 * (frequency ** 3))
        capacitor_impedance = 1/(1j * omega * C)
        reflection_coefficient = (capacitor_impedance - 50) / (capacitor_impedance + 50)

        delay_phase_shift = omega * (offset_delay * 1e-12)
        reflection_coefficient *= math.e ** (-1j * delay_phase_shift)

        s11_values.append(reflection_coefficient)

    capacitor_network = rf.Network(f = frequencies.f, s = s11_values, z0 = 50)
    return capacitor_network

def generate_load_standard(offset_delay, offset_loss, offset_impedance, frequencies):
    """
    Generate S-parameters for an open standard using the transmission line + resistor model of a load standard.

    offset_delay - Delay of the transmission line in ps.
    offset_loss - Loss of the transmission line in GOhm/s
    offset_impedance - Impedance of the load standard (normally 50 Ohms).
    """

    s11_values = []
    for frequency in frequencies.f:
        if offset_impedance == 50:
            s11_values.append(0)
        else:
            omega = 2 * math.pi * frequency
            reflection_coefficient = (offset_impedance - 50) / (offset_impedance + 50)

            delay_phase_shift = omega * (offset_delay * 1e-12)
            reflection_coefficient *= math.e ** (-1j * delay_phase_shift)

            s11_values.append(reflection_coefficient)

    load_network = rf.Network(f = frequencies.f, s = s11_values, z0 = 50)
    return load_network

dut = rf.Network("VBF-8450+.S2P") # Example DUT, an 8.4 GHz bandpass filter from Mini-Circuits
port1_test_fixture = rf.Network("EQY-0-24+_B1_25C.s2p") # Example test fixture from port 1 of VNA to DUT, equalizer from Mini-Circuits.
port2_test_fixture = rf.Network("QAT-20+_Plus25DegC_B1.s2p") # Example test fixture (cable and other devices) from port 2 of VNA to DUT, 20 dB attenuator from Mini-Circuits.
frequencies = rf.frequency.Frequency(10e6, 15e9, 5000, "Hz")
dut.interpolate_self(frequencies)
port1_test_fixture.interpolate_self(frequencies)
port2_test_fixture.interpolate_self(frequencies)

# Example cal standard parameters from https://www.minicircuits.com/pdfs/SOL-63-NM+.pdf
short_standard_model = generate_short_standard(59.44, 1, 0, 0, 0, 0, frequencies)
open_standard_model = generate_open_standard(59.55, 1, -4, 200, 0, 1.1, frequencies)
load_standard_model = generate_load_standard(0, 0, 50, frequencies)
media = rf.media.DefinedGammaZ0(frequency = frequencies, z0_port = 50)
unknown_through_standard_model = media.attenuator(1, d = 10, units = "ps") # 1 dB attenuator as our unknown-thru standard.

#===================Measure Cal Standards In-System===============================
short_standard_measured_port1 = port1_test_fixture ** short_standard_model
open_standard_measured_port1 = port1_test_fixture ** open_standard_model
load_standard_measured_port1 = port1_test_fixture ** load_standard_model
short_standard_measured_port2 = port2_test_fixture ** short_standard_model
open_standard_measured_port2 = port2_test_fixture ** open_standard_model
load_standard_measured_port2 = port2_test_fixture ** load_standard_model
unknown_through_standard_measured_port1 = port1_test_fixture ** unknown_through_standard_model ** port2_test_fixture
unknown_through_standard_measured_port2 = unknown_through_standard_measured_port1.flipped()

#===================Take Raw Measurements (Test Fixtures + DUT)===================
full_system_measured = port1_test_fixture ** dut ** port2_test_fixture

#===========================Calibration==========================================
ERF_values = np.zeros(len(frequencies.f), dtype = np.complex128)
EDF_values = np.zeros(len(frequencies.f), dtype = np.complex128)
ESF_values = np.zeros(len(frequencies.f), dtype = np.complex128)
ERR_values = np.zeros(len(frequencies.f), dtype = np.complex128)
EDR_values = np.zeros(len(frequencies.f), dtype = np.complex128)
ESR_values = np.zeros(len(frequencies.f), dtype = np.complex128)
ELF_values = np.zeros(len(frequencies.f), dtype = np.complex128)
ELR_values = np.zeros(len(frequencies.f), dtype = np.complex128)
for i in range(len(frequencies.f)):
    # Port 1 single-port cal (open, short, load)
    A = np.array([[1, open_standard_model.s[i][0, 0], open_standard_model.s[i][0, 0] * open_standard_measured_port1.s[i][0, 0]],
                  [1, short_standard_model.s[i][0, 0], short_standard_model.s[i][0, 0] * short_standard_measured_port1.s[i][0, 0]],
                  [1, load_standard_model.s[i][0, 0], load_standard_model.s[i][0, 0] * load_standard_measured_port1.s[i][0, 0]]], dtype = np.complex128)
    B = np.array([[open_standard_measured_port1.s[i][0, 0]],
                  [short_standard_measured_port1.s[i][0, 0]],
                  [load_standard_measured_port1.s[i][0, 0]]], dtype = np.complex128)
    solution = np.linalg.solve(A, B)
    EDF = solution[0, 0]
    ESF = solution[2, 0]
    ERF = solution[1, 0] + EDF * ESF
    ERF_values[i] = ERF
    EDF_values[i] = EDF
    ESF_values[i] = ESF
    # Port 2 single-port cal (open, short, load)
    A = np.array([[1, open_standard_model.s[i][0, 0], open_standard_model.s[i][0, 0] * open_standard_measured_port2.s[i][0, 0]],
                  [1, short_standard_model.s[i][0, 0], short_standard_model.s[i][0, 0] * short_standard_measured_port2.s[i][0, 0]],
                  [1, load_standard_model.s[i][0, 0], load_standard_model.s[i][0, 0] * load_standard_measured_port2.s[i][0, 0]]], dtype = np.complex128)
    B = np.array([[open_standard_measured_port2.s[i][0, 0]],
                  [short_standard_measured_port2.s[i][0, 0]],
                  [load_standard_measured_port2.s[i][0, 0]]], dtype = np.complex128)
    solution = np.linalg.solve(A, B)
    EDR = solution[0, 0]
    ESR = solution[2, 0]
    ERR = solution[1, 0] + EDR * ESR
    ERR_values[i] = ERR
    EDR_values[i] = EDR
    ESR_values[i] = ESR
    # 2-port calibration (unknown-through standard, see 3.4.3.1)
    E22 = ESR # Equation 3.12 for converting 12-term to 8-term model
    E11 = ESF # Equation 3.12 for converting 12-term to 8-term model
    gamma_F = unknown_through_standard_measured_port2.s[i][0, 0] # Fake "switch terms" using S-parameters (we don't actually have a model of an unideal switch in the system right now). Actual FPGA implementation should be able to get these directly by computing gamma_F = a2/b2 with port 1 active and gamma_R = a1/b1 with port 2 active. (see 3.4.1.1)
    gamma_R = unknown_through_standard_measured_port1.s[i][0, 0]
    ELF = E22 + (ERR * gamma_F) / (1 - EDR * gamma_F) # Equation 3.40
    ELR = E11 + (ERF * gamma_R) / (1 - EDF * gamma_R) # Equation 3.40
    ELF_values[i] = ELF
    ELR_values[i] = ELR

#=======================Apply Calibration to Measurements==================
# See 3.2.1.
calibrated_measurement = rf.Network(f = frequencies.f, z0 = 50, s = np.zeros_like(full_system_measured.s))
S11N = (full_system_measured.s[:, 0, 0] - EDF_values) / ERF_values
S21N = full_system_measured.s[:, 1, 0] / ETF_values # Assume EXF crosstalk is zero.
S12N = full_system_measured.s[:, 0, 1] / ETR_values # Assume EXR crosstalk is zero.
S22N = (full_system_measured.s[:, 1, 1] - EDR_values) / ERR_values
calibrated_measurement.s[:, 0, 0] = (S11N * (1 + S22N * ESR_values) - ELF_values * S21N * S12N) / ((1 + S11N * ESF_values) * (1 + S22N * ESR_values) - ELF_values * ELR_values * S21N * S12N)

#if __name__ == "__main__":
    #short_standard.plot_s_smith(m=0,n=0,draw_labels=True,color="red")
    #open_standard.plot_s_smith(m=0,n=0,draw_labels=True,color="red")
    #plt.show()
