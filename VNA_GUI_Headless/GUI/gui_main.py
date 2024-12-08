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

        self.plot_adc_widget = pg.PlotWidget()
        self.plot_adc_widget.setXRange(0, 500)
        self.plot_adc_widget.setYRange(-2000, 2000)

        self.plot_s_param_widget = pg.PlotWidget()
        #self.plot_s_param_widget.setXRange(0, 500) #Need to set frequency range
        self.plot_s_param_widget.setYRange(-200, 10) #Setting top range

        self.filtered_port1_forward_plot = self.plot_adc_widget.plot(pen = 'r')
        self.filtered_port2_forward_plot = self.plot_adc_widget.plot(pen = 'g')
        self.filtered_port1_reverse_plot = self.plot_adc_widget.plot(pen = 'b')
        self.filtered_port2_reverse_plot = self.plot_adc_widget.plot(pen = 'w')

        self.s11_plot = self.plot_s_param_widget.plot(pen = 'r')
        self.s12_plot = self.plot_s_param_widget.plot(pen = 'g')
        self.s21_plot = self.plot_s_param_widget.plot(pen = 'b')
        self.s22_plot = self.plot_s_param_widget.plot(pen = 'w')

        self.mode_label = QLabel("Sweep mode:")
        self.mode_radio_button_zerospan = QtWidgets.QRadioButton("Zero Span")
        self.mode_radio_button_startend = QtWidgets.QRadioButton("Start/End")
        self.mode_radio_button_centerspan = QtWidgets.QRadioButton("Center/Span")
        self.mode_radio_button_zerospan.toggled.connect(self.mode_zerospan)
        self.mode_radio_button_startend.toggled.connect(self.mode_startend)
        self.mode_radio_button_centerspan.toggled.connect(self.mode_centerspan)

        self.short_push_button = QtWidgets.QPushButton("Short Calibrate")
        self.open_push_button = QtWidgets.QPushButton("Open Calibrate")
        self.load_push_button = QtWidgets.QPushButton("Load Calibrate")
        self.short_push_button.clicked.connect(self.cal_short)
        self.open_push_button.clicked.connect(self.cal_open)
        self.load_push_button.clicked.connect(self.cal_load)

        self.cal_layout = QtWidgets.QGridLayout()
        self.cal_layout.addWidget(self.short_push_button, 0, 0)
        self.cal_layout.addWidget(self.open_push_button, 1, 0)
        self.cal_layout.addWidget(self.load_push_button, 2, 0)

        update_button = QtWidgets.QPushButton("Update Output", self)
        update_button.setGeometry(200, 150, 100, 100)
        update_button.clicked.connect(self.update_call)

        self.controls_layout = QtWidgets.QGridLayout()
        self.layout.addWidget(self.plot_adc_widget, 0, 0)
        self.layout.addWidget(self.plot_s_param_widget, 0, 1)
        self.layout.addWidget(update_button, 0, 2)
        self.layout.addLayout(self.cal_layout, 1, 2)
        
        self.layout.addLayout(self.controls_layout, 1, 0)
        self.controls_layout.addWidget(self.mode_label, 0, 0)
        self.controls_layout.addWidget(self.mode_radio_button_zerospan, 0, 1)
        self.controls_layout.addWidget(self.mode_radio_button_startend, 0, 2)
        self.controls_layout.addWidget(self.mode_radio_button_centerspan, 0, 3)
    
        self.show()

    def update_call(self):
        print("pressed")
        #Fill in any call functions to update here
    
    def clear_controls(self):
        """Clear all widgets and layouts from the second row of the controls layout."""
        # Iterate through the layout and remove all items beyond the initial controls
        while self.controls_layout.count() > 4:  # Keep mode selection widgets
            item = self.controls_layout.takeAt(4)  # Index 4 and onward
            if item:
                if item.widget():
                    item.widget().deleteLater()  # Properly delete the widget
                elif item.layout():
                    self.clear_layout(item.layout())  # Clear nested layouts

    def clear_layout(self, layout):
        """Recursively clear all items from a given layout."""
        while layout.count():
            item = layout.takeAt(0)
            if item.widget():
                item.widget().deleteLater()
            elif item.layout():
                self.clear_layout(item.layout())  # Recursively clear nested layouts
    
    def mode_zerospan(self):
        if self.mode_radio_button_zerospan.isChecked():
            print("Zero span mode")
            self.clear_controls()

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
            self.clear_controls()

            self.start_frequency_label = QtWidgets.QLabel("Start Freq:")
            self.start_frequency_label_mhz = QtWidgets.QLabel("MHz")
            self.start_frequency_input = QtWidgets.QLineEdit()

            self.stop_frequency_label = QtWidgets.QLabel("Stop Freq:")
            self.stop_frequency_label_mhz = QtWidgets.QLabel("MHz")
            self.stop_frequency_input = QtWidgets.QLineEdit()

            self.pointspersweep_label = QtWidgets.QLabel("Points Per Sweep:")
            self.pointspersweep_input = QtWidgets.QLineEdit()
            
            self.start_layout = QtWidgets.QGridLayout()
            self.start_layout.addWidget(self.start_frequency_label, 0, 0)
            self.start_layout.addWidget(self.start_frequency_label_mhz, 0, 1)
            self.start_layout.addWidget(self.start_frequency_input, 0, 2)

            self.stop_layout = QtWidgets.QGridLayout()
            self.stop_layout.addWidget(self.stop_frequency_label, 0, 0)
            self.stop_layout.addWidget(self.stop_frequency_label_mhz, 0, 1)
            self.stop_layout.addWidget(self.stop_frequency_input, 0, 2)

            self.pointspersweep_layout = QtWidgets.QGridLayout()
            self.pointspersweep_layout.addWidget(self.pointspersweep_label, 0, 0)
            self.pointspersweep_layout.addWidget(self.pointspersweep_input, 0, 1)
            
            self.controls_layout.addLayout(self.start_layout, 1, 0)
            self.controls_layout.addLayout(self.stop_layout, 2, 0)
            self.controls_layout.addLayout(self.pointspersweep_layout, 3, 0)

    def mode_centerspan(self):
        if self.mode_radio_button_centerspan.isChecked():
            print("Center/span mode")
            self.clear_controls()

            center_frequency_label = QtWidgets.QLabel("Center Freq:")
            center_frequency_label_mhz = QtWidgets.QLabel("MHz")
            center_frequency_input = QtWidgets.QLineEdit()

            span_frequency_label = QtWidgets.QLabel("Span:")
            span_frequency_label_mhz = QtWidgets.QLabel("MHz")
            span_frequency_input = QtWidgets.QLineEdit()

            self.pointspersweep_label = QtWidgets.QLabel("Points Per Sweep:")
            self.pointspersweep_input = QtWidgets.QLineEdit()

            self.center_freq_layout = QtWidgets.QGridLayout()
            self.center_freq_layout.addWidget(center_frequency_label, 1, 0)
            self.center_freq_layout.addWidget(center_frequency_input, 1, 1)
            self.center_freq_layout.addWidget(center_frequency_label_mhz, 1, 2)

            self.span_layout = QtWidgets.QGridLayout()
            self.span_layout.addWidget(span_frequency_label, 2, 0)
            self.span_layout.addWidget(span_frequency_input, 2, 1)
            self.span_layout.addWidget(span_frequency_label_mhz, 2, 2)
            
            self.pointspersweep_layout = QtWidgets.QGridLayout()
            self.pointspersweep_layout.addWidget(self.pointspersweep_label, 0, 0)
            self.pointspersweep_layout.addWidget(self.pointspersweep_input, 0, 1)

            self.controls_layout.addLayout(self.center_freq_layout, 1, 0)
            self.controls_layout.addLayout(self.span_layout, 2, 0)
            self.controls_layout.addLayout(self.pointspersweep_layout, 3, 0)

    def cal_short(self):
        print("Short calibration triggered.")

    def cal_open(self):
        print("Open calibration triggered.")

    def cal_load(self):
        print("Load calibration triggered.")


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.resize(1000, 500)

    while True:
        if len(remote_connection.data.keys()):
            print("Updating data")
            window.filtered_port1_forward_plot.setData(remote_connection.data["filtered_port1_forward"])
            window.filtered_port2_forward_plot.setData(remote_connection.data["filtered_port2_forward"])
            window.filtered_port1_reverse_plot.setData(remote_connection.data["filtered_port1_reverse"])
            window.filtered_port2_reverse_plot.setData(remote_connection.data["filtered_port2_reverse"])


        app.processEvents()
