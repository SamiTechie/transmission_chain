import numpy  as np
import matplotlib.pyplot as plt
def step(out,inp = None):
    Ts = out[1]
    data = out[0]
    t = Ts * np.arange(len(data))
    plt.arrow(0,0,0,3.9,head_width=0.1, head_length=0.1, fc='k', ec='k')
    plt.arrow(0,2,t[-1]+0.05,0,head_width=0.1, head_length=0.1, fc='k', ec='k')
    if inp:
        for i in range(len(inp)+1):
            plt.axvline(i,linestyle='dashed',color="k",linewidth=0.7)
        for i,bit in enumerate(inp):
            i+=0.4
            plt.text(i,3.5, str(bit))
    plt.text(-0.2,4.1,'e(t)');
    plt.text(t[-1]+0.2,1.95,'Time');
    plt.step(t,np.array(data)+2,where="post",color="red",linewidth=3)
    plt.ylim([0,4])
    plt.show()
