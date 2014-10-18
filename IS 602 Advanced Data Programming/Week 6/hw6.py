import timeit
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

setup = """
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


listo = []
ofile = open('C:/users/charley/downloads/courses/cuny/sps/git/is 602 advanced data programming/week 6/small.csv', 'r')
for line in ofile:
    listo.append(int(line))
n1 = numpy.array(listo);
"""


L = [5,3,6,3,13,5,6]
nL = numpy.array(L)

print sortwithloops(L) # [3, 3, 5, 5, 6, 6, 13]
print sortwithoutloops(L) # [3, 3, 5, 5, 6, 6, 13]
print sortwithnumpy(nL)
print searchwithloops(L, 5) #true
print searchwithloops(L, 11) #false
print searchwithoutloops(L, 5) #true
print searchwithoutloops(L, 11) #false
print searchwithnumpy(nL, 5)
print searchwithnumpy(nL, 11)


n = 100
t = timeit.Timer("x=copy.copy(listo); sortwithloops(x)", setup=setup)
print 'n is ', n,  ' sortwithloops: ', t.timeit(n)
t = timeit.Timer("x=copy.copy(listo); sortwithoutloops(x)", setup=setup)
print 'n is ', n,  ' sortwithoutloops: ', t.timeit(n)
t = timeit.Timer("x=copy.copy(listo); sortwithnumpy(x)", setup=setup)
print  'n is ', n, ' sortwithnumpy: ', t.timeit(n)
t = timeit.Timer("x=copy.copy(listo); searchwithloops(x, 1001)", setup=setup)
print 'n is ', n, ' searchwithloops: ', t.timeit(n)
t = timeit.Timer("x=copy.copy(listo); searchwithoutloops(x, 1001)", setup=setup)
print 'n  is ', n, ' searchwithoutloops: ', t.timeit(n)
t = timeit.Timer("x=copy.copy(listo); searchwithnumpy(x, 1001)", setup=setup)
print 'n is ', n, ' searchwithnumpy: ', t.timeit(n)