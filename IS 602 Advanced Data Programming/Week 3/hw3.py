import os
import csv
import Tkinter
import tkFileDialog
import copy
import re


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

    except IndexError:

        print "Something is wrong with your file, or the data isn't in the correct format. Try again."

    except:

        print "Something new and unexpected happened. Try again."



    


