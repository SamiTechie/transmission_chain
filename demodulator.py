from math import pi,sin,cos
import numpy as np 
from PyQt5.QtCore import pyqtSignal,pyqtSlot,pyqtProperty,QObject
class Modulation(QObject):
    def __init__(self):
        QObject.__init__(self,parent=None)
        self.__code = []
        self.__tm = 0
        self.__out = []
        self.__dsp = []
        self.__f = []
        self.__t = []
        self.__dspCode = []
        self.__bits = []
    @pyqtSlot(list)
    def setBits(self,bits):
        self.__bits = bits
    @pyqtSlot(list)
    def setCode(self,code):
        self.__code = code
    @pyqtSlot(list)
    def setDspCode(self,dsp):
        self.__dspCode = dsp
    @pyqtProperty(list)
    def code(self):
        return self.__code
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
            print(bit)
            arr = bit * np.ones_like(np.arange(0,self.__tm,0.01))
            out.extend(arr)
        return out
    @pyqtSlot(float)
    def ask(self,A = 1):
        tb = self.__tm
        self.__t = np.arange(0,len(self.__bits),0.01)
        fc = 3
        out = np.array(self.__code) * np.cos(2 * pi * fc *self.__t) * A
        self.__t = list(self.__t)
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
