#!/usr/bin/env python3

import sys
import asyncio
from PyQt6 import QtWidgets
from PyQt6.QtWidgets import QApplication, QWidget, QLabel, QRadioButton, QHBoxLayout, QVBoxLayout
from PyQt6.QtGui import QFont, QIntValidator
from PyQt6.QtCore import Qt
import pyqtgraph as pg
import numpy as np
import skrf as rf
from skrf import Network
from matplotlib import pyplot as plt
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg
from matplotlib.figure import Figure
from time import sleep

from time import sleep

from pathlib import Path
import os

import matplotlib.pyplot as plt
import numpy as np

import skrf as rf
rf.stylely()

import os

# Get the path of the current file


class MainWindow(QWidget):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.setWindowTitle("SusVNA Interface, Copyright 2024 Cruftsight Technologies")

        self.layout = QtWidgets.QGridLayout()
        self.setLayout(self.layout)

        '''
        Smith Chart Plot Testing
        '''
        self.smith_chart_fig = self.MplCanvas(self, width=100, height=100, dpi=100) #Initialize figure with matplotlib canvas
        self.smith_fig_object = rf.plotting.smith(ax = self.smith_chart_fig.axes, draw_labels = True, ref_imm = 50.0, chart_type = 'z')
        self.smith_layout = QtWidgets.QGridLayout()
        self.smith_layout.addWidget(self.smith_chart_fig)

        self.layout.addLayout(self.smith_layout, 0, 0)
        self.show()

    class MplCanvas(FigureCanvasQTAgg):
        def __init__(self, parent=None, width=5, height=4, dpi=100):
            fig = Figure(figsize=(width, height), dpi=dpi)
            self.axes = fig.add_subplot(111)
            super().__init__(fig)

    def update_smith(self, rf_network_object):
        self.smith_chart_fig.axes.clear()
        self.smith_fig_object = rf_network_object.plot_s_smith(ax = self.smith_chart_fig.axes)
        self.smith_chart_fig.draw() #redraw canvas

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.resize(1000, 500)
    print(os.getcwd())

    current_file_path = __file__
    print("Current file path:", current_file_path)

    # To get the absolute path
    absolute_path = os.path.abspath(__file__)
    print("Absolute file path:", absolute_path)

    while True:
        app.processEvents()

        for k in range(10):
            if (k % 2 == 1):
                ns = rf.Network('/Users/tklouie/6205_python/ADL5960_RFSoC_VNA/test_code/vna_gui/notebooks/tmp/2024.12.10.15.06.24.240248.s1p')
            else:
                ns = rf.Network('/Users/tklouie/6205_python/ADL5960_RFSoC_VNA/test_code/vna_gui/notebooks/tmp/2024.12.10.15.06.24.024716.s1p')

            #sleep(1)

            window.update_smith(ns)

            app.processEvents()

        

    
