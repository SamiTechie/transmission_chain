from math import pi,sin
import numpy as np 
from PyQt5.QtCore import pyqtSignal,pyqtSlot,pyqtProperty,QObject
class Output(QObject):
    def __init__(self):
        QObject.__init__(self,parent=None)
        self.__out = []
        self.__bits = []
        self.__inp = []
        self.__error = 0
    @pyqtSlot(result=float)
    def error(self):
        return self.__error
    @pyqtSlot(list)
    def setBits(self,bits):
        self.__bits = bits
    @pyqtSlot(list)
    def setInp(self,inp):
        self.__inp = inp
    @pyqtSlot()
    def tauxError(self):
        inCorrect = 0
        print(self.__inp,"Inp")
        print(self.__bits,"Out")
        if len(self.__bits) > 0:
            for i in range(len(self.__inp)):
                    if self.__inp[i] != self.__bits[i]:
                        inCorrect += 1
            self.__error = int(inCorrect  / len(self.__bits) * 100)
