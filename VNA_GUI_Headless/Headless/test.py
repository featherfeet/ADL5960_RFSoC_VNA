import pyqtgraph as pg
import random
from pyqtgraph.Qt import QtGui, QtCore

win = pg.plot()
lin = win.plot(pen = 'r')

while True:
    lin.setData([random.randint(0, 100) for _ in range(100)])
    QtGui.QGuiApplication.processEvents()
