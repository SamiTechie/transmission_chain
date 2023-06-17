import numpy as np 
from PyQt5.QtCore import pyqtSignal,pyqtSlot,pyqtProperty,QObject
from math import pi
class LineCode(QObject):
    def __init__(self):
        QObject.__init__(self,parent=None)
        self.__bits = []
        self.__codage = "RZ"
        self.__tm = 0.5
        self.__out = []
        self.__dsp = []
        self.__imp =[]
        self.__f = []
    @pyqtSlot(list)
    def setBits(self,bits):
        self.__bits = bits
    @pyqtProperty(list)
    def bits(self):
        return self.__bits
    def setTm(self,tm):
        self.__tm = tm
    @pyqtProperty(float)
    def tm(self):
        return self.__tm
    @pyqtProperty(list)
    def out(self):
        return self.__out
    @pyqtProperty(list)
    def dsp(self):
        return self.__dsp
    @pyqtProperty(list)
    def imp(self):
        return self.__imp
    @pyqtProperty(list)
    def f(self):
        return self.__f
    @pyqtSlot(str)
    def setCodage(self,codage):
        self.__codage = codage
    @pyqtSlot()
    def applyCodage(self):
        if self.__codage == "NRZ":
            self.nrz()
        elif self.__codage == "RZ":
            self.rz()
        elif self.__codage == "Manchester":
            self.manchester()
    @pyqtSlot()
    def rz(self):
        clk = []
        bits = self.__bits
        for i in bits:
            if(i == 0):
                clk.append(0)
                clk.append(0)
            elif(i == 1):
                clk.append(1)
                clk.append(0)
        self.__out = clk
        self.dspRz()
        self.setTm(0.5)
    @pyqtSlot()
    def nrz(self):
        clk = []
        bits = self.__bits
        for i in bits:
            if(i == 0):
                clk.append(-1)
            elif(i == 1):
                clk.append(1)
        self.__out = clk
        self.setTm(1)
        self.dspNrz()
    def dspRz(self,A=1):
        self.__f = np.arange(-10,10,0.01)
        self.__dsp = list((A**2*1/4)*(np.sinc(pi*self.__f*1/2))**2)
        out = []
        k = np.arange(-10,10,1)
        count = 0
        print(self.__f)
        for f in self.__f:
            if count%100 == 0:
                out.append(A**2/4*np.sinc(pi*(f/2))**2)
            else:
                out.append(0)
            count += 1
        self.__f = list(self.__f)
        self.__imp = list(out)
    def dspNrz(self,A = 1):
        self.__f = list(np.arange(-10,10,0.01))
        self.__dsp = list(A ** 2 * self.__tm*np.sinc(self.__tm*self.__f)**2)
        self.__imp = []
    @pyqtSlot()
    def manchester(self):
        clk = []
        bits = self.__bits
        for i in bits:
            if(i == 0):
                clk.append(-1)
                clk.append(1)
            elif(i == 1):
                clk.append(1)
                clk.append(-1)
            else:
                return None
        self.__out = clk
        self.__tm = 0.5
        self.dspManchester()
        self.__imp = []
    def dspManchester(self,A = 1):
        self.__f = np.arange(-10,10,0.01)
        self.__dsp = list(A**2*self.__tm*np.sinc(self.__tm/2*self.__f)**2*np.sin(self.__tm/2*self.__f)**2)
        self.__f = list(self.__f)
        self.__vect = []
    @pyqtSlot()
    def miller(self):
        clk = []
        bits = self.__bits
        prevI = None
        for i in bits:
            if(i == 0):
                if(prevI == 0):
                        etat =  1 if (clk[-1] == -1) else -1
                        clk.extend([etat,etat])
                        prevI = None
                else:
                    prevI = 0
                    try: 
                        clk.extend([clk[-1],clk[-1]])
                    except:
                        clk.extend([1,1])
            elif(i == 1):
                try: 
                    etat =  1 if (clk[-1] == -1) else -1
                    clk.extend([clk[-1],etat])
                except:
                    clk.extend([-1,1])
                prevI = 1
            else:
                return None
        self.__out = clk
        self.__tm = 0.5
    @pyqtSlot()
    def bipolaire(self):
        bits = self.__bits
        clk = []
        temp =  - 1
        for bit in bits:
            if bit:
                temp = -1 if temp == 1 else 1
                clk.append(temp)
            else:
                clk.append(0)
        self.setOutput(clk)
        self.setTm(1)
