import os
import csv
import Tkinter
import tkFileDialog
import copy
import re
import math
import numpy
import scipy
from scipy.optimize import curve_fit

def func(x, a, b):
	return a * x + b


if __name__ == "__main__":

	print "Choose your input file: "
	root = Tkinter.Tk()
	root.withdraw()
	filename = tkFileDialog.askopenfilename(parent=root)

	reader = csv.reader(open(filename), delimiter=',')

	brainandbody = []

	for row in reader:
		brainandbody.append(row)

	brainandbody.remove(brainandbody[0])

	brainandbody = numpy.array(brainandbody)

	x = []
	y = []

	for row in brainandbody:
		x.append(float(row[1]))
		y.append(float(row[2]))

	m = str(curve_fit(func, x, y)[0][0])
	b = str(curve_fit(func, x, y)[0][1])

	print "The best fit equation for this data is: brainsize = " + m + "*bodysize" + " + " + b






	