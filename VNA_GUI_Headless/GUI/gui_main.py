#!/usr/bin/env python3

import asyncio
from PyQt6 import QtWidgets
from PyQt6.QtWidgets import QLabel, QRadioButton
import pyqtgraph as pg
import numpy as np
import io
import pickle
import threading
import socket

data = {}

def socket_thread():
    global data

    packet_length = None
    buffer = io.BytesIO()

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind(("0.0.0.0", 1234))
    s.listen()

    while True:
        conn, addr = s.accept()
        print(f"Accepted connection from {addr}.")

        while True:
            if packet_length == None:
                received = conn.recv(4)
                if len(received) == 0:
                    break
                packet_length = int.from_bytes(received, byteorder = "little")
            else:
                received = conn.recv(4096)
                if len(received) == 0:
                    break
                buffer.write(received)
                if buffer.getbuffer().nbytes == packet_length:
                    buffer.seek(0)
                    data_unpickled = pickle.load(buffer)
                    data_tmp = {}
                    data_tmp["filtered_port1_forward"] = np.frombuffer(data_unpickled["filtered_port1_forward"], dtype = np.float64)
                    data_tmp["filtered_port2_forward"] = np.frombuffer(data_unpickled["filtered_port2_forward"], dtype = np.float64)
                    data_tmp["filtered_port1_reverse"] = np.frombuffer(data_unpickled["filtered_port1_reverse"], dtype = np.float64)
                    data_tmp["filtered_port2_reverse"] = np.frombuffer(data_unpickled["filtered_port2_reverse"], dtype = np.float64)
                    data = data_tmp

                    buffer = io.BytesIO()
                    packet_length = None

        print(f"Connection from {addr} closed.")
        packet_length = None
        buffer = io.BytesIO()

socket_thread_handle = threading.Thread(target = socket_thread, args = ())
socket_thread_handle.start()

app = QtWidgets.QApplication([])
top_level_widget = QtWidgets.QWidget()
top_level_widget.setWindowTitle("SusVNA Interface, Copyright 2024 Cruftsight Technologies")

mode_label = QLabel("Sweep mode:")
mode_radio_button_zerospan = QtWidgets.QRadioButton("Zero Span")
mode_radio_button_startend = QtWidgets.QRadioButton("Start/End")
mode_radio_button_centerspan = QtWidgets.QRadioButton("Center/Span")

plot_widget = pg.PlotWidget()
filtered_port1_forward_plot = plot_widget.plot(pen = 'r')
filtered_port2_forward_plot = plot_widget.plot(pen = 'g')
filtered_port1_reverse_plot = plot_widget.plot(pen = 'b')
filtered_port2_reverse_plot = plot_widget.plot(pen = 'w')

layout = QtWidgets.QGridLayout()
top_level_widget.setLayout(layout)

controls_layout = QtWidgets.QGridLayout()

layout.addWidget(plot_widget, 0, 0)
layout.addLayout(controls_layout, 1, 0)
controls_layout.addWidget(mode_label, 0, 0)
controls_layout.addWidget(mode_radio_button_zerospan, 0, 1)
controls_layout.addWidget(mode_radio_button_startend, 0, 2)
controls_layout.addWidget(mode_radio_button_centerspan, 0, 3)

top_level_widget.show()

SAMPLE_RATE = 147.456e6
DISPLAY_TIME_WINDOW = 3e-6
DISPLAY_SAMPLES = DISPLAY_TIME_WINDOW * SAMPLE_RATE

plot_widget.setXRange(0, 500)
plot_widget.setYRange(-2000, 2000)

while True:
    if len(data.keys()):
        print("Updating data")
        filtered_port1_forward_plot.setData(data["filtered_port1_forward"])
        filtered_port2_forward_plot.setData(data["filtered_port2_forward"])
        filtered_port1_reverse_plot.setData(data["filtered_port1_reverse"])
        filtered_port2_reverse_plot.setData(data["filtered_port2_reverse"])
        #data["filtered_port2_forward"].real
        #data["filtered_port1_reverse"].real
        #data["filtered_port2_reverse"].real
    app.processEvents()
