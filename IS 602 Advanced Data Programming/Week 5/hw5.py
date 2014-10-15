import os
import csv
import Tkinter
import tkFileDialog
import copy
import re
import math

if __name__ == "__main__":

	print "Choose your input file"
	root=Tkinter.Tk()
	root.withdraw()
	filename = tkFileDialog.askopenfilename(parent=root)

	reader = csv.reader(open(filename), delimiter=',')

	brainandbody = []

	for row in reader:
		brainandbody.append(row)

	brainandbody.remove(brainandbody[0])

	for row in brainandbody:
		row[1] = float(row[1])
		row[2] = float(row[2])

	sumbo = 0
	sumbo2 = 0
	sumbr = 0
	sumbr2 = 0
	sumbobr = 0

	for item in brainandbody:
		sumbo += item[1]
		sumbo2 += math.pow(item[1],2)
		sumbr += item[2]
		sumbr2 += math.pow(item[2],2)
		sumbobr += item[1]*item[2]

	n = len(brainandbody)

	m = ((n*sumbobr)-(sumbo*sumbr))/((n*sumbo2)-(math.pow(sumbo,2)))

	b = (sumbr-(m*sumbo))/n

	print "The best fit equation for this data is: brainsize = " + str(m) + "*bodysize" + " + " + str(b)







