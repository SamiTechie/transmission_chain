from PyQt5.QtCore import pyqtSignal, pyqtSlot
import numpy as np

class ChaineTransmission:
    def __init__(self):
        self.ip = [0,0,0,0,0]
        self.encoder = []
        self.TS = 1
    def setIp(data):
        ip = data
    ######### Les codeeur en ligne #########
    def nrz(self):
        clk = []
        for i in self.ip:
            if i == 0:
                clk.append(1)
                clk.append(-1)
            elif i == 1:
                clk.append(-1)
                clk.append(1)
        clk.append(clk[-1])
        self.encoder = clk
        self.T = 1
    def rz(self):
        clk = []
        for i in self.ip:
            if i == 0:
                clk.append(0)
                clk.append(0)
            elif i == 1:
                clk.append(1)
                clk.append(0)
        clk.append(clk[-1])
        self.encoder = clk
        self.T = 0.5
    def manchester(self):
        clk = []
        for i in self.ip:
            if(i == 0):
                clk.append(1)
                clk.append(-1)
            elif(i == 1):
                clk.append(-1)
                clk.append(1)
            else:
                return None
        clk.append(clk[-1])
        self.encoder = clk
        self.T = 0.5
