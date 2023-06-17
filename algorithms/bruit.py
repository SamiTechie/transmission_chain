from math import pi,sin,cos
import numpy as np 
from PyQt5.QtCore import pyqtSignal,pyqtSlot,pyqtProperty,QObject
from random import Random
class Bruit(QObject):
    def __init__(self):
        QObject.__init__(self,parent=None)
        self.__code = []
        self.__tm = 0
        self.__out = []
        self.__dsp = []
        self.__f = []
        self.__bits = []
        self.__mod = []
        self.__t = []
        self.__bruit = []
        self.__dspCode = []
        self.__var = 0
    @pyqtSlot(float)
    def setVar(self,var):
        self.__var = var
    @pyqtSlot(list)
    def setMod(self,mod):
        self.__mod = mod
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
    def bruit(self):
        return self.__bruit
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
    @pyqtSlot()
    def bruitGaussien(self):
        """
        Energy  = np.linalg.norm(self.__mod) ** 2
        noiseEnter = Energy / (10**(self.__snr / 10))
        noiseVar = Energy / (len(self.__mod) - 1)
        noiseStd = np.sqrt(noiseVar)
        """
        noise = self.__var * np.random.randn(len(self.__mod))
        self.__bruit = list(noise)
        noisySig = self.__mod + noise
        self.__t = list(np.arange(0,len(self.__bits),0.01))
        self. __out = list(noisySig)
