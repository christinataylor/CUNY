import os
import csv
import Tkinter
import tkFileDialog
import copy
import re
import matplotlib.pyplot as pyplot
import pandas as pd
import numpy as np
from numpy.random import randn
import math
import scipy as sp
from scipy.optimize import curve_fit
import scipy.ndimage as ndimage
import scipy.misc as misc
import skimage.filter as skif
import skimage.morphology as morph
import matplotlib.pyplot as mpl
import skimage.feature as feature
import pylab
import mahotas
import pymorph
from skimage.filter import canny
import matplotlib
import datetime
from matplotlib.dates import DayLocator, HourLocator, DateFormatter, drange

"""
Question 1 : 
Graph the cars data in a bar graph with 4 subplots
"""


#print "Choose your input file"
#root=Tkinter.Tk()
#root.withdraw()
#filename = tkFileDialog.askopenfilename(parent=root)
filename = 'cars_data.csv'

reader = csv.reader(open(filename), delimiter=',')
carfax = []
for row in reader:
    carfax.append(row)

datacheck = True

for row in carfax:
    if (not (row[0] in ["vhigh", "high", "med", "low"] and
        row[1] in ["vhigh", "high", "med", "low"] and
        row[2] in ["2", "3", "4", "5more"] and
        row[3] in ["2", "4", "more"] and
        row[4] in ["small", "med", "big"] and
        row[5] in ["low", "med", "high"] and
        row[6] in ["acc", "unacc", "good", "vgood"])):

            datacheck = False
            break
carfax = np.array(carfax)

carfaxdf = pd.DataFrame({ 'buying' : carfax[:,0],
                          'maint' : carfax[:,1],
                          'doors' : carfax[:,2],
                          'persons' : carfax[:,3],
                          'lug__boot' : carfax[:,4],
                          'safety' : carfax[:,5],
                          'car_acceptability' : carfax[:,6] })

buyingdict = { 'vhigh' : len(carfaxdf.buying[carfaxdf.buying=='vhigh']),
             'high' : len(carfaxdf.buying[carfaxdf.buying=='high']),
             'med' : len(carfaxdf.buying[carfaxdf.buying=='med']),
             'low' : len(carfaxdf.buying[carfaxdf.buying=='low'])}

maintdict = { 'vhigh' : len(carfaxdf.maint[carfaxdf.maint=='vhigh']),
              'high' : len(carfaxdf.maint[carfaxdf.maint=='high']),
              'med' : len(carfaxdf.maint[carfaxdf.maint=='med']),
              'low' : len(carfaxdf.maint[carfaxdf.maint=='low'])}

safetydict = { 'high' : len(carfaxdf.safety[carfaxdf.safety=='high']),
               'med' : len(carfaxdf.safety[carfaxdf.safety=='med']),
               'low' : len(carfaxdf.safety[carfaxdf.safety=='low'])}

doorsdict = { '2' : len(carfaxdf.doors[carfaxdf.doors=='2']),
              '3' : len(carfaxdf.doors[carfaxdf.doors=='3']),
              '4' : len(carfaxdf.doors[carfaxdf.doors=='4']),
              '5more' : len(carfaxdf.doors[carfaxdf.doors=='5more'])}


fig = pyplot.figure()
ax1 = fig.add_subplot(2,2,1)
ax2 = fig.add_subplot(2,2,2)
ax3 = fig.add_subplot(2,2,3)
ax4 = fig.add_subplot(2,2,4)

ind = np.arange(4)
ind3 = np.arange(3)

width = 0.35

buyingcounts = [buyingdict['vhigh'], buyingdict['high'], buyingdict['med'], buyingdict['low']]

ax1.bar(ind, buyingcounts, width)
ax1.set_title('Buying Price Rating')
ax1.set_ylabel('Count')
ax1.set_xticklabels(carfaxdf.buying.unique())
ax1.set_xticks(ind+width)

maintcounts = [maintdict['vhigh'], maintdict['high'], maintdict['med'], maintdict['low']]

ax2.bar(ind, maintcounts, width)
ax2.set_title('Maintenance Price Rating')
ax2.set_ylabel('Count')
ax2.set_xticklabels(carfaxdf.maint.unique())
ax2.set_xticks(ind+width)

safetycounts = [safetydict['high'], safetydict['med'], safetydict['low']]

ax3.bar(ind3, safetycounts, width)
ax3.set_title('Safety Rating')
ax3.set_ylabel('Count')
ax3.set_xticklabels(carfaxdf.safety.unique())
ax3.set_xticks(ind3+width)

doorscounts = [doorsdict['2'], doorsdict['3'], doorsdict['4'], doorsdict['5more']]

ax4.bar(ind, doorscounts, width)
ax4.set_title('Number of Doors')
ax4.set_ylabel('Count')
ax4.set_xticklabels(carfaxdf.doors.unique())
ax4.set_xticks(ind+width)

fig.show()


"""
Question 2 : 
Graph regression data from homeworks 5 and 7
"""


#root = Tkinter.Tk()
#root.withdraw()
#filename = tkFileDialog.askopenfilename(parent=root)
filename = 'brainandbody.csv'

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

nx = np.array(x)
ny = np.array(y)

def funcgauss(x, a, b, c):
	return a*np.exp(-(x-b)**2/(2*c**2))

a = curve_fit(funcgauss, nx, ny)[0][0]
mean = curve_fit(funcgauss, nx, ny)[0][1]
sd = curve_fit(funcgauss, nx, ny)[0][2]

fx = np.arange(-20000, 100000, 2000)
fy = funcgauss(fx, a, mean, sd)

fig, ax = pyplot.subplots()
ax.scatter(nx, ny)
ax.plot(fx, fy)
ax.set_title('The Brain and Body Rule')
ax.set_ylabel('Brain Size')
ax.set_xlabel('Body Size')

fig.show()


"""
Question 3 : 
display the center points of the objects image in homework 8
"""

raw_objects = misc.imread('objects.png')
img_objects = ndimage.gaussian_filter(raw_objects, 3)
thres_objects = img_objects > img_objects.mean()
seeds_objects, nr_objects = ndimage.label(thres_objects)
centers_objects = ndimage.center_of_mass(thres_objects, seeds_objects, range(1, nr_objects +1, 1))
centers_objects = np.array(centers_objects)
centers_objects = centers_objects[:,[0,1]]

fig = pyplot.figure()
ax = fig.add_subplot(111)
ax.imshow(raw_objects)
ax.scatter(centers_objects[:,1],centers_objects[:,0],s=80)
#pylab.imshow(pymorph.overlay(raw_objects, centers_objects))
#pylab.show()
fig.show()

"""
Question 4 : 
Graph the hour by hour change in number of server requests
from homework 9
"""

def quotesubstringfun(lin, count):
  if lin.find("\"") == -1:
    return count
  else: 
    count = count + 1
    usedlin = copy.copy(lin[lin.find("\"")+1:])
    return quotesubstringfun(usedlin, count)


#print "Choose your input file"
#root=Tkinter.Tk()
#root.withdraw()
#filename = tkFileDialog.askopenfilename(parent=root)
filename = "epa-http.txt"

reader = open(filename)
cleanlist = []
for row in reader:
    cleanlist.append(row)

host = []
date = []
request = []
http = []
bytes = []


for row in cleanlist:
  host.append(row[:row.find(" ")])
  row = row[row.find(" ")+1:]
  date.append(row[:row.find(" ")])
  row = row[row.find(" ")+1:]
  if quotesubstringfun(row,0) == 2:
    request.append(row[1:row[1:].find("\"")+1])
    row = row[row[1:].find("\"")+3:]
  else:
    row.find("\"")
    row1 = row[1:row[1:].find("\"")+2]
    row2 = row[row[1:].find("\"")+2:]
    rowfull = row1 + row2[:row2.find("\"")]
    request.append(rowfull)
    row = row2[row2.find("\"")+2:]
  http.append(row[:row.find(" ")])
  row = row[row.find(" ")+1:]
  bytes.append(row[:row.find("\n")])

day = []
hour = []
minute = []
second = []
dtime = []
dtimehour = []

for row in date:
  day.append(int(row[1:3]))
  hour.append(int(row[4:6]))
  minute.append(int(row[7:9]))
  second.append(int(row[10:12]))
  dtime.append(datetime.datetime(1995, 8, int(row[1:3]), int(row[4:6]), int(row[7:9]), int(row[10:12])))
  dtimehour.append(datetime.datetime(1995, 8, int(row[1:3]), int(row[4:6]), 0, 0))

df = pd.DataFrame({ 'Host' : host,
          'Date' : date,
          'Request' : request,
          'HTTP' : http,
          'Bytes' : bytes,
          'Day' : day,
          'Hour' : hour,
          'Minute' : minute,
          'Second' : second,
          'DateTime' : dtime,
          'DateTimeHour' : dtimehour})

dfgraph = copy.copy(df).groupby('DateTimeHour').count()
dfgraph.reset_index(inplace=True)

a = []
for row in dfgraph.DateTimeHour:
  a.append(row)

rawdates = []

for row in a:
  rawdates.append(datetime.datetime(row.year, row.month, row.day, row.hour, row.minute, row.second))

hloc = HourLocator()
hfmt = DateFormatter('%H')

fig, ax = pyplot.subplots()
ax.plot(rawdates, dfgraph.Host)
ax.set_title('EPA Site Hits Per Hour')
ax.set_ylabel('Number of Hits')
ax.set_xlabel('Hour')

fig.show()
