from math import pi,sin,cos
import numpy as np 
from PyQt5.QtCore import pyqtSignal,pyqtSlot,pyqtProperty,QObject
import scipy.signal as sg

class DeModulation(QObject):
    def __init__(self):
        QObject.__init__(self,parent=None)
        self.__signal = []
        self.__tm = 0
        self.__out = []
        self.__mod = "ASK"
        self.__dsp = []
        self.__f = []
        self.__bruit = []
        self.__t = []
        self.__A = 1
        self.__fc = 2
        self.__phase = 0
        self.__dspCode = []
        self.__bits = []
    def lowPassFiltr(self):
        t = np.arange(-len(self.__bits) /2,len(self.__bits)/2,0.01)
        return np.sin(2*pi*self.__fc * t)(pi * t)
    @pyqtSlot(float)
    def setA(self,A):
        self.__A = A
    @pyqtSlot(list)
    def setBits(self,bits):
        self.__bits = bits
    @pyqtSlot(list)
    def setSignal(self,signal):
        self.__signal = signal
    @pyqtProperty(list)
    def signal(self):
        return self.__signal
    @pyqtSlot(list)
    def setBruit(self,bruit):
        self.__bruit = bruit
    @pyqtSlot(float)
    def setTm(self,tm):
        self.__tm = tm
    @pyqtProperty(list)
    def out(self):
        return self.__out
    @pyqtProperty(list)
    def t(self):
        return self.__t
    @pyqtProperty(list)
    def dsp(self):
        return self.__dsp
    @pyqtProperty(list)
    def f(self):
        return self.__f
    def rect(self):
        out = []
        for bit in self.__code:
            arr = bit * np.ones_like(np.arange(0,self.__tm,0.01))
            out.extend(arr)
        return out
    @pyqtSlot(float)
    def ask(self,A = 1):
        self.__t = np.arange(0,len(self.__bits),0.01)
        self.__signal = [v if v > 0 else 0 for v in self.__signal]
        self.__bruit = [v if v > 0 else 0 for v in self.__bruit]
        self.__bruit = 0
        pas = 0.02
        T = 0.01
        cp =0 
        cn =0 
        out = []
        """
        while cp < len(self.__t):
            cn =cp + 3
            out.extend(np.ones_like(np.arange(0,pas,T)) * max(self.__signal[cp:cn]))
            cp =cn
        """
        while cp < len(self.__t):
            cn =cp + 5
            out.append(max(self.__signal[cp:cn]))
            cp =cn
        #self.__out = list(self.low_pass_filter(self.__out)**2) 
        #self.__out = [v*2 if v <= 0.5 else v for v in self.__out]
        self.__t = list(self.__t)
        #self.__out = list(out[:len(self.__t)] - np.array(self.__bruit))
        self.__out = list(out)
    @pyqtSlot(float)
    def bpsk(self,phase = 0):
        tb = self.__tm
        self.__t = np.arange(0,len(self.__bits),0.01)
        fc = 2
        out = np.array(self.__code) * np.cos(2 * pi * fc *self.__t + phase)
        self.__t = list(self.__t)
        self.__out = list(out)
    @pyqtSlot(float)
    def fsk2(self,fc = 0):
        tb = self.__tm
        self.__t = np.arange(0,len(self.__bits),0.01)
        out = np.array(self.__code * np.cos(2 * pi * fc *self.__t))
        self.__t = list(self.__t)
        self.__out = list(out)
    @pyqtSlot()
    def demodulator(self):
        self.__out = list(self.__signal + np.array(self.__bruit))

