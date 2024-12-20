#!/usr/bin/env python3

import pickle
import skrf as rf
import numpy as np
import matplotlib.pyplot as plt

bandpass = pickle.load(open("raw_s_parameters_bandpass.pickle", "rb"))
bandpass.f *= 1e6
bandpass_reference = rf.Network("../../data_capture/example_data_librevna/ZABP-587-S+.s2p")
measured_standards = pickle.load(open("measured_standards.pickle", "rb"))
for standard in measured_standards.keys():
    measured_standards[standard].f *= 1e6
switch_terms = pickle.load(open("switch_terms.pickle", "rb"))
for standard in switch_terms.keys():
    switch_terms[standard].f *= 1e6
freqs = measured_standards["short"].f
num_pts = len(freqs)

ideal_short = rf.Network(s = np.zeros((num_pts, 2, 2), dtype = np.complex128), f = freqs)
ideal_open = rf.Network(s = np.zeros((num_pts, 2, 2), dtype = np.complex128), f = freqs)
ideal_load = rf.Network(s = np.zeros((num_pts, 2, 2), dtype = np.complex128), f = freqs)
ideal_thru = rf.Network(s = np.zeros((num_pts, 2, 2), dtype = np.complex128), f = freqs)

for i in range(num_pts):
    ideal_short.s[i, 0, 0] = -1
    ideal_short.s[i, 1, 1] = -1
    ideal_open.s[i, 0, 0] = 1
    ideal_open.s[i, 1, 1] = 1
    ideal_load.s[i, 0, 0] = 0
    ideal_load.s[i, 1, 1] = 0
    ideal_thru.s[i, 0, 1] = 1
    ideal_thru.s[i, 1, 0] = 1

#cal = rf.calibration.EightTerm([measured_standards["short"], measured_standards["open"], measured_standards["load"], measured_standards["thru"]], [ideal_short, ideal_open, ideal_load, ideal_thru], switch_terms = [switch_terms["forward"], switch_terms["reverse"]])
cal = rf.calibration.SOLT(ideals = [ideal_short[1:], ideal_open[1:], ideal_load[1:], ideal_thru[1:]], measured = [measured_standards["short"][1:], measured_standards["open"][1:], measured_standards["load"][1:], measured_standards["thru"][1:]])
cal.run()

bandpass_calibrated = cal.apply_cal(bandpass[1:])

#bandpass_reference.plot_s_db(0, 0, label = "Calibrated LibreVNA")
bandpass_calibrated.plot_s_db(1, 1, label = "Calibrated RFSoC VNA")
bandpass.plot_s_db(1, 1, label = "Raw RFSoC VNA")
plt.title("S22 vs Frequency, RFSoC VNA Measuring Cavity Bandpass")
plt.show()
