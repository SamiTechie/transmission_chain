from math import pi,sin
import numpy as np 
from PyQt5.QtCore import pyqtSignal,pyqtSlot,pyqtProperty,QObject
class Filtrereceiption(QObject):
    def __init__(self):
        QObject.__init__(self,parent=None)
        self.__code = []
        self.__tm = 1
        self.__out = []
        self.__dsp = []
        self.__bits = []
        self.__code =[]
        self.__f = []
        self.__t = []
        self.__inp = []
        self.__alpha = 0
        self.__bits = []
        self.__dspCode = []
    @pyqtSlot(list)
    def setBits(self,bits):
        self.__bits = bits
    @pyqtSlot(list)
    def setCode(self,code):
        self.__code = code
    @pyqtSlot(float)
    def setAlpha(self,alpha):
        self.__alpha = alpha
    @pyqtSlot(list)
    def setInp(self,inp):
        self.__inp = inp
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
    @pyqtSlot(float)
    def filtreNyquist(self,B = 1/2):
        tb = self.__tm
        codes = self.__code
        self.__t = np.arange(-4,4,0.01)
        out = []
        B = B/tb
        out = []
        def ge(t):
            return 2*B*np.sinc(2 * pi * B * t)
        for t in self.__t:
            sumk = 0
            for k in range(len(codes)):
                sumk +=  codes[k] * ge(t - k * tb)
            out.append(sumk)
        self.__t = list(self.__t)
        self.__out = out
    @pyqtSlot(float)
    def filreCosinDsp(self):
        tb = self.__tm
        alpha = self.__alpha
        codes = self.__code
        #self.__f = np.arange(-4,4,0.01)
        self.__f = np.arange(-10,10,0.01)
        filtre = []
        for i in self.__f:
            i = abs(i)
            if i >= (1 - alpha) / (2 * tb) and i <= (1 + alpha) / (2 * tb):
                res = (tb/2) * (1 - sin( (pi/(2 * alpha)) * (2 * abs(i)*tb - 1)))
                filtre.append(res)
            elif i <= (1 - alpha) / (2 * tb) and i >= 0:
                filtre.append(tb)
            else:
                filtre.append(0)
        self.__f = list(self.__f)
        self.__dsp = np.array(filtre) *  np.array(self.__dspCode)
        self.__dsp = list(self.__dsp)
    def filtreBlach(self):
        out = []
        for bit in self.__code:
            bit = np.array(bit)
            i = np.zeros_like(np.arange(0,self.__tm,0.01))
            i[0]=bit
            out.extend(i)
        out = abs(np.array(out)) * np.array(self.__inp)
        return out
    @pyqtSlot()
    def filreCosin(self):
        out = self.filtreBlach()
        if len(out)>0:
            self.__out = list(out)
            self.__out = list(self.__inp)
            alpha = self.__alpha
            self.__t = np.arange(0,len(self.__bits),0.01)
            te = np.arange(-len(self.__bits)/2,len(self.__bits)/2,0.01)
            filtre = np.sinc(( pi * te) / self.__tm) * np.cos((pi * alpha * te)/self.__tm) / ( 1 - ((2* alpha * te) / self.__tm) ** 2)
            self.__t = list(self.__t)
            self.__out = list(np.convolve(out,filtre,'same'))
            self.__out = list(self.__out)
        else:
            self.__out = []
            self.__t = []
        #self.__out = list(filtre)
        #self.filreCosinDsp(alpha)
