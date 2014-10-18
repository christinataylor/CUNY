import numpy
import copy

def sortwithloops(L):
    while True:
        count = 0
        for n in range(0, len(L)-1):
            if L[n] > L[n+1]:
                L[n], L[n+1] = L[n+1], L[n]
            else:
                count = count + 1

        if count == len(L) - 1:
            break

    return L #return a value

def sortwithoutloops(L): 
    return sorted(L) #return a value

def sortwithnumpy(L): 
	return numpy.sort(L)

def searchwithloops(L, v):
    for n in L:
        if n == v:
            truthvalue = True
            break
        else:
            truthvalue = False
    return truthvalue  #return a value

def searchwithoutloops(L, v):
    return v in L

def searchwithnumpy(L, v):
    if numpy.where(L == v)[0].size == 0:
        return False
    else: 
        return True
