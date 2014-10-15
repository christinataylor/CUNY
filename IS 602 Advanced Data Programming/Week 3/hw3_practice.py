import Tkinter
import tkFileDialog
import re
import os

##### Homework 3 Scratch #####


    dir = "C:\Users\Charley\Downloads\Courses\CUNY\SPS\IS 602 Advanced Data Programming\Week 3"
    os.chdir(dir)
    f = open("cars_data.csv")

    f = open("C:\Users\Charley\Downloads\Courses\CUNY\SPS\IS 602 Advanced Data Programming\Week 3\cars_data.csv")
    f.tell()


##### Tkinter #####

root=Tkinter.Tk()
root.withdraw()
filename = tkFileDialog.askopenfilename(parent=root)

print filename

##### Regular Expressions #####

pattern = '(?<=abc)def'
data = 'abcdef'

m = re.search(pattern, data)

m.group(0)

##### IO #####

input = raw_input("Enter some input: ")
print "received: ", input

input1 = raw_input("Enter some input: ")
input2 = raw_input("Enter some input: ")
print input1 + input2

dir = "C:\Users\Charley\Downloads\Courses\CUNY\SPS\IS 602 Advanced Data Programming\Week 3"
os.chdir(dir)

f = open("cars_data.csv")

##### print out help #####

print f.closed
f.close()
print f.closed

##### Sorting and named lists #####

showlist = [{'id':1, 'name': 'Sesaeme Street'},{'id':2, 'name':'Dora the Explorer'}]