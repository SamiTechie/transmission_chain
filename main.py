from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine,qmlRegisterType
from matplotlibQml import MatplotLibImage
from chaineOfTransmission import ChaineTransmission
from algorithms.linecode import LineCode
from algorithms.filtreemission import FiltreEmission
from algorithms.modulation import Modulation
from algorithms.bruit import Bruit
from algorithms.demodulator import DeModulation
from algorithms.filtrereception import Filtrereceiption
from algorithms.decision import Decision
from algorithms.horloge import Horloge
from algorithms.output import Output
import numpy as np
import matplotlib.pyplot as plt
from plot import Plot
import sys

chainTransm = ChaineTransmission()
lineCode = LineCode()
filtreEmission = FiltreEmission()
modulation = Modulation()
bruit = Bruit()
deModulation = DeModulation()
filtreReception = Filtrereceiption()
horloge = Horloge()
decision = Decision()
output = Output()


imageProvider = MatplotLibImage()

plot = Plot(imageProvider)
plot.add_plot(1)
plot.add_plot(2)


app =QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()
engine.rootContext().setContextProperty("Chaine",chainTransm)
engine.rootContext().setContextProperty("filtre",filtreEmission)
engine.rootContext().setContextProperty("lineCode",lineCode)
engine.rootContext().setContextProperty("modulation",modulation)
engine.rootContext().setContextProperty("bruit",bruit)
engine.rootContext().setContextProperty("demodulation",deModulation)
engine.rootContext().setContextProperty("filtreReception",filtreReception)
engine.rootContext().setContextProperty("horloge",horloge)
engine.rootContext().setContextProperty("decision",decision)
engine.rootContext().setContextProperty("output",output)

engine.addImageProvider('perflog',imageProvider)
engine.rootContext().setContextProperty("plt",plot)
engine.load("main.qml")
app.exec()
