import matplotlib.pyplot as plt
import numpy as np
from PyQt5.QtCore import pyqtSlot,QObject,pyqtSignal,QSize

class Plot(QObject):
    def __init__(self,imageProvider):
        QObject.__init__(self,parent=None)
        self.imageProvider = imageProvider
        self.axes = []
    @pyqtSlot(int)
    def add_plot(self,num):
        figure = self.imageProvider.addFigure(str(num), figsize=(5,5))
        self.axes.append(figure.add_subplot(1,1,1))
    def get_plot(self,num):
        num = num - 1
        return self.axes[num]
    @staticmethod
    def draw_axes(ax,t):
        try:
            ax.arrow(0,0,0,1.4,head_width=0.04, head_length=0.04, fc='k', ec='k')
            ax.arrow(0,0,t[-1]+0.05,0,head_width=0.04, head_length=0.03, fc='k', ec='k')
            ax.text(t[-1] -0.02,-0.2,'t');
            ax.text(0,1.6,'e(t)');
        except:
            pass
    @staticmethod
    def draw_text(data):
        for i in range(len(data)+1):
            ax.axvline(i,linestyle='dashed',color="k",linewidth=0.7)
    @staticmethod
    def draw_data(data,t,ax):
        for i,bit in enumerate(data):
            i+=0.4
            #ax.text(i,1.5, str(bit))
    @pyqtSlot(list, float,str,int)
    def draw(self,data,T,title,ax):
        try: 
            data.append(data[-1])
        except:
            pass
        ax = self.get_plot(ax)
        ax.cla()
        ax.set_title(title)
        t = T * np.arange(len(data))
        if len(data):
            self.draw_axes(ax,t)
        Plot.draw_data(data,t,ax)
        ax.step(t, np.array(data), where = "post",color = "red",linewidth = 3)
        ax.set_yticks([-1,0,1,2])
        #ax.ylim([0,4])
    @pyqtSlot(list,list,str,int)
    def dsp(self,dsp,f,title,ax):
        ax = self.get_plot(ax)
        ax.cla()
        ax.set_title(title)
        ax.plot(f,dsp)
    @pyqtSlot(list,list,int)
    def stem(self,f,vect,ax):
        if len(vect) and len(f):
            print(vect,f)
            ax = self.get_plot(ax)
            vect[vect == 0] = np.nan;
            markerline, stemlines, baseline = ax.stem(f,vect,basefmt="m")
            markerline.remove()
            baseline.remove()

