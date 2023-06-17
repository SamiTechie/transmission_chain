import numpy as np
def rect(ts,A = 1,pas = 0.001):
    t = np.arange(0,ts,pas)
    return A*np.ones_like(t)
def dsp(bits):
    ts = bits[1]
    data = bits[0]
    out = []
    for  bit in data:
        out.extend(bit * rect(ts))
    return out
print(dsp(([1,0],1)))
