import os
import csv
import Tkinter
import tkFileDialog
import copy
import re
import pandas as pd

def quotesubstringfun(lin, count):
	if lin.find("\"") == -1:
		return count
	else: 
		count = count + 1
		usedlin = copy.copy(lin[lin.find("\"")+1:])
		return quotesubstringfun(usedlin, count)


print "Choose your input file"
root=Tkinter.Tk()
root.withdraw()
filename = tkFileDialog.askopenfilename(parent=root)

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

for row in date:
	day.append(row[1:2])
	hour.append(row[4:5])
	minute.append(row[7:8])
	second.append(row[10:11])

df = pd.DataFrame({ 'Host' : host,
					'Date' : date,
					'Request' : request,
					'HTTP' : http,
					'Bytes' : bytes,
					'Day' : day,
					'Hour' : hour,
					'Minute' : minute,
					'Second' : second})


# Which hostname or IP Address made the most requests?

df1 = copy.copy(df).groupby('Host').count().sort('Date')
df1.reset_index(inplace=True)

print "The hostname that made the most requests was " + str(df1['Host'][len(df1)-1])

# Which hostname or IP Address received the most total bytes from the server? How many bytes
# did it receive?

df2 = copy.copy(df).groupby('Host').sum().sort('Bytes')
df2.reset_index(inplace=True)

print "The hostname that received the most total bytes was " + str(df2['Host'][len(df2)-1])
print "The hostname received " + str(df2['Bytes'][len(df2)-1]) + " bytes."

#During what hour was the server the busiest in terms of request?

df3 = copy.copy(df).groupby(['Day', 'Hour']).count().sort()
df3.reset_index(inplace=True)

print "The hour that the server was the busiest in terms of requests was hour " + str(df3['Hour'][len(df3)-1])
print "on day " + str(df3['Day'][len(df3)-1])

# Which .gif image was downloaded the most during the day?

df4 = copy.copy(df)[df['Request'].str.contains("gif")]
df4 = df4.groupby(['Request']).count().sort()
df4.reset_index(inplace=True)

print "The most download gif was from request: " + str(df4['Request'][len(df4)-1])

#What HTTP reply codes were sent other than 200?

# df5 = copy.copy(df)[df['HTTP'] != 200]
# I'm not sure why this isn't working...

print "The other HTTP reply codes that were sent other than 200 were " + str(df.HTTP.unique()[1:])