import os
import csv
import Tkinter
import tkFileDialog
import copy
import re
import math
import numpy
import scipy
import timeit
from scipy.optimize import curve_fit




setup = """

import os
import csv
import Tkinter
import tkFileDialog
import copy
import re
import math
import numpy
import scipy
import timeit
from scipy.optimize import curve_fit


def func(x, a, b):
	return a * x + b

def squartest(x):
	sum = 0
	for n in x:
		sum += n
	return sum


def spcurvefit(fun, x, y):
	return curve_fit(fun, x, y)

def curvefit(bnbvar):
	sumbo = 0
	sumbo2 = 0
	sumbr = 0
	sumbr2 = 0
	sumbobr = 0
	for item in bnbvar:
		sumbo += float(item[1])
		sumbo2 += float(item[1])**2
		sumbr += float(item[2])
		sumbr2 += float(item[2])**2
		sumbobr += float(item[1])*float(item[2])

	n = len(bnbvar)

	m = ((n*sumbobr)-(sumbo*sumbr))/((n*sumbo2)-(sumbo**2))

	b = (sumbr-(m*sumbo))/n

	return list([m, b])	

#print "Choose your input file: "
root = Tkinter.Tk()
root.withdraw()
filename = tkFileDialog.askopenfilename(parent=root)

reader = csv.reader(open(filename), delimiter=',')

brainandbody = []

for row in reader:
	brainandbody.append(row)

brainandbody.remove(brainandbody[0])	

x = []
y = []

for row in brainandbody:
	x.append(float(row[1]))
	y.append(float(row[2]))

nx = numpy.array(x)
ny = numpy.array(y)



"""


n = 100
t = timeit.Timer("x = copy.copy(brainandbody); curvefit(x)", setup=setup)
print 'n is ', n,  ' curvefit with list: ', t.timeit(n)
t = timeit.Timer("x = copy.copy(numpy.array(brainandbody)); curvefit(x)", setup=setup)
print 'n is ', n,  ' curvefit with numpy array: ', t.timeit(n)
#t = timeit.Timer("x = list([copy.copy(nx), copy.copy(ny)]); spcurvefit(func, x[0], x[1])", setup=setup)
t = timeit.Timer("x = nx; y = ny; spcurvefit(func, x, y)", setup=setup)
print 'n is ', n, ' spcurvefit with numpy array: ', t.timeit(n)

#------------------------------------------------------------------------------------
# Now to run this on a few functions
#------------------------------------------------------------------------------------

def func(x, a, b):
	return a * x + b

def funcgauss(x, a, b, c):
	return a*numpy.exp(-(x-b)**2/(2*c**2))

print "Choose your input file: "
root = Tkinter.Tk()
root.withdraw()
filename = tkFileDialog.askopenfilename(parent=root)

reader = csv.reader(open(filename), delimiter=',')

brainandbody = []

for row in reader:
	brainandbody.append(row)

brainandbody.remove(brainandbody[0])	

x = []
y = []

for row in brainandbody:
	x.append(float(row[1]))
	y.append(float(row[2]))

nx = numpy.array(x)
ny = numpy.array(y)

# Linear Fit------------

m = str(curve_fit(func, x, y)[0][0])
b = str(curve_fit(func, x, y)[0][1])

print "The best fit equation for this data is: brainsize = " + m + "*bodysize" + " + " + b

# Gaussian profile------

a = str(curve_fit(funcgauss, x, y)[0][0])
mean = str(curve_fit(funcgauss, x, y)[0][1])
sd = str(curve_fit(funcgauss, x, y)[0][2])

print "the best fit Gaussian profile for this data has a mean of " + mean + ", a standard deviaion of " + sd + "and an a value of " + a

