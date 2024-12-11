#!/usr/bin/env python3

import sys
import asyncio
from PyQt6 import QtWidgets
from PyQt6.QtWidgets import QApplication, QWidget, QLabel, QRadioButton, QHBoxLayout, QVBoxLayout
from PyQt6.QtGui import QFont, QIntValidator
from PyQt6.QtCore import Qt
import pyqtgraph as pg
import numpy as np
from networking import RemoteConnection
import skrf as rf
from skrf import Network
from matplotlib import pyplot as plt
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg
from matplotlib.figure import Figure


remote_connection = RemoteConnection("0.0.0.0", 1234)

class MainWindow(QWidget):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.setWindowTitle("SusVNA Interface, Copyright 2024 Cruftsight Technologies")

        self.layout = QtWidgets.QGridLayout()
        self.setLayout(self.layout)

        '''
        Smith Chart Plot Testing
        '''
        #Initialize figure with matplotlib canvas
        self.smith_chart_fig = self.MplCanvas(self, width=100, height=100, dpi=100)
        #Initalize network object
        self.smith_network = Network()
        #Start plot that is tied to the subfigure 
        self.smith_fig_object = rf.plotting.plot_smith(
                                s = self.smith_network,
                                ax = self.smith_chart_fig.axes, 
                                draw_labels = True, 
                                ref_imm = 50.0, 
                                chart_type = 'z')
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
        #Object line to update 
        self.smith_network = rf_network_object
        self.smith_chart_fig.draw() #redraw canvas
        
if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.resize(1000, 500)

    while True:
        if len(remote_connection.data.keys()):
            #S-paramters Plot
            raw_s_parameters = remote_connection.data["raw_s_parameters"]

            #Smith chart Plot
            rf_network_object = raw_s_parameters #how to unpickle? 
            window.update_smith(rf_network_object)

        app.processEvents()
