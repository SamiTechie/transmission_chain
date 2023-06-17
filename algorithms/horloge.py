from math import pi,sin
import numpy as np 
from PyQt5.QtCore import pyqtSignal,pyqtSlot,pyqtProperty,QObject
class Horloge(QObject):
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
    def setCode(self,code):
        self.__code = code
    @pyqtSlot(list)
    def setInp(self,inp):
        self.__inp = inp
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
    @pyqtSlot()
    def recupHorloge(self):
        tb = self.__tm
        codes = self.__code
        out = []
        t = 0
        pas = int(self.__tm/0.01)
        n = len(codes)
        c = 0
        while  len(out) < len(codes):
            out.append(c%2 == 0)
            t  = t + pas
            c = c + 1
        self.__out =list(out)
