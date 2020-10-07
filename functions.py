import numpy as np
#vectorize functions
def function(func):
    return np.vectorize(func)

#---------------------------define functions------------------------------------------#

#the heaviside defined
def heaviside(x):
    if x >= 0:
        return 1
    else:
        return 0
# the sign defined
def signd(x):
    if x > 0:
        return 1
    if x == 0:
        return 0
    if x < 0:
        return -1
#---------------------------------actual functions----------------------------------------#
#this is the unit step function
def u(x):
    u = function(heaviside)
    return u(x)
# the sign function
def sign(x):
    f = function(signd)
    return f(x)

# check linear
def linear(Tr):
    t = np.linspace(-5,5,100)
    x1 = lambda t: np.sin(t)
    x2 = lambda t: (t % (2*np.pi))/np.pi
    x1plusx2 = lambda t: x1(t)+x2(t)
    Trx1plusTrx2= lambda t: Tr(x1)(t) + Tr(x2)(t)
    
    return np.array_equal(Tr(x1plusx2)(t),Trx1plusTrx2(t))

def Tr(x):
    return lambda t: 2 * x(t+1)

# check causal systems
def causal (Tr):
    t = np.linspace(-5,0,100)
    x = lambda t: (t>=0).astype(float)
    i = 0
       # this checks if Tr(x)(t) starts before 0
    while (x(t)[i]) != 1:
        if(Tr(x)(t)[i] > x(t)[i]):
            return False
        i +=1
    return True

def lti (Tr):
    if (linear(Tr)== True and causal(Tr) == True):
        return True
    else:
        return False

def fourierHarmonic(sample):
    ck =[]
    harmonic = []
    for c in range(len(sample)):
        for i in range(len(sample)):
            ck.append(sample[i]*np.exp(-1j*((2*np.pi)/len(sample))*c*i))
        harmonic.append(sum(ck))
        ck = []
    return harmonic

def pretty(harmonicArray):
    for i in range(len(harmonicArray)):
        harmonicArray[i]=round(harmonicArray[i].real, 2) + round(harmonicArray[i].imag,2) * 1J
    return harmonicArray

def absolute(harmonicArray):
    absolute = []
    for i in range(len(harmonicArray)):
        absolute.append(np.sqrt(harmonicArray[i].real**2 + harmonicArray[i].imag**2))
    return absolute

def phase(harmonicArray):
    phase = []
    for i in range(len(harmonicArray)):
        phase.append(np.arctan(harmonicArray[i].imag/harmonicArray[i].real) * -1)
    return phase
