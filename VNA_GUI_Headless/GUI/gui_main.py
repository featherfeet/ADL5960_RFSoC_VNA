#!/usr/bin/env python3

import sys
import asyncio
from PyQt6 import QtWidgets
from PyQt6.QtWidgets import QApplication, QWidget, QLabel, QRadioButton, QHBoxLayout, QVBoxLayout
from PyQt6.QtGui import QFont
from PyQt6.QtCore import Qt
import pyqtgraph as pg
import numpy as np
from networking import RemoteConnection
import skrf as rf

remote_connection = RemoteConnection("0.0.0.0", 1234)

class MainWindow(QWidget):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.setWindowTitle("SusVNA Interface, Copyright 2024 Cruftsight Technologies")

        self.layout = QtWidgets.QGridLayout()
        self.setLayout(self.layout)

        '''
        Header Layout
        '''
        self.title_label = QLabel("SusVNA Interface")
        title_font = QFont()
        title_font.setPointSize(20)
        title_font.setBold(True)
        self.title_label.setFont(title_font)
        self.title_label.setAlignment(Qt.AlignmentFlag.AlignHCenter)

        self.subtitle_label = QLabel("Copyright 2024 Cruftsight Technologies")
        layout_font = QFont()
        layout_font.setPointSize(10)
        layout_font.setBold(False)
        self.subtitle_label.setAlignment(Qt.AlignmentFlag.AlignHCenter)

        self.title_layout = QtWidgets.QGridLayout()
        self.title_layout.addWidget(self.title_label)
        self.title_layout.addWidget(self.subtitle_label)

        '''
        Plot Layout
        '''
        self.plot_adc_widget = pg.PlotWidget()
        self.plot_adc_widget.setXRange(0, 500)
        self.plot_adc_widget.setYRange(-8000, 8000)
        self.plot_adc_widget.setLabel("left", "ADC Value")
        self.plot_adc_widget.setLabel("bottom", "Time")
        self.plot_adc_widget.setTitle("Live ADC Values", size="10pt")
        
        self.plot_s_param_widget = pg.PlotWidget()
        self.plot_s_param_widget.setYRange(-80, 20) #Setting top range
        self.plot_s_param_widget.setLabel("left", "S Parameter")
        self.plot_s_param_widget.setLabel("bottom", "Freq (MHz)")
        self.plot_s_param_widget.setTitle("Live S-Parameters", size="10pt")

        self.plot_adc_widget.addLegend()
        self.filtered_port1_forward_plot = self.plot_adc_widget.plot(pen = 'r', name = "Port 1 Forward")
        self.filtered_port2_forward_plot = self.plot_adc_widget.plot(pen = 'g', name = "Port 2 Forward")
        self.filtered_port1_reverse_plot = self.plot_adc_widget.plot(pen = 'b', name = "Port 1 Reverse")
        self.filtered_port2_reverse_plot = self.plot_adc_widget.plot(pen = 'w', name = "Port 2 Reverse")

        self.plot_s_param_widget.addLegend()
        self.s11_plot = self.plot_s_param_widget.plot(pen = 'r', name = "S11")
        self.s12_plot = self.plot_s_param_widget.plot(pen = 'g', name = "S12")
        self.s21_plot = self.plot_s_param_widget.plot(pen = 'b', name = "S21")
        self.s22_plot = self.plot_s_param_widget.plot(pen = 'w', name = "S22")

        self.plot_layout = QtWidgets.QGridLayout()
        self.plot_layout.addWidget(self.plot_adc_widget, 0, 0)
        self.plot_layout.addWidget(self.plot_s_param_widget, 0, 1)

        '''
        Source Controls
        '''
        self.mode_label = QLabel("Sweep mode:")
        self.mode_radio_button_zerospan = QtWidgets.QRadioButton("Zero Span")
        self.mode_radio_button_startend = QtWidgets.QRadioButton("Start/End")
        self.mode_radio_button_centerspan = QtWidgets.QRadioButton("Center/Span")
        self.mode_radio_button_zerospan.toggled.connect(self.mode_zerospan)
        self.mode_radio_button_startend.toggled.connect(self.mode_startend)
        self.mode_radio_button_centerspan.toggled.connect(self.mode_centerspan)

        self.controls_layout = QtWidgets.QGridLayout()
        self.controls_layout.addWidget(self.mode_label, 0, 0)
        self.controls_layout.addWidget(self.mode_radio_button_zerospan, 0, 1)
        self.controls_layout.addWidget(self.mode_radio_button_startend, 0, 2)
        self.controls_layout.addWidget(self.mode_radio_button_centerspan, 0, 3)
    
        '''
        Cal Controls Layout
        '''
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

        '''
        Update Button Layout
        '''
        update_button = QtWidgets.QPushButton("Update Output", self)
        update_button.setGeometry(200, 150, 100, 100)
        update_button.clicked.connect(self.update_call)
        
        '''
        Final Layout
        '''
        self.layout.addLayout(self.title_layout, 0, 0)
        self.layout.addLayout(self.plot_layout, 1, 0)
        self.layout.addWidget(update_button, 1, 2)
        self.layout.addLayout(self.cal_layout, 2, 2)
        self.layout.addLayout(self.controls_layout, 2, 0)

        self.show()

    def update_call(self):
        if self.mode_radio_button_zerospan.isChecked():
            parameter_list = {
                "type" : "parameters",
                "single_freq": float(self.zero_span_frequency_input.text()),
                "start": None,
                "stop": None,
                "center": None,
                "span": None,
                "resolution": 1
            }
        elif self.mode_radio_button_startend.isChecked():
            parameter_list = {
                "type" : "parameters",
                "single_freq": None,
                "start": float(self.start_frequency_input.text()),
                "stop": float(self.stop_frequency_input.text()),
                "center": None,
                "span": None,
                "resolution": int(self.pointspersweep_input.text())
            }
        elif self.mode_radio_button_centerspan.isChecked():
            parameter_list = {
                "type" : "parameters",
                "start": None,
                "stop": None,
                "center": float(self.center_frequency_input.text()),
                "span": float(self.span_frequency_input.text()),
                "resolution": int(self.pointspersweep_input.text())
            }
        else:
            parameter_list = {
                "type" : "parameters",
                "start": None,
                "stop": None,
                "center": None,
                "span": None,
                "resolution": None
            }
        
        remote_connection.send_parameters(parameter_list)
    
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
            self.start_layout.addWidget(self.start_frequency_input, 0, 1)
            self.start_layout.addWidget(self.start_frequency_label_mhz, 0, 2)

            self.stop_layout = QtWidgets.QGridLayout()
            self.stop_layout.addWidget(self.stop_frequency_label, 0, 0)
            self.stop_layout.addWidget(self.stop_frequency_input, 0, 2)
            self.stop_layout.addWidget(self.stop_frequency_label_mhz, 0, 1)

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

            self.center_frequency_label = QtWidgets.QLabel("Center Freq:")
            self.center_frequency_label_mhz = QtWidgets.QLabel("MHz")
            self.center_frequency_input = QtWidgets.QLineEdit()

            self.span_frequency_label = QtWidgets.QLabel("Span:")
            self.span_frequency_label_mhz = QtWidgets.QLabel("MHz")
            self.span_frequency_input = QtWidgets.QLineEdit()

            self.pointspersweep_label = QtWidgets.QLabel("Points Per Sweep:")
            self.pointspersweep_input = QtWidgets.QLineEdit()

            self.center_freq_layout = QtWidgets.QGridLayout()
            self.center_freq_layout.addWidget(self.center_frequency_label, 1, 0)
            self.center_freq_layout.addWidget(self.center_frequency_input, 1, 1)
            self.center_freq_layout.addWidget(self.center_frequency_label_mhz, 1, 2)

            self.span_layout = QtWidgets.QGridLayout()
            self.span_layout.addWidget(self.span_frequency_label, 2, 0)
            self.span_layout.addWidget(self.span_frequency_input, 2, 1)
            self.span_layout.addWidget(self.span_frequency_label_mhz, 2, 2)
            
            self.pointspersweep_layout = QtWidgets.QGridLayout()
            self.pointspersweep_layout.addWidget(self.pointspersweep_label, 0, 0)
            self.pointspersweep_layout.addWidget(self.pointspersweep_input, 0, 1)

            self.controls_layout.addLayout(self.center_freq_layout, 1, 0)
            self.controls_layout.addLayout(self.span_layout, 2, 0)
            self.controls_layout.addLayout(self.pointspersweep_layout, 3, 0)

    def cal_short(self):
        print("Short calibration triggered.")
        parameter_list = {
                "type" : "calibration",
                "short": 1,
                "open": 0,
                "load": 0
            }
        remote_connection.send_parameters(parameter_list)

    def cal_open(self):
        print("Open calibration triggered.")
        parameter_list = {
                "type" : "calibration",
                "short": 0,
                "open": 1,
                "load": 0
            }
        remote_connection.send_parameters(parameter_list)

    def cal_load(self):
        print("Load calibration triggered.")
        parameter_list = {
                "type" : "calibration",
                "short": 0,
                "open": 0,
                "load": 1
            }
        remote_connection.send_parameters(parameter_list)

def mag_db(s_param):
    values = s_param.s[:,0,0]
    mag_db = np.zeros(values.shape, dtype = np.float64)
    mag_db[values == 0] = float("Inf")
    mag_db[values != 0] = 20 * np.log10(np.abs(values[values != 0]))
    return mag_db

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.resize(1000, 500)

    while True:
        if len(remote_connection.data.keys()):
            window.filtered_port1_forward_plot.setData(remote_connection.data["filtered_port1_forward"])
            window.filtered_port2_forward_plot.setData(remote_connection.data["filtered_port2_forward"])
            window.filtered_port1_reverse_plot.setData(remote_connection.data["filtered_port1_reverse"])
            window.filtered_port2_reverse_plot.setData(remote_connection.data["filtered_port2_reverse"])
            raw_s_parameters = remote_connection.data["raw_s_parameters"]
            window.plot_s_param_widget.setXRange(raw_s_parameters.f[0], raw_s_parameters.f[-1])
            window.s11_plot.setData(raw_s_parameters.f, mag_db(raw_s_parameters.s11))
            window.s12_plot.setData(raw_s_parameters.f, mag_db(raw_s_parameters.s12))
            window.s21_plot.setData(raw_s_parameters.f, mag_db(raw_s_parameters.s21))
            window.s22_plot.setData(raw_s_parameters.f, mag_db(raw_s_parameters.s22))

        app.processEvents()
