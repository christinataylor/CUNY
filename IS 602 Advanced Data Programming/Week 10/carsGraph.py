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

if __name__ == "__main__":

    #Because of the way I'm sorting, a misplaced data point won't trip up the program.
    #So I used a separate logical test to check if the data is valid.
    #Couldn't think of a way to include this in a try/exclude statement!
    
    try:

        print "Choose your input file"
        root=Tkinter.Tk()
        root.withdraw()
        filename = tkFileDialog.askopenfilename(parent=root)

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
        ax1.bar(ind, buyingcounts, 0.35)
        #http://matplotlib.org/examples/api/barchart_demo.html

        #ax2 = pyplot.plot(randn(50).cumsum(), 'k--')


        #ax1.hist(carfax[:,0], bins=4, color='k', alpha=0.3)
        ax2.scatter(np.arange(30), np.arange(30) + 3 * randn(30))

        #ax1.hist(carfax.buying)

        fig.show()"""
        
        

        """
        if datacheck:

            ##### Question 2a: First 10 items sorted by safety #####

            carfax_q1 = []
            for s in ["low", "med", "high"]:
            	for row in carfax:
            		if row[5] == s:
            			carfax_q1.append(row)

            print "Question 1"
            for n in range(0,10):
            	print carfax_q1[n]

            ##### Question 2b: Last 15 items sorted by maint #####

            carfax_q2 = []
            for s in ["low", "med", "high", "vhigh"]:
            	for row in carfax:
            		if row[1] == s:
            			carfax_q2.append(row)

            print "Question 2"
            for n in range(len(carfax_q2)-6, len(carfax_q2)-1):
            	print carfax_q2[n]

            ##### Question 2c: All Rows that are high or vhigh in fields buying, maint, and safety #####

            carfax_q3 = []
            pattern = '^v?high$'
            for row in carfax:
                if (re.match(pattern, row[0]) is not None and
                    re.match(pattern, row[1]) is not None and 
                    re.match(pattern, row[5]) is not None):
                        carfax_q3.append(row)

            for d in [2, 3, 4, "5more"]:
                for row in carfax:
                    if row[2] == d:
                        carfax_q2.append(row)

            print "Question 3"
            for row in carfax_q3:
                print row


            ##### Question 2d: Save to a file all rows (in any order) that are: 'buying': vhigh, 'maint': med, 'doors': 4, and 'persons': 4 or more #####

            #I've tried this multiple ways and 
            
            print "Choose your output file"

            root=Tkinter.Tk()
            root.withdraw()
            filename_q4 = tkFileDialog.askopenfilename(parent=root)

            fo = open(filename_q4, "w")

            carfax_q4 = []
            for row in carfax:
                if row[0] == "vhigh" and row[1] == "med" and row[2] == "4" and (row[3] == "4" or row[3] == "more"):
                    for colnum in range(0, len(row)-2):
                        fo.write(row[colnum])
                        fo.write(",")
                    fo.write(row[len(row)-1])
                    fo.write("\n")

            fo.write("done")
            fo.close()

        else: 

            print "One of your data values is wrong. Try again."

        """

    except IndexError:

        print "Something is wrong with your file, or the data isn't in the correct format. Try again."

    except:

        print "Something new and unexpected happened. Try again."



    


