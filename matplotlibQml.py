import os
from PyQt5.QtQuick import QQuickImageProvider
from PyQt5.QtQml import QQmlImageProviderBase
from PyQt5.QtGui import QImage
from matplotlib.figure import Figure
from PyQt5.QtCore import pyqtSignal
from matplotlib.backends.backend_agg import FigureCanvasAgg


class MatplotLibImage(QQuickImageProvider):
    figures = dict()
    def __init__(self):
        QQuickImageProvider.__init__(self,QQmlImageProviderBase.Image)
    def getFigure(self,name):
        return self.figures.get(name)

    def addFigure(self, name, **kwargs):
        figure = Figure(**kwargs)
        self.figures[name] = figure
        return figure
    def requestImage(self,p_str,size):
        figure = self.getFigure(p_str)
        if figure is None:
            return QQuickImageProvider.requestImage(self, p_str, size)
        canvas = FigureCanvasAgg(figure)
        canvas.draw()
        w, h = canvas.get_width_height()
        img = QImage(canvas.buffer_rgba(), w, h, QImage.Format_RGBA8888).copy()
        return img, img.size()
