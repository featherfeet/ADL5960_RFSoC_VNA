#!/usr/bin/env python3

"""
Implementation and tests of the "Cal-Acquisition for 12-Term Models" described in 3.3 (page 139) of _Handbook of Microwave Component Measurements_ (2020) by Joel Dunsmore.

Terms:
    DUT - device under test
"""

import math
import skrf as rf

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
    loss = (offset_loss * 1e9) * (offset_delay * 1e-12)
    #media = rf.media.DefinedGammaZ0(frequency = frequencies)
    #delay_line = media.line(offset_delay, unit = "ps", z0 = 50 + loss * 1j)

    s11_values = []
    for frequency in frequencies.f:
        omega = 2 * math.pi * frequency
        L = (l0 * 1e-12) + (l1 * 1e-24 * frequency) + (l2 * 1e-33 * (frequency ** 2)) + (l3 * 1e-42 * (frequency ** 3))
        inductor_impedance = 1j * omega * L
        reflection_coefficient = (inductor_impedance - 50) / (inductor_impedance + 50)
        s11_values.append(reflection_coefficient)

    inductor_network = rf.Network(f = frequencies.f, s = s11_values, z0 = 50)
    #return delay_line ** inductor_network
    return inductor_network

def generate_open_standard(offset_delay, offset_loss, c0, c1, c2, c3, frequencies):
    """
    Generate S-parameters for a open standard using the standard polynomial approximation given in equation 3.27 of the book. A open standard is modeled as a short lossy transmission line before a small frequency-dependent capacitor.

    Also see https://www.minicircuits.com/pdfs/SOL-63-NM+.pdf for the units.

    offset_delay - Delay of the transmission line in ps.
    offset_loss - Loss of the transmission line in GOhm/s
    c0 - First coefficient for inductance in (1e-15 H)
    c1 - Second coefficient for inductance in (1e-27 H)
    c2 - Third coefficient for inductance in (1e-36 H)
    c3 - Fourth coefficient for inductance in  (1e-45 H)
    """
    loss = (offset_loss * 1e9) * (offset_delay * 1e-12)
    media = rf.media.DefinedGammaZ0(frequency = frequencies)
    #delay_line = media.line(offset_delay, unit = "ps", z0 = 50 + loss * 1j)

    s11_values = []
    for frequency in frequencies.f:
        omega = 2 * math.pi * frequency
        C = (c0 * 1e-15) + (c1 * 1e-27 * frequency) + (c2 * 1e-36 * (frequency ** 2)) + (c3 * 1e-45 * (frequency ** 3))
        capacitor_impedance = 1/(1j * omega * C)
        reflection_coefficient = (capacitor_impedance - 50) / (capacitor_impedance + 50)
        s11_values.append(reflection_coefficient)

    capacitor_network = rf.Network(f = frequencies.f, s = s11_values, z0 = 50)
    #return delay_line ** capacitor_network
    return capacitor_network

dut = rf.Network("VBF-8450+.S2P") # Example DUT, an 8.4 GHz bandpass filter from Mini-Circuits
port1_test_fixture = rf.Network("EQY-0-24+_B1_25C.s2p") # Example test fixture from port 1 of VNA to DUT, equalizer from Mini-Circuits.
port2_test_fixture = rf.Network("QAT-20+_Plus25DegC_B1.s2p") # Example test fixture (cable and other devices) from port 2 of VNA to DUT, 20 dB attenuator from Mini-Circuits.
frequencies = rf.frequency.Frequency(10e6, 20e6, 5000, "Hz")
dut.interpolate_self(frequencies)
port1_test_fixture.interpolate_self(frequencies)
port2_test_fixture.interpolate_self(frequencies)

short_standard = generate_short_standard(59.44, 1, 0, 0, 0, 0, frequencies)
open_standard = generate_open_standard(59.55, 1, -4, 200, 0, 1.1, frequencies)

#===================Take Raw Measurements (Test Fixtures + DUT)===================
full_system = port1_test_fixture ** dut ** port2_test_fixture
