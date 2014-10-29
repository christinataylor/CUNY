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