from math import pi,sin
import numpy as np 
from PyQt5.QtCore import pyqtSignal,pyqtSlot,pyqtProperty,QObject
class Decision(QObject):
    def __init__(self):
        QObject.__init__(self,parent=None)
        self.__code = []
        self.__tm = 0.5
        self.__out = []
        self.__dsp = []
        self.__codage = "RZ"
        self.__bits = []
        self.__inp = []
        self.__t = []
    @pyqtSlot(list)
    def setInp(self,inp):
        self.__inp = inp
    @pyqtSlot(str)
    def setCodage(self,codage):
        self.__codage = codage
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
    @pyqtProperty(float)
    def tm(self):
        return self.__tm
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
    def invNrz(self):
        inp = self.__out
        out = []
        for i in range(len(inp)):
                bit = 0 if inp[i] == -1 else 1
                out.append(bit)
        self.__out = out
    def invRz(self):
        inp = self.__out
        out = []
        for i in range(len(inp)):
            if i%2 == 0:
                bit = inp[i] if inp[i] == 1 else 0 
                out.append(bit)
        self.__out = out
    def invManchester(self):
        inp = self.__out
        out = []
        for i in range(len(inp)):
            if i%2 == 1:
                bit =  0 if inp[i] == 1 else 1 
                out.append(bit)
        self.__out = out
    @pyqtSlot()
    def decision(self):
        self.__t = np.arange(0,len(self.__bits))
        tb = self.__tm
        out = []
        t = 0
        codes = self.__code
        pas = int(self.__tm/0.01)
        n = len(codes)
        while  len(out) < len(codes):
            inp = self.__inp[t]
            if  inp > 0.4:
                out.append(1)
            elif inp < -0.4:
                out.append(-1)
            else:
                out.append(0)
            t  = t + pas
        self.__out = out
        if self.__codage == "NRZ":
            self.invNrz()
        elif self.__codage == "RZ":
            self.invRz()
        elif self.__codage == "Manchester":
            self.invManchester()
