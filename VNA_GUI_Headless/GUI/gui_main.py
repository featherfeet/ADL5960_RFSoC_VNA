#!/usr/bin/env python3

import sys
import asyncio
from PyQt6 import QtWidgets
from PyQt6.QtWidgets import QApplication, QWidget, QLabel, QRadioButton, QHBoxLayout, QVBoxLayout
import pyqtgraph as pg
import numpy as np
from networking import RemoteConnection

remote_connection = RemoteConnection("0.0.0.0", 1234)

class MainWindow(QWidget):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.setWindowTitle("SusVNA Interface, Copyright 2024 Cruftsight Technologies")

        self.layout = QtWidgets.QGridLayout()
        self.setLayout(self.layout)

        self.mode_label = QLabel("Sweep mode:")
        self.mode_radio_button_zerospan = QtWidgets.QRadioButton("Zero Span")
        self.mode_radio_button_startend = QtWidgets.QRadioButton("Start/End")
        self.mode_radio_button_centerspan = QtWidgets.QRadioButton("Center/Span")
        self.mode_radio_button_zerospan.toggled.connect(self.mode_zerospan)
        self.mode_radio_button_startend.toggled.connect(self.mode_startend)
        self.mode_radio_button_centerspan.toggled.connect(self.mode_centerspan)

        self.plot_widget = pg.PlotWidget()
        self.plot_widget.setXRange(0, 500)
        self.plot_widget.setYRange(-2000, 2000)

        self.filtered_port1_forward_plot = self.plot_widget.plot(pen = 'r')
        self.filtered_port2_forward_plot = self.plot_widget.plot(pen = 'g')
        self.filtered_port1_reverse_plot = self.plot_widget.plot(pen = 'b')
        self.filtered_port2_reverse_plot = self.plot_widget.plot(pen = 'w')

        self.controls_layout = QtWidgets.QGridLayout()

        self.layout.addWidget(self.plot_widget, 0, 0)
        self.layout.addLayout(self.controls_layout, 1, 0)
        self.controls_layout.addWidget(self.mode_label, 0, 0)
        self.controls_layout.addWidget(self.mode_radio_button_zerospan, 0, 1)
        self.controls_layout.addWidget(self.mode_radio_button_startend, 0, 2)
        self.controls_layout.addWidget(self.mode_radio_button_centerspan, 0, 3)

        self.show()

    def mode_zerospan(self):
        if self.mode_radio_button_zerospan.isChecked():
            print("Zero span mode")
            self.zero_span_frequency_label = QtWidgets.QLabel("Frequency:")
            self.zero_span_frequency_label_mhz = QtWidgets.QLabel("MHz")
            self.zero_span_frequency_input = QtWidgets.QLineEdit()
            self.zero_span_layout = QtWidgets.QGridLayout()
            self.zero_span_layout.addWidget(self.zero_span_frequency_label, 0, 0)
            self.zero_span_layout.addWidget(self.zero_span_frequency_input, 0, 1)
            self.zero_span_layout.addWidget(self.zero_span_frequency_label_mhz, 0, 2)
            self.controls_layout.addLayout(self.zero_span_layout, 1, 0)

    def mode_startend(self):
        if self.mode_radio_button_startend.isChecked():
            print("Start/end mode")

    def mode_centerspan(self):
        if self.mode_radio_button_centerspan.isChecked():
            print("Center/span mode")

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()

    while True:
        if len(remote_connection.data.keys()):
            print("Updating data")
            window.filtered_port1_forward_plot.setData(remote_connection.data["filtered_port1_forward"])
            window.filtered_port2_forward_plot.setData(remote_connection.data["filtered_port2_forward"])
            window.filtered_port1_reverse_plot.setData(remote_connection.data["filtered_port1_reverse"])
            window.filtered_port2_reverse_plot.setData(remote_connection.data["filtered_port2_reverse"])
        app.processEvents()
