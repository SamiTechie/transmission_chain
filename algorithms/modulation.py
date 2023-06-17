from math import pi,sin,cos
import numpy as np 
from PyQt5.QtCore import pyqtSignal,pyqtSlot,pyqtProperty,QObject
class Modulation(QObject):
    def __init__(self):
        QObject.__init__(self,parent=None)
        self.__code = []
        self.__tm = 0
        self.__mod = "ASK"
        self.__out = []
        self.__dsp = []
        self.__fp = 2
        self.__A = 1
        self.__phi = 0
        self.__f = []
        self.__t = []
        self.__dspCode = []
        self.__bits = []
    @pyqtSlot(str)
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
    @pyqtSlot(str)
    def setMod(self,mod):
        self.__mod = mod
    @pyqtSlot(float)
    def setFp(self,fp):
        self.__fp = fp
    @pyqtSlot(float)
    def setA(self,A):
        self.__A = A
    @pyqtSlot(float)
    def setPhi(self,phi):
        self.__phi = phi
    @pyqtSlot()
    def applyMod(self):
        if self.__mod == "ASK":
            self.ask()
        elif self.__mod == "BPSK":
            self.bpsk()
        elif self.__mod == "BFSK":
            self.bfsk()
    @pyqtProperty(list)
    def f(self):
        return self.__f
    def rect(self):
        out = []
        for bit in self.__code:
            arr = bit * np.ones_like(np.arange(0,self.__tm,0.01))
            out.extend(arr)
        return out
    """
    def low_pass_filter(self,adata, bandlimit=1000, sampling_rate = 4500):
        adata = np.array(adata)
        bandlimit_index = int(bandlimit * len(adata) / sampling_rate)
    
        fsig = np.fft.fft(adata)
        
        for i in range(bandlimit_index + 1, len(fsig)):
            fsig[i] = 0
            
        adata_filtered = np.fft.ifft(fsig)
    
        return np.real(adata_filtered)
    """
    def ask(self):
        tb = self.__tm
        self.__t = np.arange(0,len(self.__bits),0.01)
        out = np.array(self.__code) * np.cos(2 * pi * self.__fp *self.__t) * self.__A
        out = [v/2 if v < 0 else v for v in out]
        self.__t = list(self.__t)
        self.__out = out
    def bpsk(self):
        tb = self.__tm
        self.__t = np.arange(0,len(self.__bits),0.01)
        out = []
        for i in range(len(self.__t)):
            if self.__code[i] <= 0:
                out.append(self.__code[i] * cos(2 * pi * self.__fp * self.__t[i] - self.__phi))
            else:
                out.append(self.__code[i] * cos(2 * pi * self.__fp * self.__t[i] + self.__phi))
        self.__t = list(self.__t)
        self.__out = list(out)
    def bfsk(self):
        tb = self.__tm
        self.__t = np.arange(0,len(self.__bits),0.01)
        out = []
        for i in range(len(self.__t)):
            if self.__code[i] <= 0:
                out.append(self.__code[i] * abs(cos(2 * pi * (self.__fp + self.__fp* 0.25) * self.__t[i])))
            else:
                out.append(self.__code[i] * abs(cos(2 * pi * (self.__fp - self.__fp*0.25) * self.__t[i])))
        self.__t = list(self.__t)
        self.__out = list(out)
