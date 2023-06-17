import matplotlib.pyplot as plt
import draw
import linecode
import filtreemission

e = [1,0,0,1,0,1,1]
out = linecode.nrz(e)
#draw.step(out,inp = e) 
(t,y) = filtreemission.filtreIdeal(out)
(t,y) = filtreemission.filreCosin(out,alpha = 0.5)
plt.plot(t,y)
plt.show()
